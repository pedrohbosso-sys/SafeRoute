# SafeRoute
### Navegação inteligente e colaborativa

O **SafeRoute** é uma proposta de aplicativo de navegação colaborativa para Android e iOS, com foco na identificação de alagamentos, enchentes, obras e interdições em vias públicas. Seu objetivo é auxiliar motoristas a identificar trechos comprometidos e encontrar rotas alternativas, contribuindo para deslocamentos mais seguros e eficientes.

O projeto tem como região inicial de atuação os municípios de Americana, Santa Bárbara d’Oeste, Nova Odessa e Sumaré, no estado de São Paulo.

---

## Sumário

1. [Sobre o Projeto](#1-sobre-o-projeto)
2. [Identificação do Problema](#2-identificação-do-problema)
3. [Justificativa](#3-justificativa)
4. [Objetivos](#4-objetivos)
5. [Público-Alvo](#5-público-alvo)
6. [Pesquisa Regional](#6-pesquisa-regional)
7. [Análise de Concorrentes](#7-análise-de-concorrentes)
8. [Funcionamento da Aplicação](#8-funcionamento-da-aplicação)
9. [Requisitos do Sistema](#9-requisitos-do-sistema)
10. [Regras de Negócio](#10-regras-de-negócio)
11. [Tecnologias Propostas](#11-tecnologias-propostas)
12. [Wireframes e Prototipagem](#12-wireframes-e-prototipagem)
13. [Escopo do Projeto](#13-escopo-do-projeto)
14. [Riscos e Desafios](#14-riscos-e-desafios)
15. [Planejamento Inicial](#15-planejamento-inicial)
16. [Fontes de Pesquisa e Referências](#16-fontes-de-pesquisa-e-referências)
17. [Considerações Finais](#17-considerações-finais)

---

## 1. Sobre o Projeto

O **SafeRoute** é uma proposta de aplicativo de navegação que busca ampliar as funcionalidades dos serviços tradicionais de mapas por meio de informações colaborativas sobre as condições das vias públicas.

A aplicação permitirá que motoristas compartilhem informações sobre alagamentos, enchentes, obras e interdições. Esses registros poderão ser visualizados e confirmados por outros usuários, auxiliando na identificação de trechos que possam comprometer a circulação.

A primeira etapa do projeto contempla os seguintes municípios:

- Americana – SP;
- Santa Bárbara d’Oeste – SP;
- Nova Odessa – SP;
- Sumaré – SP.

## 2. Identificação do Problema

Motoristas frequentemente enfrentam dificuldades durante seus deslocamentos devido a situações inesperadas, como:

- Ruas e avenidas alagadas;
- Enchentes causadas por chuvas intensas;
- Obras e reformas nas vias públicas;
- Ruas temporariamente interditadas;
- Falta de informações atualizadas sobre as condições das vias.

Em muitos casos, os motoristas descobrem esses problemas somente ao chegar ao local, ocasionando atrasos, congestionamentos e situações de risco.

**Problema identificado:** dificuldade de encontrar rotas alternativas diante de alagamentos, enchentes e interdições, especialmente em regiões onde essas ocorrências são frequentes.

## 3. Justificativa

O desenvolvimento do SafeRoute justifica-se pela necessidade de melhorar a mobilidade urbana e proporcionar maior segurança aos motoristas.

A proposta utiliza a colaboração entre usuários para compartilhar informações sobre as condições das vias, permitindo que outros motoristas sejam alertados antes de chegar a determinados locais.

Com essas informações, o aplicativo poderá identificar trechos comprometidos e oferecer caminhos alternativos, contribuindo para deslocamentos mais seguros e eficientes.

## 4. Objetivos

### 4.1 Objetivo Geral

Desenvolver um aplicativo de navegação colaborativa capaz de identificar problemas nas vias e oferecer rotas alternativas para evitar regiões com alagamentos, enchentes e obras.

### 4.2 Objetivos Específicos

- Facilitar a localização de destinos;
- Identificar vias com problemas de circulação;
- Permitir que motoristas compartilhem ocorrências;
- Disponibilizar informações atualizadas sobre as condições das vias;
- Calcular rotas alternativas;
- Melhorar a experiência e a segurança dos deslocamentos.

## 5. Público-Alvo

O aplicativo será destinado principalmente a:

- Motoristas de automóveis;
- Motociclistas;
- Trabalhadores que utilizam veículos diariamente;
- Pessoas que circulam frequentemente pelas cidades atendidas.

## 6. Pesquisa Regional

O levantamento inicial identificou regiões que apresentam registros ou relatos de problemas relacionados a alagamentos e enchentes.

### 6.1 Americana

- Avenida Bandeirantes;
- Rua Carioba;
- Rua Bahia;
- Rua Diogo de Faria;
- Região da Avenida Paschoal Ardito.

### 6.2 Santa Bárbara d’Oeste

- Jardim Conceição;
- Vila Sartori;
- Jardim Vista Alegre;
- Jardim Icaraí;
- Região da ponte Roldão Jorge Ferreira.

### 6.3 Nova Odessa

- Regiões próximas ao Ribeirão Quilombo;
- Passagens inferiores de córregos;
- Áreas monitoradas pela Defesa Civil.

### 6.4 Sumaré

- Região da Vila Diva;
- Áreas próximas ao Ribeirão Quilombo.

**Observação:** os locais representam um levantamento preliminar. A confirmação dos pontos, trechos e coordenadas deverá ocorrer durante a pesquisa. O cadastro operacional do aplicativo será alimentado pelos usuários.

## 7. Análise de Concorrentes

Foram considerados aplicativos de navegação já utilizados no mercado, observando suas principais características e funcionalidades.

| Aplicativo | Características |
|---|---|
| Waze | Navegação, informações de trânsito e alertas colaborativos. |
| Google Maps | Mapas, pesquisa de destinos e rotas alternativas. |
| Apple Maps | Navegação e informações de trânsito. |

### 7.1 Diferencial do SafeRoute

O SafeRoute pretende priorizar ocorrências relacionadas a alagamentos, enchentes e obras, oferecendo um sistema de identificação, confirmação e validade dos relatos, integrado ao cálculo de rotas alternativas.

O objetivo não é reproduzir todas as funcionalidades dos concorrentes, mas oferecer uma experiência direcionada à prevenção de problemas durante os deslocamentos.

## 8. Funcionamento da Aplicação

O funcionamento principal será dividido em quatro etapas:

1. **Identificação:** um motorista encontra uma rua alagada, uma enchente ou uma obra.
2. **Registro:** o usuário informa a ocorrência diretamente pelo aplicativo.
3. **Compartilhamento:** a informação aparece no mapa e pode ser confirmada por outros motoristas.
4. **Redirecionamento:** o sistema considera o trecho comprometido e procura uma rota alternativa.

As ocorrências deverão conter localização, categoria, horário e prazo de validade, evitando que informações antigas continuem interferindo no cálculo das rotas.

## 9. Requisitos do Sistema

### 9.1 Requisitos Funcionais

| Código | Descrição |
|---|---|
| RF01 | Permitir cadastro de usuários. |
| RF02 | Permitir login e logout. |
| RF03 | Exibir mapa com localização atual. |
| RF04 | Permitir pesquisa de endereços e destinos. |
| RF05 | Calcular rotas entre origem e destino. |
| RF06 | Exibir rotas alternativas. |
| RF07 | Permitir iniciar e encerrar navegação. |
| RF08 | Identificar pontos de alagamento. |
| RF09 | Identificar regiões com enchentes. |
| RF10 | Identificar obras e interdições. |
| RF11 | Permitir registrar ocorrências. |
| RF12 | Registrar localização e horário das ocorrências. |
| RF13 | Permitir confirmar ocorrências. |
| RF14 | Permitir informar que uma via foi liberada. |
| RF15 | Exibir alertas durante a navegação. |
| RF16 | Recalcular rotas para evitar trechos comprometidos. |
| RF17 | Exibir distância e tempo estimado. |
| RF18 | Expirar ocorrências antigas. |
| RF19 | Consultar histórico de ocorrências. |
| RF20 | Permitir denunciar informações incorretas. |

### 9.2 Requisitos Não Funcionais

| Código | Descrição |
|---|---|
| RNF01 | Compatibilidade com Android e iOS. |
| RNF02 | Interface simples e intuitiva. |
| RNF03 | Boa precisão de localização. |
| RNF04 | Atualização das informações em tempo adequado. |
| RNF05 | Proteção dos dados pessoais. |
| RNF06 | Suporte a múltiplos usuários simultaneamente. |
| RNF07 | Estabilidade durante a navegação. |
| RNF08 | Boa legibilidade da interface. |
| RNF09 | Tolerância a falhas de conexão. |
| RNF10 | Segurança na utilização do aplicativo. |

## 10. Regras de Negócio

- **RN01:** somente usuários autenticados poderão publicar ocorrências.
- **RN02:** toda ocorrência deverá possuir categoria e localização.
- **RN03:** toda ocorrência deverá registrar data e horário.
- **RN04:** os usuários poderão confirmar ou contestar relatos.
- **RN05:** ocorrências antigas deverão perder validade automaticamente.
- **RN06:** ocorrências confirmadas terão maior confiabilidade.
- **RN07:** trechos bloqueados deverão ser evitados no cálculo de rotas.
- **RN08:** caso não exista uma rota alternativa segura identificada, o aplicativo deverá informar essa condição.
- **RN09:** o sistema deverá priorizar a segurança do motorista durante a navegação.
- **RN10:** a localização deverá ser utilizada conforme as permissões concedidas pelo usuário.

## 11. Tecnologias Propostas

As tecnologias abaixo representam a proposta inicial para o desenvolvimento do projeto e poderão ser ajustadas conforme as necessidades identificadas durante a implementação.

| Tecnologia | Finalidade |
|---|---|
| Flutter | Desenvolvimento multiplataforma. |
| Dart | Linguagem de programação. |
| Supabase | Backend e autenticação. |
| PostgreSQL | Banco de dados. |
| Mapbox ou Google Maps | Exibição de mapas. |
| GPS | Identificação da localização. |

## 12. Wireframes e Prototipagem

A primeira versão do protótipo deverá apresentar as seguintes telas:

### 12.1 Tela de Login e Cadastro

- Campo de e-mail;
- Campo de senha;
- Botão de login;
- Opção de criar conta.

### 12.2 Tela Inicial

- Mapa interativo;
- Localização atual;
- Campo de pesquisa de destino;
- Identificação de ocorrências;
- Acesso ao perfil.

### 12.3 Tela de Rotas

- Origem e destino;
- Rota principal;
- Rotas alternativas;
- Distância e tempo estimado;
- Botão para iniciar navegação.

### 12.4 Tela de Ocorrências

- Alagamentos;
- Enchentes;
- Obras;
- Interdições;
- Confirmação de ocorrências.

### 12.5 Tela de Registro de Ocorrências

- Seleção do tipo de problema;
- Localização da ocorrência;
- Campo para descrição;
- Opção de enviar o registro.

### 12.6 Protótipo

O protótipo inicial das telas está sendo desenvolvido por meio da ferramenta Stitch.

**Acessar o protótipo:** [SafeRoute — Stitch](https://stitch.google.com/projects/969862646073581713)

## 13. Escopo do Projeto

### 13.1 Primeira Versão (MVP)

A primeira versão do SafeRoute deverá contemplar as funcionalidades essenciais para validar a proposta do aplicativo:

- Cadastro e login;
- Mapa e localização;
- Pesquisa de destinos;
- Cálculo de rotas;
- Registro de ocorrências;
- Confirmação de ocorrências;
- Identificação de vias comprometidas;
- Cálculo de rotas alternativas.

### 13.2 Funcionalidades Futuras

Após a implementação e validação do MVP, poderão ser consideradas as seguintes funcionalidades:

- Integração com Android Auto;
- Integração com Apple CarPlay;
- Comandos por voz;
- Histórico avançado de ocorrências;
- Análise de padrões de alagamentos;
- Expansão para outras regiões.

## 14. Riscos e Desafios

Durante o desenvolvimento, foram identificados desafios que poderão impactar o funcionamento e a confiabilidade da aplicação.

| Desafio | Possível solução |
|---|---|
| Relatos falsos | Sistema de confirmação e reputação. |
| Poucos usuários | Iniciar em uma região limitada. |
| Ocorrências antigas | Validade automática dos relatos. |
| Falta de internet | Armazenamento temporário quando possível. |
| Rotas incorretas | Integração com serviço de roteamento. |
| Segurança ao dirigir | Alertas por áudio e interface simplificada. |

## 15. Planejamento Inicial

**Objetivo:** identificar um problema e definir os requisitos iniciais do projeto.

| Dia | Atividade | Resultado |
|---|---|---|
| Dia 1 | Formação dos grupos e divisão das responsabilidades. | Organização do grupo. |
| Dia 2 | Pesquisa e identificação do problema. | Problema documentado. |
| Dia 3 | Planejamento e definição de requisitos. | Requisitos iniciais. |
| Dia 4 | Desenvolvimento dos wireframes. | Protótipo inicial. |
| Dia 5 | Organização e revisão da documentação. | Entrega final. |

## 16. Fontes de Pesquisa e Referências

Para fundamentar o desenvolvimento do SafeRoute, foram consultadas fontes oficiais das prefeituras de Americana, Santa Bárbara d’Oeste, Nova Odessa e Sumaré, além de informações disponibilizadas pelo Centro Nacional de Monitoramento e Alertas de Desastres Naturais (CEMADEN).

As fontes reúnem documentos técnicos, notícias e registros relacionados a alagamentos, enchentes, drenagem urbana, interdições de vias públicas e ações realizadas pelas Defesas Civis municipais.

Os registros apresentados são utilizados como referências documentais e históricas. A existência de um registro não significa que o local esteja alagado ou interditado atualmente. As condições em tempo real deverão ser verificadas por meio de informações atualizadas e ocorrências confirmadas no aplicativo.

### 16.1 Americana (SP)

- **Plano Municipal de Drenagem de Americana:** documento técnico relacionado às áreas com riscos de inundação e aos problemas de drenagem urbana.  
  [Acessar o documento](https://www.americana.sp.gov.br/legislacao/anexos/lei6049_PlanodeDrenagem.pdf)

- **Monitoramento de áreas atingidas por alagamentos do Ribeirão Quilombo:** notícia sobre os impactos das chuvas e os serviços realizados na Rua Bahia, Avenida Bandeirantes e outras regiões.  
  [Acessar a notícia](https://www.americana.sp.gov.br/americana-index.php?a=noticia&id=37074)

- **Limpeza de áreas afetadas por alagamento:** publicação sobre intervenções na Rua Bahia e na Avenida Bandeirantes, incluindo interdição parcial da avenida.  
  [Acessar a notícia](https://www.americana.sp.gov.br/americana-index.php?a=noticia&id=37076)

- **Impactos das fortes chuvas:** registro de 179 milímetros de chuva em 72 horas e impactos nas proximidades do Ribeirão Quilombo.  
  [Acessar a notícia](https://www.americana.sp.gov.br/americana-index.php?a=noticia&id=37063)

### 16.2 Santa Bárbara d’Oeste (SP)

- **Situação de emergência após chuvas intensas:** notícia sobre alagamentos e danos à ponte Roldão Jorge Ferreira, entre os bairros San Marino e Jardim das Laranjeiras.  
  [Acessar a notícia](https://www.santabarbara.sp.gov.br/portal/noticias/0/3/73913/prefeitura-de-santa-barbara-doeste-decreta-situacao-de-emergencia-apos-chuvas-intensas/)

- **Decreto Municipal nº 7.808/2026:** documento oficial que declara situação de emergência nas áreas afetadas pelas chuvas intensas no município.  
  [Acessar o decreto](https://www.santabarbara.sp.gov.br/portal/leis_decretos/20161)

### 16.3 Nova Odessa (SP)

- **Defesa Civil recebe doação de água sanitária:** publicação municipal relacionada à atuação da Defesa Civil.  
  [Acessar a notícia](https://novaodessa.sp.gov.br/defesa-civil-de-nova-odessa-recebe-doacao-de-600-litros-de-agua-sanitaria-de-empresa-sumareense)

- **Obras na travessia do Córrego Capuava:** notícia sobre problemas históricos de alagamentos e erosão na Avenida Ampélio Gazzetta, na região conhecida como Pescoço da Égua.  
  [Acessar a notícia](https://novaodessa.sp.gov.br/noticias/destaques/comecam-as-obras-para-a-nova-travessia-do-corrego-capauva-em-nova-odessa)

- **Interdição da Avenida Ampélio Gazzetta:** publicação sobre o bloqueio da avenida para obras e as rotas alternativas para motoristas.  
  [Acessar a notícia](https://novaodessa.sp.gov.br/interdicao-total-da-avenida-ampelio-gazzetta-no-trecho-do-pescoco-da-egua-comeca-quarta-feira-2705)

- **Limpeza de ruas atingidas pelas chuvas:** notícia sobre os trabalhos no Jardim São Jorge e em regiões afetadas pelas chuvas, além do monitoramento do Ribeirão Quilombo.  
  [Acessar a notícia](https://novaodessa.sp.gov.br/noticias/destaques/forca-tarefa-em-nova-odessa-trabalha-na-limpeza-das-ruas-atingidas-pelas-chuvas-1)

### 16.4 Sumaré (SP)

- **Regiões atingidas por alagamentos:** publicação sobre ações de prevenção à leptospirose após enchentes nos bairros Vila Diva, Três Pontes, Jardim Primavera e São Domingos, além da Rua Crenac.  
  [Acessar a notícia](https://www.sumare.sp.gov.br/cidadao/noticia/sumare-reforca-prevencao-a-leptospirose-nas-regioes-atingidas-por-alagamentos)

- **Plano Diretor de Sumaré:** documento de planejamento urbano que pode apoiar análises territoriais e ambientais do município.  
  [Acessar o documento](https://www.sumare.sp.gov.br/plano_diretor/arquivos/mapVol1/VOLUME01COMPLETO.pdf)

### 16.5 Fontes Federais — CEMADEN

- **Municípios monitorados:** informações sobre municípios monitorados em razão do histórico de desastres naturais, incluindo inundações, enxurradas e grandes alagamentos.  
  [Acessar a página](https://www.gov.br/cemaden/pt-br/paginas/municipios-monitorados)

- **Painel de Alertas em Tempo Real:** plataforma para consulta de alertas de riscos geo-hidrológicos.  
  [Acessar o painel](https://painelalertas.cemaden.gov.br/)

- **Previsão de Riscos Geo-Hidrológicos:** informações e boletins sobre riscos de inundações e outros eventos relacionados às chuvas.  
  [Acessar a página](https://www.gov.br/cemaden/pt-br/assuntos/riscos-geo-hidrologicos/)

- **Mapas Interativos:** ferramenta de visualização de informações relacionadas ao monitoramento e à prevenção de desastres.  
  [Acessar os mapas](https://educacao.cemaden.gov.br/mapas-interativos-do-cemaden-ciencia-aplicada-na-prevencao-de-desastres/)

### 16.6 Referências Complementares

- **Waze:** recursos de navegação, trânsito e alertas colaborativos.
- **Google Maps:** recursos de mapas, pesquisa de destinos e rotas alternativas.
- **Apple Maps:** recursos de navegação e informações de trânsito.

### 16.7 Considerações sobre o Levantamento

As informações consultadas ajudam a demonstrar a existência de problemas relacionados a alagamentos, enchentes, drenagem urbana e interdições nas cidades abrangidas pelo SafeRoute.

Os registros apresentados não indicam, necessariamente, que os locais estejam alagados ou interditados no momento da consulta. A identificação de ocorrências em tempo real será realizada por meio das informações enviadas e confirmadas pelos usuários do aplicativo.

## 17. Considerações Finais

O SafeRoute busca desenvolver uma solução tecnológica voltada a um problema real de mobilidade urbana.

Por meio da colaboração entre motoristas, o aplicativo pretende oferecer informações sobre as condições das vias e facilitar a identificação de caminhos alternativos.

Nesta primeira etapa, foram definidos o problema, a proposta de solução, o público-alvo, os requisitos iniciais, as tecnologias propostas e a estrutura das telas.

As próximas etapas do projeto serão destinadas ao aprofundamento dos requisitos, desenvolvimento do protótipo e implementação das funcionalidades.

---

**SafeRoute — Seu caminho mais seguro começa com a informação.**
