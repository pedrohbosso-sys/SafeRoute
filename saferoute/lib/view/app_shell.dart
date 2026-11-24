import 'package:flutter/material.dart';

import '../controller/app_controller.dart';
import 'actions_view.dart';
import 'info_view.dart';
import 'map_view.dart';
import 'routes_view.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key, required this.controller, required this.onLogout});
  final AppController controller;
  final VoidCallback onLogout;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      MapView(
        controller: widget.controller,
        onReport: () => setState(() => index = 1),
        onRoutes: () => setState(() => index = 2),
        onInfo: () => setState(() => index = 3),
      ),
      ActionsView(
        controller: widget.controller,
        onDone: () => setState(() => index = 0),
      ),
      RoutesView(controller: widget.controller),
      InfoView(
        controller: widget.controller,
        onRoute: () => setState(() => index = 2),
        onLogout: widget.onLogout,
      ),
    ];
    return Scaffold(
      body: IndexedStack(index: index, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) => setState(() => index = value),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.map_outlined),
            selectedIcon: Icon(Icons.map),
            label: 'Mapa',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_alert_outlined),
            selectedIcon: Icon(Icons.add_alert),
            label: 'Ações',
          ),
          NavigationDestination(
            icon: Icon(Icons.alt_route_outlined),
            selectedIcon: Icon(Icons.alt_route),
            label: 'Mapas',
          ),
          NavigationDestination(
            icon: Icon(Icons.info_outline),
            selectedIcon: Icon(Icons.info),
            label: 'Informações',
          ),
        ],
      ),
    );
  }
}
