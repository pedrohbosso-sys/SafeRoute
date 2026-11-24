import 'package:flutter/material.dart';

import '../controller/app_controller.dart';
import '../model/ocorrencia.dart';
import 'incident_detail_view.dart';
import 'widgets.dart';

class InfoView extends StatefulWidget {
  const InfoView({
    super.key,
    required this.controller,
    required this.onRoute,
    required this.onLogout,
  });
  final AppController controller;
  final VoidCallback onRoute;
  final VoidCallback onLogout;
  @override
  State<InfoView> createState() => _InfoViewState();
}

class _InfoViewState extends State<InfoView> {
  String filter = 'todos';
  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;
    final items = controller.incidents
        .where((item) => filter == 'todos' || item.tipo == filter)
        .toList();
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 12, 12),
            child: Row(
              children: [
                const Icon(Icons.info, color: primary),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    'Informações',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: ink,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: controller.loadIncidents,
                  icon: const Icon(Icons.refresh),
                  tooltip: 'Atualizar',
                ),
                IconButton(
                  onPressed: widget.onLogout,
                  icon: const Icon(Icons.logout),
                  tooltip: 'Sair',
                ),
              ],
            ),
          ),
          SizedBox(
            height: 46,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                for (final entry in const [
                  ('todos', 'Todas'),
                  ('alagamento', 'Alagamentos'),
                  ('enchente', 'Enchentes'),
                  ('obras', 'Obras'),
                  ('interdicao', 'Interdições'),
                ])
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(entry.$2),
                      selected: filter == entry.$1,
                      onSelected: (_) => setState(() => filter = entry.$1),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: RefreshIndicator(
              onRefresh: controller.loadIncidents,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  if (controller.error != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Text(
                        controller.error!,
                        style: const TextStyle(color: danger),
                      ),
                    ),
                  if (items.isEmpty)
                    card(
                      child: const Column(
                        children: [
                          Icon(Icons.shield_outlined, size: 48, color: safe),
                          SizedBox(height: 8),
                          Text('Nenhuma ocorrência ativa encontrada'),
                          SizedBox(height: 4),
                          Text(
                            'Os relatos publicados pelos motoristas aparecem aqui.',
                          ),
                        ],
                      ),
                    ),
                  ...items.map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _incidentCard(item),
                    ),
                  ),
                  const SizedBox(height: 16),
                  card(
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sobre o SafeRoute',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: ink,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Informações colaborativas sobre alagamentos, enchentes, obras e interdições. Relatos têm validade limitada e devem ser verificados antes de dirigir.',
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Área inicial: Americana, Santa Bárbara d’Oeste, Nova Odessa e Sumaré (SP).',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _incidentCard(Ocorrencia item) => InkWell(
    onTap: () => Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => IncidentDetailView(
          controller: widget.controller,
          incident: item,
          onRoute: widget.onRoute,
        ),
      ),
    ),
    child: card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFFFFE7E6),
            child: Icon(typeIcon(item.tipo), color: danger),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  typeLabel(item.tipo),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: ink,
                  ),
                ),
                const SizedBox(height: 4),
                Text(item.local?.endereco ?? 'Local não informado'),
                const SizedBox(height: 4),
                Text(
                  item.descricao.isEmpty
                      ? 'Sem detalhes adicionais'
                      : item.descricao,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  'Válida até ${TimeOfDay.fromDateTime(item.validade.toLocal()).format(context)}',
                  style: const TextStyle(color: primary, fontSize: 12),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: primary),
        ],
      ),
    ),
  );
}
