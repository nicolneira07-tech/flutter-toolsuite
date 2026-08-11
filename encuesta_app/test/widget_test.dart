import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:encuesta_app/main.dart';

void main() {
  testWidgets('La encuesta arranca en 8/10 y con canal Presencial', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const EncuestaApp());

    expect(find.text('8 / 10'), findsOneWidget);
    expect(find.text('Canal: Presencial'), findsOneWidget);
  });

  testWidgets('Cambiar el canal actualiza el resumen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const EncuestaApp());

    await tester.tap(find.widgetWithText(ChoiceChip, 'Virtual'));
    await tester.pumpAndSettle();

    expect(find.text('Canal: Virtual'), findsOneWidget);
  });

  testWidgets('El botón enviar muestra un SnackBar', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const EncuestaApp());

    // El botón queda bajo el pliegue en el viewport de prueba: hay que
    // desplazar el SingleChildScrollView antes de tocarlo.
    await tester.ensureVisible(find.text('ENVIAR RESPUESTA'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('ENVIAR RESPUESTA'));
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
  });
}
