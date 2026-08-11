import 'package:flutter/material.dart';

/// RETO 1 de la Clase 2 · Cotizador Express de Envíos Nacionales
///
/// Widgets nuevos practicados aquí:
/// TextField · DropdownButtonFormField · RadioListTile · SwitchListTile
class CotizadorScreen extends StatefulWidget {
  const CotizadorScreen({super.key});

  @override
  State<CotizadorScreen> createState() => _CotizadorScreenState();
}

class _CotizadorScreenState extends State<CotizadorScreen> {
  final TextEditingController _pesoController = TextEditingController(
    text: '2.5',
  );

  // Costo base del flete según la ciudad de destino
  final Map<String, double> _ciudades = {
    'Bogotá': 8000,
    'Medellín': 12000,
    'Cali': 14000,
  };

  // Recargo según la velocidad del servicio
  final Map<String, double> _velocidades = {
    'Estándar': 0,
    'Express': 5000,
    'Súper Express': 10000,
  };

  String _ciudadSeleccionada = 'Bogotá';
  String _tipoEnvio = 'Estándar';
  bool _conSeguro = false;

  double _total = 0;
  bool _calculado = false;

  @override
  void dispose() {
    _pesoController.dispose();
    super.dispose();
  }

  void _calcularEnvio() {
    final double peso =
        double.tryParse(_pesoController.text.replaceAll(',', '.')) ?? 0;

    setState(() {
      // Total = CostoCiudad + (Peso * 2000) + CostoVelocidad + Seguro
      _total =
          _ciudades[_ciudadSeleccionada]! +
          (peso * 2000) +
          _velocidades[_tipoEnvio]! +
          (_conSeguro ? 3000 : 0);
      _calculado = true;
    });
  }

  /// Convierte 13000 en el texto $13.000
  String _pesos(double valor) {
    final String entero = valor.round().toString();
    final RegExp patron = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    return '\$${entero.replaceAllMapped(patron, (Match m) => '${m[1]}.')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cotizador de Envíos'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. PESO DEL PAQUETE
            TextField(
              controller: _pesoController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: 'Peso del paquete (Kg)',
                hintText: 'Ej. 2.5',
                prefixIcon: const Icon(Icons.scale),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 2. CIUDAD DE DESTINO
            DropdownButtonFormField<String>(
              initialValue: _ciudadSeleccionada,
              decoration: InputDecoration(
                labelText: 'Ciudad de destino',
                prefixIcon: const Icon(Icons.location_city),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              items: _ciudades.keys.map((String ciudad) {
                return DropdownMenuItem<String>(
                  value: ciudad,
                  child: Text('$ciudad  ·  ${_pesos(_ciudades[ciudad]!)}'),
                );
              }).toList(),
              onChanged: (String? valor) {
                if (valor == null) return;
                setState(() => _ciudadSeleccionada = valor);
              },
            ),
            const SizedBox(height: 16),

            // 3. TIPO DE ENVÍO (RadioListTile dentro de un RadioGroup)
            Card(
              elevation: 1,
              child: RadioGroup<String>(
                groupValue: _tipoEnvio,
                onChanged: (String? valor) {
                  if (valor == null) return;
                  setState(() => _tipoEnvio = valor);
                },
                child: Column(
                  children: _velocidades.keys.map((String tipo) {
                    return RadioListTile<String>(
                      dense: true,
                      value: tipo,
                      title: Text(tipo),
                      subtitle: Text('Recargo: ${_pesos(_velocidades[tipo]!)}'),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 8),

            // 4. SEGURO OPCIONAL
            Card(
              elevation: 1,
              child: SwitchListTile(
                title: const Text('Seguro de mercancía'),
                subtitle: const Text('Cobertura adicional por \$3.000'),
                secondary: const Icon(Icons.verified_user),
                value: _conSeguro,
                onChanged: (bool valor) => setState(() => _conSeguro = valor),
              ),
            ),
            const SizedBox(height: 20),

            // 5. BOTÓN QUE EJECUTA EL CÁLCULO
            ElevatedButton.icon(
              onPressed: _calcularEnvio,
              icon: const Icon(Icons.calculate),
              label: const Text('COTIZAR ENVÍO'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 6. TARJETA DE RESULTADO
            Card(
              elevation: 0,
              color: Colors.indigo.shade50,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.indigo.shade100),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      _calculado
                          ? 'VALOR TOTAL COTIZADO'
                          : 'PRESIONA COTIZAR PARA VER EL VALOR',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo.shade700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _calculado ? _pesos(_total) : '--',
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF1A237E),
                      ),
                    ),
                    if (_calculado) ...[
                      const SizedBox(height: 6),
                      Text(
                        '$_ciudadSeleccionada · $_tipoEnvio'
                        '${_conSeguro ? ' · Con seguro' : ''}',
                        style: const TextStyle(fontSize: 11),
                      ),
                    ],
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
