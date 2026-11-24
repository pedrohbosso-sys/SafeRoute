-- SafeRoute: execute no SQL Editor de um projeto Supabase novo.
-- auth.users já armazena e protege a senha; nunca salve senha em public.usuario.
create table if not exists public.usuario (
  id uuid primary key references auth.users(id) on delete cascade,
  nome text not null default '',
  email text not null unique,
  endereco text,
  cargo text,
  created_at timestamptz not null default now()
);

create table if not exists public.local (
  id bigint generated always as identity primary key,
  endereco text not null,
  latitude double precision not null check (latitude between -90 and 90),
  longitude double precision not null check (longitude between -180 and 180),
  created_at timestamptz not null default now()
);

create table if not exists public.ocorrencia (
  id bigint generated always as identity primary key,
  usuario_id uuid not null references public.usuario(id),
  local_id bigint not null references public.local(id),
  tipo text not null check (tipo in ('alagamento', 'enchente', 'obras', 'interdicao', 'outro')),
  descricao text not null default '',
  gravidade integer not null default 1 check (gravidade between 1 and 3),
  foto_url text,
  data_ocorrencia timestamptz not null default now(),
  validade timestamptz not null,
  status text not null default 'ativa' check (status in ('ativa', 'liberada', 'contestada')),
  created_at timestamptz not null default now(),
  constraint validade_posterior check (validade > data_ocorrencia)
);
create index if not exists ocorrencia_ativa_idx on public.ocorrencia(status, validade);
create index if not exists ocorrencia_local_idx on public.ocorrencia(local_id);

create table if not exists public.confirmacao (
  id bigint generated always as identity primary key,
  ocorrencia_id bigint not null references public.ocorrencia(id) on delete cascade,
  usuario_id uuid not null references public.usuario(id),
  confirmada boolean not null,
  descricao text,
  data_confirmacao timestamptz not null default now(),
  unique (ocorrencia_id, usuario_id)
);

create table if not exists public.rota (
  id bigint generated always as identity primary key,
  usuario_id uuid not null references public.usuario(id),
  origem_local_id bigint not null references public.local(id),
  destino_local_id bigint not null references public.local(id),
  distancia_km numeric(10,2) not null check (distancia_km >= 0),
  tempo_estimado_minutos integer not null check (tempo_estimado_minutos >= 0),
  status text not null default 'planejada',
  created_at timestamptz not null default now()
);

create table if not exists public.alerta (
  id bigint generated always as identity primary key,
  rota_id bigint not null references public.rota(id) on delete cascade,
  usuario_id uuid not null references public.usuario(id),
  ocorrencia_id bigint references public.ocorrencia(id),
  descricao text not null,
  data_alerta timestamptz not null default now()
);

create table if not exists public.historico_ocorrencias (
  id bigint generated always as identity primary key,
  local_id bigint not null unique references public.local(id) on delete cascade,
  quantidade_total integer not null default 0,
  quantidade_confirmadas integer not null default 0,
  quantidade_contestadas integer not null default 0,
  ultima_ocorrencia timestamptz,
  descricao text,
  data_atualizacao timestamptz not null default now()
);

create or replace function public.criar_usuario() returns trigger language plpgsql security definer set search_path = '' as $$
begin
  insert into public.usuario(id, nome, email)
  values (new.id, coalesce(new.raw_user_meta_data->>'nome', ''), coalesce(new.email, ''));
  return new;
end; $$;
drop trigger if exists ao_criar_usuario on auth.users;
create trigger ao_criar_usuario after insert on auth.users for each row execute function public.criar_usuario();

create or replace function public.atualizar_historico() returns trigger language plpgsql security definer set search_path = '' as $$
begin
  insert into public.historico_ocorrencias(local_id, quantidade_total, ultima_ocorrencia, data_atualizacao)
  values (new.local_id, 1, new.data_ocorrencia, now())
  on conflict (local_id) do update set
    quantidade_total = public.historico_ocorrencias.quantidade_total + 1,
    ultima_ocorrencia = excluded.ultima_ocorrencia,
    data_atualizacao = now();
  return new;
