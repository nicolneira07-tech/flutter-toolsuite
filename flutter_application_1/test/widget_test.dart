import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/main.dart';

/// Verifica que las herramientas del hub estén enlazadas y que el
/// Navigator abra y cierre cada pantalla correctamente.
void main() {
  const List<String> titulos = [
    'Cotizador de Envíos',
    'Encuesta de Feedback',
    'Propinas y División',
    'Agendar Cita Médica',
  ];

  testWidgets('El menú hub lista las 4 herramientas', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MiSuiteApp());

    for (final String titulo in titulos) {
      expect(find.text(titulo), findsOneWidget, reason: 'Falta: $titulo');
    }
  });

  testWidgets('Cada herramienta abre su pantalla y regresa con pop', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MiSuiteApp());

    for (final String titulo in titulos) {
      await tester.ensureVisible(find.text(titulo));
      await tester.pumpAndSettle();

      await tester.tap(find.text(titulo));
      await tester.pumpAndSettle();

      // Ya no estamos en el hub: se apiló la pantalla destino
      expect(find.text('ToolSuite - Menú Hub'), findsNothing);

      // Navigator.pop() mediante la flecha del AppBar
      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();

      expect(find.text('ToolSuite - Menú Hub'), findsOneWidget);
    }
  });

  testWidgets('El drawer del hub se abre desde el AppBar', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MiSuiteApp());

    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();

    expect(find.text('Suite de Ejercicios Móviles'), findsOneWidget);
  });
}
