import 'package:flutter/material.dart';

import '../controller/app_controller.dart';
import 'widgets.dart';

class RoutesView extends StatefulWidget {
  const RoutesView({super.key, required this.controller});
  final AppController controller;
  @override
  State<RoutesView> createState() => _RoutesViewState();
}

class _RoutesViewState extends State<RoutesView> {
  final destination = TextEditingController();
  @override
  void dispose() {
    destination.dispose();
    super.dispose();
  }

  Future<void> search() async {
    if (destination.text.trim().isEmpty) return;
    try {
      await widget.controller.searchDestination(destination.text.trim());
    } catch (e) {
      if (mounted) message(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;
    return SafeArea(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 18, 20, 10),
            child: Row(
              children: [
                Icon(Icons.alt_route, color: primary),
                SizedBox(width: 10),
                Text(
                  'Escolha de rota',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: ink,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: card(
              child: Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.my_location, color: primary),
                    title: const Text('Origem (GPS)'),
                    subtitle: Text(
                      controller.locationAvailable
                          ? 'Sua localização atual'
                          : 'GPS indisponível; mapa centrado em Americana',
                    ),
                  ),
                  TextField(
                    controller: destination,
                    onSubmitted: (_) => search(),
                    decoration: InputDecoration(
                      labelText: 'Destino',
                      hintText: controller.destinationName.isEmpty
                          ? 'Pesquise um endereço'
                          : controller.destinationName,
                      prefixIcon: const Icon(Icons.location_on),
                      suffixIcon: IconButton(
                        onPressed: search,
                        icon: const Icon(Icons.search),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            flex: 4,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: RouteMap(controller: controller),
            ),
          ),
          Expanded(
            flex: 5,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text(
                  'Rotas disponíveis',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ink,
                  ),
                ),
                const SizedBox(height: 8),
                if (controller.busy)
                  const Center(child: CircularProgressIndicator()),
                if (controller.error != null)
                  Text(
                    controller.error!,
                    style: const TextStyle(color: danger),
                  ),
                if (controller.routes.isEmpty && !controller.busy)
                  const Text(
                    'Pesquise um destino para comparar caminhos e verificar ocorrências próximas.',
                  ),
                ...controller.routes.asMap().entries.map((entry) {
                  final route = entry.value;
                  final chosen = controller.selectedRoute == entry.key;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: InkWell(
                      onTap: () => controller.chooseRoute(entry.key),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: chosen ? primary : const Color(0xFFDDE5E8),
                            width: chosen ? 2 : 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  route.safe
                                      ? Icons.verified_user
                                      : Icons.warning_amber,
                                  color: route.safe ? safe : danger,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    route.safe
                                        ? 'Sem ocorrências próximas'
                                        : 'Atenção: ocorrência próxima',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                if (chosen)
                                  const Icon(
                                    Icons.check_circle,
                                    color: primary,
                                  ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '${route.minutes} min • ${route.km.toStringAsFixed(1)} km',
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: FilledButton.icon(
              onPressed:
                  controller.navigating ||
                      (controller.routes.isNotEmpty &&
                          controller.routes[controller.selectedRoute].safe)
                  ? () async {
                      try {
                        if (controller.navigating) {
                          await controller.stopNavigation();
                          if (context.mounted) {
                            message(context, 'Navegação encerrada.');
                          }
                        } else {
                          await controller.startNavigation();
                          if (context.mounted) {
                            message(
                              context,
                              'Acompanhamento por GPS iniciado. Dirija com atenção.',
                            );
                          }
                        }
                      } catch (e) {
                        if (context.mounted) message(context, e.toString());
                      }
                    }
                  : null,
              icon: Icon(controller.navigating ? Icons.stop : Icons.navigation),
              label: Text(
                controller.navigating
                    ? 'Encerrar navegação'
                    : 'Iniciar navegação',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
