# Desarrollo Móvil con Flutter — Clases 2 y 3

Material de clase y ejercicios resueltos del curso de desarrollo móvil.

## Contenido

| Carpeta / archivo | Qué es |
|---|---|
| `flutter_application_1/` | **ToolSuite** — app integradora de la Clase 3: menú hub con `ListView.builder`, `Drawer` y navegación con `Navigator.push()` hacia cada ejercicio en su propio archivo `.dart` |
| `calculadora_app/` | Proyecto independiente — Calculadora Pro de la Clase 2 con las 4 operaciones (+, −, ×, ÷) |
| `encuesta_app/` | Proyecto independiente — Encuesta de Satisfacción de la Clase 2 |
| `clase_2_*.html` | Guía interactiva de la Clase 2: anatomía de widgets, laboratorios visuales, taller y 4 retos con simuladores |
| `clase_3_*.html` | Guía interactiva de la Clase 3: navegación, POO, arquitectura multi-archivo y reto integrador |

## La ToolSuite

`flutter_application_1` reúne los ejercicios como pantallas separadas:

```
lib/
├── main.dart                     → MaterialApp + MenuScreen
├── models/
│   ├── herramienta.dart          → modelo POO de cada tarjeta del menú
│   └── medico.dart               → modelo del reto integrador (Clase 3)
└── screens/
    ├── menu_screen.dart          → hub con Drawer y ListView.builder
    ├── cotizador_screen.dart     → Reto 1: Dropdown, RadioListTile, SwitchListTile
    ├── encuesta_screen.dart      → Reto 2: Slider, CheckboxListTile, ChoiceChip
    ├── propina_screen.dart       → Reto 3: SegmentedButton, IconButton
    └── citas_screen.dart         → Reto 4: showDatePicker(), ChoiceChip
```

## Cómo ejecutar

Requiere Flutter 3.44 o superior.

```bash
cd flutter_application_1      # o calculadora_app / encuesta_app
flutter pub get
flutter run
```

Para ver las guías HTML basta abrirlas en el navegador (no necesitan servidor).

## Pruebas

Cada proyecto trae pruebas de widget:

```bash
flutter test
flutter analyze
```

| Proyecto | Pruebas |
|---|---|
| `flutter_application_1` | 3 — el hub lista las herramientas, cada una abre y regresa con `pop`, el drawer se abre |
| `calculadora_app` | 7 — las 4 operaciones, división entre cero, campos vacíos y limpiar |
| `encuesta_app` | 3 — estado inicial, cambio de canal y `SnackBar` al enviar |
