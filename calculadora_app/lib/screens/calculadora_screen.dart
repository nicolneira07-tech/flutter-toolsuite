import 'package:flutter/material.dart';

/// APP OBJETIVO de la Clase 2 · Calculadora Pro
///
/// Anatomía practicada aquí:
/// Scaffold · Card · TextField + InputDecoration · ElevatedButton · setState()
///
/// Desafío autónomo resuelto: las 4 operaciones (+, -, ×, ÷)
class CalculadoraScreen extends StatefulWidget {
  const CalculadoraScreen({super.key});

  @override
  State<CalculadoraScreen> createState() => _CalculadoraScreenState();
}

class _CalculadoraScreenState extends State<CalculadoraScreen> {
  final TextEditingController _num1Controller = TextEditingController();
  final TextEditingController _num2Controller = TextEditingController();

  String _resultado = '0.0';
  String _detalleOperacion = '';
  bool _huboError = false;

  @override
  void dispose() {
    _num1Controller.dispose();
    _num2Controller.dispose();
    super.dispose();
  }

  /// Ejecuta la operación indicada por [simbolo]: '+', '-', '×' o '÷'
  void _calcular(String simbolo) {
    final String t1 = _num1Controller.text.trim();
    final String t2 = _num2Controller.text.trim();

    if (t1.isEmpty || t2.isEmpty) {
      _mostrarError('Por favor ingresa ambos números');
      return;
    }

    final double? n1 = double.tryParse(t1.replaceAll(',', '.'));
    final double? n2 = double.tryParse(t2.replaceAll(',', '.'));

    if (n1 == null || n2 == null) {
      _mostrarError('Valores numéricos inválidos');
      return;
    }

    // La división entre cero no está definida en matemáticas:
    // hay que atajarla ANTES de operar.
    if (simbolo == '÷' && n2 == 0) {
      _mostrarError('No se puede dividir entre cero');
      return;
    }

    final double valor;
    switch (simbolo) {
      case '+':
        valor = n1 + n2;
      case '-':
        valor = n1 - n2;
      case '×':
        valor = n1 * n2;
      case '÷':
        valor = n1 / n2;
      default:
        return;
    }

    setState(() {
      _resultado = _formatoResultado(valor);
      _detalleOperacion =
          '${_formatoResultado(n1)} $simbolo ${_formatoResultado(n2)} =';
      _huboError = false;
    });
  }

  void _mostrarError(String mensaje) {
    setState(() {
      _resultado = mensaje;
      _detalleOperacion = '';
      _huboError = true;
    });
  }

  /// Evita resultados como 3.3333333333333335: recorta a 4 decimales
  /// y deja siempre al menos un decimal (26 -> 26.0).
  String _formatoResultado(double valor) {
    if (valor == valor.roundToDouble()) return valor.toStringAsFixed(1);

    String texto = valor.toStringAsFixed(4);
    while (texto.endsWith('0')) {
      texto = texto.substring(0, texto.length - 1);
    }
    return texto;
  }

  void _limpiar() {
    _num1Controller.clear();
    _num2Controller.clear();
    setState(() {
      _resultado = '0.0';
      _detalleOperacion = '';
      _huboError = false;
    });
  }

  /// Construye cada uno de los 4 botones de operación
  Widget _botonOperacion({
    required String etiqueta,
    required String simbolo,
    required Color color,
  }) {
    return ElevatedButton(
      onPressed: () => _calcular(simbolo),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            simbolo,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 2),
          Text(
            etiqueta,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Calculadora Pro'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.indigoAccent,
                      child: Icon(Icons.calculate, color: Colors.white),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Operaciones Básicas',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Suma, resta, multiplicación y división',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            TextField(
              controller: _num1Controller,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
              decoration: InputDecoration(
                labelText: 'Primer Número',
                hintText: 'Ej. 15.4',
                prefixIcon: const Icon(Icons.looks_one, color: Colors.indigo),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _num2Controller,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
              decoration: InputDecoration(
                labelText: 'Segundo Número',
                hintText: 'Ej. 10.6',
                prefixIcon: const Icon(Icons.looks_two, color: Colors.indigo),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),

            // LAS 4 OPERACIONES EN UNA CUADRÍCULA DE 2x2
            Row(
              children: [
                Expanded(
                  child: _botonOperacion(
                    etiqueta: 'SUMAR',
                    simbolo: '+',
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _botonOperacion(
                    etiqueta: 'RESTAR',
                    simbolo: '-',
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _botonOperacion(
                    etiqueta: 'MULTIPLICAR',
                    simbolo: '×',
                    color: Colors.deepPurple,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _botonOperacion(
                    etiqueta: 'DIVIDIR',
                    simbolo: '÷',
                    color: Colors.teal,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            OutlinedButton.icon(
              onPressed: _limpiar,
              icon: const Icon(Icons.refresh),
              label: const Text('LIMPIAR'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 24),

            Card(
              color: _huboError ? Colors.red[50] : Colors.indigo[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: _huboError ? Colors.red : Colors.indigo,
                  width: 1.5,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      _huboError ? '⚠️ ATENCIÓN' : 'RESULTADO FINAL',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: _huboError ? Colors.red : Colors.indigo,
                      ),
                    ),
                    if (_detalleOperacion.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(
                        _detalleOperacion,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.indigo[400],
                        ),
                      ),
                    ],
                    const SizedBox(height: 8),
                    Text(
                      _resultado,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: _huboError ? 14 : 28,
                        fontWeight: FontWeight.bold,
                        color: _huboError ? Colors.red[800] : Colors.indigo[900],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
