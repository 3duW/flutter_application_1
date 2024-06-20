import 'package:flutter/material.dart';
import 'animal.dart';
import 'package:flutter_application_1/db.dart';

class Editar extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final nombreController = TextEditingController();
  final especieController = TextEditingController();

  Editar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Animal animal = ModalRoute.of(context)!.settings.arguments as Animal;
    nombreController.text = animal.nombre;
    especieController.text = animal.especie;

    return Scaffold(
      appBar: AppBar(
        title: Text("Guardar"),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: nombreController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "El nombre es obligatorio";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Nombre",
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: especieController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "La especie es obligatoria";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Especie",
                ),
              ),
              SizedBox(
                  height:
                      20), // Agrega espacio entre los TextFormFields y el botón
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Realiza la actualización del animal sin modificar los campos final
                    Animal updatedAnimal = Animal(
                      id: animal.id, // Asegura que el ID se mantenga
                      nombre: nombreController.text,
                      especie: especieController.text,
                    );

                    if (animal.id != null && animal.id! > 0) {
                      DB.update(updatedAnimal);
                    } else {
                      DB.insert(updatedAnimal);
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text("Guardar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
