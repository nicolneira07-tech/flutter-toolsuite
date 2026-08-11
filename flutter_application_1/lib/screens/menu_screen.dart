import 'package:flutter/material.dart';
import '../models/herramienta.dart';
import 'citas_screen.dart';
import 'cotizador_screen.dart';
import 'encuesta_screen.dart';
import 'propina_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. LISTA DINÁMICA DE OBJETOS MODELO
    final List<Herramienta> herramientas = [
      Herramienta(
        id: '1',
        titulo: 'Cotizador de Envíos',
        descripcion: 'Calcula fletes según peso y destino',
        icono: Icons.local_shipping,
        color: Colors.indigo,
        pantallaDestino: const CotizadorScreen(),
      ),
      Herramienta(
        id: '2',
        titulo: 'Encuesta de Feedback',
        descripcion: 'Valora el servicio de atención',
        icono: Icons.rate_review,
        color: Colors.green,
        pantallaDestino: const EncuestaScreen(),
      ),
      Herramienta(
        id: '3',
        titulo: 'Propinas y División',
        descripcion: 'Divide la cuenta entre varias personas',
        icono: Icons.receipt_long,
        color: Colors.deepPurple,
        pantallaDestino: const PropinaScreen(),
      ),
      Herramienta(
        id: '4',
        titulo: 'Agendar Cita Médica',
        descripcion: 'Reserva turno con showDatePicker()',
        icono: Icons.calendar_month,
        color: Colors.teal,
        pantallaDestino: const CitasScreen(),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('ToolSuite - Menú Hub'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      // 2. MENÚ HAMBURGUESA (DRAWER LATERAL)
      // Al incluir 'drawer', Flutter dibuja automáticamente el botón hamburguesa en el AppBar
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.indigo),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.apps, color: Colors.indigo, size: 28),
                  ),
                  SizedBox(height: 10),
                  Text('ToolSuite App', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('Suite de Ejercicios Móviles', style: TextStyle(color: Colors.white70, fontSize: 11)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Menú Principal'),
              onTap: () => Navigator.pop(context), // Cierra el Drawer
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Acerca de la App'),
              onTap: () {
                Navigator.pop(context); // Cierra el Drawer antes de abrir el dialogo
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Acerca de ToolSuite'),
                    content: const Text('Aplicación integradora de retos construida en Flutter con arquitectura multi-archivo.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cerrar'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      // 3. RENDERIZADO DINÁMICO DE PANTALLAS
      body: ListView.builder(
        padding: const EdgeInsets.all(12.0),
        itemCount: herramientas.length,
        itemBuilder: (context, index) {
          final item = herramientas[index]; // Extrae el objeto de la lista según el índice
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 6.0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: item.color,
                child: Icon(item.icono, color: Colors.white),
              ),
              title: Text(item.titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(item.descripcion),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // NAVEGACIÓN DINÁMICA UTILIZANDO LA INSTANCIA DE WIDGET GUARDADA EN EL MODELO
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => item.pantallaDestino),
                );
              },
            ),
          );
        },
      ),
    );
  }
} 