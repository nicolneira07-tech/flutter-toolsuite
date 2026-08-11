import 'package:flutter/material.dart';

/// RETO 4 de la Clase 2 · Agendamiento de Citas Médicas
///
/// Widgets nuevos practicados aquí:
/// showDatePicker() (asíncrono) · ChoiceChip · SnackBar
class CitasScreen extends StatefulWidget {
  const CitasScreen({super.key});

  @override
  State<CitasScreen> createState() => _CitasScreenState();
}

class _CitasScreenState extends State<CitasScreen> {
  final List<String> _especialidades = [
    'Medicina General',
    'Odontología',
    'Pediatría',
  ];

  final List<String> _horas = ['08:00 AM', '10:30 AM', '02:00 PM'];

  String _especialidad = 'Medicina General';
  String _hora = '08:00 AM';
  DateTime? _fechaSeleccionada;
  bool _reservaConfirmada = false;

  /// Abre el calendario nativo de Material y espera la respuesta del usuario
  Future<void> _elegirFecha() async {
    final DateTime ahora = DateTime.now();

    final DateTime? fecha = await showDatePicker(
      context: context,
      initialDate: _fechaSeleccionada ?? ahora,
      firstDate: ahora,
      lastDate: DateTime(ahora.year + 1),
      helpText: 'Selecciona la fecha de tu cita',
    );

    if (fecha != null) {
      setState(() {
        _fechaSeleccionada = fecha;
        _reservaConfirmada = false;
      });
    }
  }

  /// Convierte un DateTime en el texto dd/mm/aaaa
  String _formatoFecha(DateTime fecha) {
    final String dia = fecha.day.toString().padLeft(2, '0');
    final String mes = fecha.month.toString().padLeft(2, '0');
    return '$dia/$mes/${fecha.year}';
  }

  void _confirmarReserva() {
    if (_fechaSeleccionada == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Primero selecciona una fecha para la cita'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    setState(() => _reservaConfirmada = true);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Cita reservada: $_especialidad · $_hora'),
        backgroundColor: Colors.teal,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendar Cita Médica'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. ESPECIALIDAD
            DropdownButtonFormField<String>(
              initialValue: _especialidad,
              decoration: InputDecoration(
                labelText: 'Especialidad',
                prefixIcon: const Icon(Icons.medical_services),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              items: _especialidades.map((String esp) {
                return DropdownMenuItem<String>(value: esp, child: Text(esp));
              }).toList(),
              onChanged: (String? valor) {
                if (valor == null) return;
                setState(() {
                  _especialidad = valor;
                  _reservaConfirmada = false;
                });
              },
            ),
            const SizedBox(height: 16),

            // 2. FECHA CON showDatePicker()
            OutlinedButton.icon(
              onPressed: _elegirFecha,
              icon: const Icon(Icons.calendar_month),
              label: Text(
                _fechaSeleccionada == null
                    ? 'Seleccionar fecha de la cita'
                    : 'Fecha: ${_formatoFecha(_fechaSeleccionada!)}',
              ),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                side: const BorderSide(color: Colors.teal),
                foregroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 3. HORA DISPONIBLE
            const Text(
              'Hora disponible',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              children: _horas.map((String hora) {
                return ChoiceChip(
                  label: Text(hora),
                  selected: _hora == hora,
                  selectedColor: Colors.teal.shade100,
                  onSelected: (bool seleccionado) {
                    if (!seleccionado) return;
                    setState(() {
                      _hora = hora;
                      _reservaConfirmada = false;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: _confirmarReserva,
              icon: const Icon(Icons.event_available),
              label: const Text('CONFIRMAR RESERVA'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 4. TICKET VIRTUAL DE CONFIRMACIÓN
            if (_reservaConfirmada)
              Card(
                elevation: 0,
                color: Colors.teal.shade50,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.teal.shade200),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.confirmation_number,
                            color: Colors.teal,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'TICKET VIRTUAL',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.teal.shade800,
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 20),
                      Text('Especialidad: $_especialidad'),
                      Text('Fecha: ${_formatoFecha(_fechaSeleccionada!)}'),
                      Text('Hora: $_hora'),
                      const SizedBox(height: 6),
                      const Text(
                        'Presenta este ticket 15 minutos antes.',
                        style: TextStyle(fontSize: 11, color: Colors.black54),
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