end; $$;
drop trigger if exists ao_criar_ocorrencia on public.ocorrencia;
create trigger ao_criar_ocorrencia after insert on public.ocorrencia for each row execute function public.atualizar_historico();

create or replace function public.atualizar_confirmacoes() returns trigger language plpgsql security definer set search_path = '' as $$
declare v_local bigint;
begin
  select local_id into v_local from public.ocorrencia where id = new.ocorrencia_id;
  update public.historico_ocorrencias set
    quantidade_confirmadas = (select count(*) from public.confirmacao c join public.ocorrencia o on o.id = c.ocorrencia_id where o.local_id = v_local and c.confirmada),
    quantidade_contestadas = (select count(*) from public.confirmacao c join public.ocorrencia o on o.id = c.ocorrencia_id where o.local_id = v_local and not c.confirmada),
    data_atualizacao = now()
  where local_id = v_local;
  return new;
end; $$;
drop trigger if exists ao_confirmar_ocorrencia on public.confirmacao;
create trigger ao_confirmar_ocorrencia after insert or update on public.confirmacao for each row execute function public.atualizar_confirmacoes();

alter table public.usuario enable row level security;
alter table public.local enable row level security;
alter table public.ocorrencia enable row level security;
alter table public.confirmacao enable row level security;
alter table public.rota enable row level security;
alter table public.alerta enable row level security;
alter table public.historico_ocorrencias enable row level security;

create policy "perfil proprio" on public.usuario for select using (id = auth.uid());
create policy "editar perfil proprio" on public.usuario for update using (id = auth.uid()) with check (id = auth.uid());
create policy "ler locais" on public.local for select to anon, authenticated using (true);
create policy "criar local autenticado" on public.local for insert to authenticated with check (true);
create policy "ler ocorrencias" on public.ocorrencia for select to anon, authenticated using (true);
create policy "publicar ocorrencia propria" on public.ocorrencia for insert to authenticated with check (usuario_id = auth.uid());
create policy "ler confirmacoes" on public.confirmacao for select to anon, authenticated using (true);
create policy "confirmar relato alheio" on public.confirmacao for insert to authenticated with check (usuario_id = auth.uid() and exists (select 1 from public.ocorrencia o where o.id = ocorrencia_id and o.usuario_id <> auth.uid() and o.validade > now() and o.status = 'ativa'));
create policy "atualizar confirmacao propria" on public.confirmacao for update to authenticated using (usuario_id = auth.uid()) with check (usuario_id = auth.uid() and exists (select 1 from public.ocorrencia o where o.id = ocorrencia_id and o.usuario_id <> auth.uid() and o.validade > now() and o.status = 'ativa'));
create policy "ler rotas proprias" on public.rota for select to authenticated using (usuario_id = auth.uid());
create policy "criar rotas proprias" on public.rota for insert to authenticated with check (usuario_id = auth.uid());
create policy "atualizar rotas proprias" on public.rota for update to authenticated using (usuario_id = auth.uid()) with check (usuario_id = auth.uid());
create policy "ler alertas proprios" on public.alerta for select to authenticated using (usuario_id = auth.uid());
create policy "ler historico" on public.historico_ocorrencias for select to anon, authenticated using (true);

insert into storage.buckets (id, name, public)
values ('incident-photos', 'incident-photos', true)
on conflict (id) do nothing;
create policy "ler fotos de ocorrencias" on storage.objects for select to anon, authenticated using (bucket_id = 'incident-photos');
create policy "enviar fotos de ocorrencias" on storage.objects for insert to authenticated with check (bucket_id = 'incident-photos' and (storage.foldername(name))[1] = auth.uid()::text);
create policy "atualizar ocorrencia propria" on public.ocorrencia for update to authenticated using (usuario_id = auth.uid()) with check (usuario_id = auth.uid());
