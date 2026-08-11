/// RETO INTEGRADOR de la Clase 3 · Modelo de datos POO
class Medico {
  final String id;
  final String nombre;
  final String especialidad;
  final int anosExperiencia;
  final double precioConsulta;
  final bool disponibleHoy;

  Medico({
    required this.id,
    required this.nombre,
    required this.especialidad,
    required this.anosExperiencia,
    required this.precioConsulta,
    required this.disponibleHoy,
  });
}

/// Datos de ejemplo que alimentan el ListView.builder del directorio
final List<Medico> medicosDemo = [
  Medico(
    id: '1',
    nombre: 'Dra. Laura Restrepo',
    especialidad: 'Medicina General',
    anosExperiencia: 8,
    precioConsulta: 65000,
    disponibleHoy: true,
  ),
  Medico(
    id: '2',
    nombre: 'Dr. Andrés Villamil',
    especialidad: 'Odontología',
    anosExperiencia: 12,
    precioConsulta: 90000,
    disponibleHoy: false,
  ),
  Medico(
    id: '3',
    nombre: 'Dra. Camila Ospina',
    especialidad: 'Pediatría',
    anosExperiencia: 5,
    precioConsulta: 80000,
    disponibleHoy: true,
  ),
  Medico(
    id: '4',
    nombre: 'Dr. Julián Mesa',
    especialidad: 'Dermatología',
    anosExperiencia: 15,
    precioConsulta: 120000,
    disponibleHoy: true,
  ),
  Medico(
    id: '5',
    nombre: 'Dra. Paola Guerrero',
    especialidad: 'Nutrición',
    anosExperiencia: 6,
    precioConsulta: 70000,
    disponibleHoy: false,
  ),
];
