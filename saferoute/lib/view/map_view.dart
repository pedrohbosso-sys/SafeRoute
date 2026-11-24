import 'package:flutter/material.dart';

import '../controller/app_controller.dart';
import '../model/ocorrencia.dart';
import 'incident_detail_view.dart';
import 'widgets.dart';

class MapView extends StatefulWidget {
  const MapView({
    super.key,
    required this.controller,
    required this.onReport,
    required this.onRoutes,
    required this.onInfo,
  });
  final AppController controller;
  final VoidCallback onReport;
  final VoidCallback onRoutes;
  final VoidCallback onInfo;

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final query = TextEditingController();
  @override
  void dispose() {
    query.dispose();
    super.dispose();
  }

  Future<void> search() async {
    if (query.text.trim().isEmpty) return;
    try {
      await widget.controller.searchDestination(query.text.trim());
      if (mounted) widget.onRoutes();
    } catch (e) {
      if (mounted) message(context, e.toString());
    }
  }

  void openIncident(Ocorrencia item) => Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => IncidentDetailView(
        controller: widget.controller,
        incident: item,
        onRoute: widget.onRoutes,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Stack(
      children: [
        Positioned.fill(
          child: RouteMap(
            controller: widget.controller,
            onIncident: openIncident,
          ),
        ),
        Positioned(
          top: 14,
          left: 16,
          right: 16,
          child: Column(
            children: [
              card(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: primary),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: query,
                        onSubmitted: (_) => search(),
                        decoration: const InputDecoration(
                          hintText: 'Para onde você quer ir?',
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          filled: false,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: search,
                      icon: const Icon(Icons.arrow_forward, color: primary),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              if (widget.controller.incidents.isNotEmpty)
                InkWell(
                  onTap: widget.onInfo,
                  child: card(
                    child: Row(
                      children: [
                        const CircleAvatar(
                          backgroundColor: Color(0xFFFFE7E6),
                          child: Icon(Icons.crisis_alert, color: danger),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'ATENÇÃO NA REGIÃO',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: danger,
                                ),
                              ),
                              Text(
                                '${widget.controller.incidents.length} ocorrência(s) ativa(s)',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: ink,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        Positioned(
          right: 16,
          bottom: 90,
          child: FloatingActionButton.small(
            heroTag: 'locate',
            onPressed: widget.controller.locate,
            child: const Icon(Icons.my_location),
          ),
        ),
        Positioned(
          left: 16,
          right: 16,
          bottom: 20,
          child: FilledButton.icon(
            onPressed: widget.onReport,
            icon: const Icon(Icons.add_alert),
            label: const Text('Reportar ocorrência'),
          ),
        ),
      ],
    ),
  );
}
