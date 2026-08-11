import 'package:flutter/material.dart';

/// RETO 2 de la Clase 2 · Encuesta de Satisfacción y Feedback
///
/// Widgets nuevos practicados aquí:
/// Slider · CheckboxListTile · ChoiceChip · SnackBar
class EncuestaScreen extends StatefulWidget {
  const EncuestaScreen({super.key});

  @override
  State<EncuestaScreen> createState() => _EncuestaScreenState();
}

class _EncuestaScreenState extends State<EncuestaScreen> {
  // Valor del Slider (1.0 a 10.0)
  double _calificacion = 8.0;

  // Aspectos evaluados con CheckboxListTile
  final Map<String, bool> _aspectos = {
    'Velocidad': true,
    'Amabilidad': true,
    'Calidad del producto': false,
  };

  // Canal de atención seleccionado con ChoiceChip
  final List<String> _canales = ['Presencial', 'Virtual', 'Telefónico'];
  String _canalSeleccionado = 'Presencial';

  List<String> get _aspectosMarcados => _aspectos.entries
      .where((MapEntry<String, bool> e) => e.value)
      .map((MapEntry<String, bool> e) => e.key)
      .toList();

  String get _nivel {
    if (_calificacion >= 9) return 'Excelente';
    if (_calificacion >= 7) return 'Bueno';
    if (_calificacion >= 5) return 'Aceptable';
    return 'Requiere mejora';
  }

  void _enviarEncuesta() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '¡Gracias! Registramos ${_calificacion.round()}/10 '
          'vía $_canalSeleccionado',
        ),
        backgroundColor: Colors.green.shade700,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Encuesta de Feedback'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. SLIDER DE CALIFICACIÓN
            Card(
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Nivel de satisfacción',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${_calificacion.round()} / 10',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      value: _calificacion,
                      min: 1.0,
                      max: 10.0,
                      divisions: 9,
                      label: _calificacion.round().toString(),
                      activeColor: Colors.green,
                      onChanged: (double valor) {
                        setState(() => _calificacion = valor);
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            // 2. ASPECTOS DESTACADOS
            Card(
              elevation: 1,
              child: Column(
                children: _aspectos.keys.map((String aspecto) {
                  return CheckboxListTile(
                    dense: true,
                    activeColor: Colors.green,
                    title: Text(aspecto),
                    value: _aspectos[aspecto],
                    onChanged: (bool? valor) {
                      setState(() => _aspectos[aspecto] = valor ?? false);
                    },
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 12),

            // 3. CANAL DE ATENCIÓN
            const Text(
              'Canal de atención utilizado',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              children: _canales.map((String canal) {
                return ChoiceChip(
                  label: Text(canal),
                  selected: _canalSeleccionado == canal,
                  selectedColor: Colors.green.shade100,
                  onSelected: (bool seleccionado) {
                    if (!seleccionado) return;
                    setState(() => _canalSeleccionado = canal);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // 4. RESUMEN EN TIEMPO REAL
            Card(
              elevation: 0,
              color: Colors.green.shade50,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.green.shade100),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'RESUMEN DE LA VALORACIÓN',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${_calificacion.round()}/10 · $_nivel',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text('Canal: $_canalSeleccionado'),
                    Text(
                      _aspectosMarcados.isEmpty
                          ? 'Sin aspectos destacados'
                          : 'Destaca: ${_aspectosMarcados.join(', ')}',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            ElevatedButton.icon(
              onPressed: _enviarEncuesta,
              icon: const Icon(Icons.send),
              label: const Text('ENVIAR RESPUESTA'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
