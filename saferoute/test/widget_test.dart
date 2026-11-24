import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saferoute/main.dart';

void main() {
  testWidgets('consulta anônima abre as áreas principais', (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('SafeRoute'), findsOneWidget);
    expect(find.text('Consultar mapa sem entrar'), findsOneWidget);

    await tester.ensureVisible(find.text('Consultar mapa sem entrar'));
    await tester.tap(find.text('Consultar mapa sem entrar'));
    await tester.pumpAndSettle();
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text('Mapa Mapbox'), findsOneWidget);

    await tester.tap(find.text('Ações').last);
    await tester.pumpAndSettle();
    expect(find.text('Reportar ocorrência'), findsOneWidget);
    expect(find.text('Tipo de incidente'), findsOneWidget);

    await tester.tap(find.text('Mapas').last);
    await tester.pumpAndSettle();
    expect(find.text('Escolha de rota'), findsOneWidget);

    await tester.tap(find.text('Informações').last);
    await tester.pumpAndSettle();
    expect(find.text('Nenhuma ocorrência ativa encontrada'), findsOneWidget);
  });
}
