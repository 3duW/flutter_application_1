import 'package:flutter/material.dart';
import 'package:flutter_application_1/listado.dart';
import 'package:flutter_application_1/editar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQLite Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => Listado(),
        "/editar": (context) =>
            Editar(), // Asegúrate de que Editar esté correctamente definido
      },
    );
  }
}
