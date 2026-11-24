import 'package:flutter/material.dart';

import '../controller/app_controller.dart';
import '../model/ocorrencia.dart';
import 'widgets.dart';

class IncidentDetailView extends StatefulWidget {
  const IncidentDetailView({
    super.key,
    required this.controller,
    required this.incident,
    required this.onRoute,
  });
  final AppController controller;
  final Ocorrencia incident;
  final VoidCallback onRoute;
  @override
  State<IncidentDetailView> createState() => _IncidentDetailViewState();
}

class _IncidentDetailViewState extends State<IncidentDetailView> {
  bool saving = false;

  Future<void> vote(bool exists) async {
    setState(() => saving = true);
    try {
      await widget.controller.confirm(widget.incident, exists);
      if (mounted) message(context, 'Sua avaliação foi registrada.');
    } catch (e) {
      if (mounted) message(context, e.toString());
    } finally {
      if (mounted) setState(() => saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.controller.incidents.firstWhere(
      (value) => value.id == widget.incident.id,
      orElse: () => widget.incident,
    );
    return Scaffold(
      appBar: AppBar(title: const Text('Confirmar ocorrência')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              height: 170,
              decoration: BoxDecoration(
                color: const Color(0xFFE8F1F2),
                borderRadius: BorderRadius.circular(20),
              ),
              clipBehavior: Clip.antiAlias,
              child: item.fotoUrl == null
                  ? Center(
                      child: Icon(typeIcon(item.tipo), size: 74, color: danger),
                    )
                  : Image.network(
                      item.fotoUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => Center(
                        child: Icon(
                          typeIcon(item.tipo),
                          size: 74,
                          color: danger,
                        ),
                      ),
                    ),
            ),
            const SizedBox(height: 16),
            card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.warning_amber, color: danger),
                      const SizedBox(width: 8),
                      Text(
                        typeLabel(item.tipo),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: ink,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(item.local?.endereco ?? 'Local não informado'),
                  const SizedBox(height: 8),
                  Text('Registrada em ${item.dataOcorrencia.toLocal()}'),
                  const SizedBox(height: 8),
                  Text('Válida até ${item.validade.toLocal()}'),
                  const SizedBox(height: 8),
                  Text(
                    'Gravidade: ${item.gravidade == 3
                        ? 'Alta'
                        : item.gravidade == 2
                        ? 'Moderada'
                        : 'Baixa'}',
                  ),
                  const Divider(height: 28),
                  Text(
                    item.descricao.isEmpty
                        ? 'Nenhum detalhe informado.'
                        : item.descricao,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(Icons.how_to_vote, color: primary, size: 34),
                  const SizedBox(height: 8),
                  const Text(
                    'Essa ocorrência ainda continua ativa no local?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ink,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Sua resposta ajuda a manter os desvios atualizados.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 18),
                  FilledButton.icon(
                    onPressed: saving ? null : () => vote(true),
                    icon: const Icon(Icons.thumb_up),
                    label: Text('Sim, confirmar (${item.confirmadas})'),
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton.icon(
                    onPressed: saving ? null : () => vote(false),
                    icon: const Icon(Icons.thumb_down),
                    label: Text('Não existe mais (${item.contestadas})'),
                  ),
                  if (!widget.controller.authenticated)
                    const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text(
                        'Entre em sua conta para avaliar.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: danger),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: () {
                Navigator.pop(context);
                widget.onRoute();
              },
              icon: const Icon(Icons.alt_route),
              label: const Text('Calcular desvio seguro'),
            ),
          ],
        ),
      ),
    );
  }
}
