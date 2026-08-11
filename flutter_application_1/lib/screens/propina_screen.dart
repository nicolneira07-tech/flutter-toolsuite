import 'package:flutter/material.dart';

/// RETO 3 de la Clase 2 · Calculadora de Propinas y División de Cuenta
///
/// Widgets nuevos practicados aquí:
/// SegmentedButton · IconButton (+ / -)
class PropinaScreen extends StatefulWidget {
  const PropinaScreen({super.key});

  @override
  State<PropinaScreen> createState() => _PropinaScreenState();
}

class _PropinaScreenState extends State<PropinaScreen> {
  final TextEditingController _cuentaController = TextEditingController(
    text: '120000',
  );

  int _propina = 10; // Porcentaje elegido en el SegmentedButton
  int _personas = 3; // Cantidad ajustada con los IconButton

  @override
  void dispose() {
    _cuentaController.dispose();
    super.dispose();
  }

  double get _cuenta =>
      double.tryParse(_cuentaController.text.replaceAll(',', '.')) ?? 0;

  double get _totalConPropina => _cuenta * (1 + _propina / 100);

  double get _montoPorPersona => _totalConPropina / _personas;

  void _cambiarPersonas(int delta) {
    setState(() {
      _personas = (_personas + delta).clamp(1, 20);
    });
  }

  String _pesos(double valor) {
    final String entero = valor.round().toString();
    final RegExp patron = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    return '\$${entero.replaceAllMapped(patron, (Match m) => '${m[1]}.')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Propinas y División'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. TOTAL DE LA CUENTA
            TextField(
              controller: _cuentaController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              onChanged: (_) => setState(() {}), // Recalcula en vivo
              decoration: InputDecoration(
                labelText: 'Total de la cuenta',
                prefixIcon: const Icon(Icons.attach_money),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 2. PROPINA SUGERIDA
            const Text(
              'Propina sugerida',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
            const SizedBox(height: 8),
            SegmentedButton<int>(
              segments: const <ButtonSegment<int>>[
                ButtonSegment<int>(value: 10, label: Text('10%')),
                ButtonSegment<int>(value: 15, label: Text('15%')),
                ButtonSegment<int>(value: 20, label: Text('20%')),
              ],
              selected: <int>{_propina},
              onSelectionChanged: (Set<int> seleccion) {
                setState(() => _propina = seleccion.first);
              },
            ),
            const SizedBox(height: 20),

            // 3. NÚMERO DE PERSONAS
            Card(
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 6.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Personas',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: () => _cambiarPersonas(-1),
                        ),
                        Text(
                          '$_personas',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          color: Colors.deepPurple,
                          icon: const Icon(Icons.add_circle),
                          onPressed: () => _cambiarPersonas(1),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 4. RESULTADO
            Card(
              elevation: 0,
              color: Colors.deepPurple.shade50,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.deepPurple.shade100),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'PAGA CADA PERSONA',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple.shade700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _pesos(_montoPorPersona),
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const Divider(height: 20),
                    Text('Cuenta: ${_pesos(_cuenta)}'),
                    Text(
                      'Propina ($_propina%): '
                      '${_pesos(_totalConPropina - _cuenta)}',
                    ),
                    Text('Total con propina: ${_pesos(_totalConPropina)}'),
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
