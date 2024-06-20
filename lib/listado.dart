import 'package:flutter/material.dart';
import 'package:flutter_application_1/animal.dart';
import 'package:flutter_application_1/db.dart'; // Importa la clase DB

class Listado extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animales"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(
            context,
            "/editar",
            arguments: Animal(id: 0, nombre: "", especie: ""),
          );
        },
      ),
      body: Container(
        child: Lista(),
      ),
    );
  }
}

class Lista extends StatefulWidget {
  @override
  _MiLista createState() => _MiLista();
}

class _MiLista extends State<Lista> {
  List<Animal> animales = [];

  @override
  void initState() {
    super.initState();
    cargaAnimales();
  }

  cargaAnimales() async {
    List<Animal> auxAnimal = await DB.animales();
    setState(() {
      animales = auxAnimal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: animales.length,
      itemBuilder: (context, i) => Dismissible(
        key: Key(i.toString()),
        direction: DismissDirection.startToEnd,
        background: Container(
          color: Colors.red,
          padding: EdgeInsets.only(left: 5),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Icon(Icons.delete, color: Colors.white),
          ),
        ),
        onDismissed: (direction) {
          DB.delete(animales[i]);
          setState(() {
            animales.removeAt(i);
          });
        },
        child: ListTile(
          title: Text(animales[i].nombre),
          trailing: MaterialButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                "/editar",
                arguments: animales[i],
              );
            },
            child: Icon(Icons.edit),
          ),
        ),
      ),
    );
  }
}
