import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:calculadora_app/main.dart';

void main() {
  /// Escribe los dos operandos y pulsa el botón de la operación indicada.
  Future<void> operar(
    WidgetTester tester,
    String a,
    String b,
    String etiqueta,
  ) async {
    final Finder campos = find.byType(TextField);
    await tester.enterText(campos.at(0), a);
    await tester.enterText(campos.at(1), b);

    await tester.ensureVisible(find.text(etiqueta));
    await tester.pumpAndSettle();
    await tester.tap(find.text(etiqueta));
    await tester.pump();
  }

  testWidgets('Suma dos números', (WidgetTester tester) async {
    await tester.pumpWidget(const CalculadoraApp());
    await operar(tester, '15.4', '10.6', 'SUMAR');

    expect(find.text('15.4 + 10.6 ='), findsOneWidget);
    expect(find.text('26.0'), findsOneWidget);
  });

  testWidgets('Resta dos números', (WidgetTester tester) async {
    await tester.pumpWidget(const CalculadoraApp());
    await operar(tester, '20', '7.5', 'RESTAR');

    expect(find.text('12.5'), findsOneWidget);
  });

  testWidgets('Multiplica dos números', (WidgetTester tester) async {
    await tester.pumpWidget(const CalculadoraApp());
    await operar(tester, '12', '8', 'MULTIPLICAR');

    expect(find.text('96.0'), findsOneWidget);
  });

  testWidgets('Divide dos números y recorta los decimales', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const CalculadoraApp());
    await operar(tester, '10', '3', 'DIVIDIR');

    // 3.3333333333333335 se muestra recortado, no crudo
    expect(find.text('3.3333'), findsOneWidget);
  });

  testWidgets('Rechaza la división entre cero', (WidgetTester tester) async {
    await tester.pumpWidget(const CalculadoraApp());
    await operar(tester, '10', '0', 'DIVIDIR');

    expect(find.text('No se puede dividir entre cero'), findsOneWidget);
  });

  testWidgets('Muestra una advertencia si faltan datos', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const CalculadoraApp());

    await tester.tap(find.text('SUMAR'));
    await tester.pump();

    expect(find.text('Por favor ingresa ambos números'), findsOneWidget);
  });

  testWidgets('LIMPIAR reinicia el resultado', (WidgetTester tester) async {
    await tester.pumpWidget(const CalculadoraApp());
    await operar(tester, '4', '4', 'SUMAR');
    expect(find.text('8.0'), findsOneWidget);

    await tester.ensureVisible(find.text('LIMPIAR'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('LIMPIAR'));
    await tester.pump();

    expect(find.text('0.0'), findsOneWidget);
    expect(find.text('8.0'), findsNothing);
  });
}
