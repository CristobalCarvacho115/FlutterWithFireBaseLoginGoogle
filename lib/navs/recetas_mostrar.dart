import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RecetaMostrar extends StatelessWidget {
  const RecetaMostrar({super.key, required this.receta});
  //Recibe la receta seleccionada
  final QueryDocumentSnapshot<Object?> receta;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ver receta'),
        backgroundColor: Colors.purple.shade300,
        foregroundColor: Colors.white,
      ),
      body: ListView(children: [
        Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(receta['nombre'], style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              ),
              Row(
                children: [
                  //Imagen de la receta
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    constraints: BoxConstraints(
                      minWidth: 130,
                      minHeight: 130,
                      maxWidth: 130,
                      maxHeight: 130,
                    ),
                    child: Image.asset(
                      'assets/images/${receta['imagen']}',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: 240,
                    ),
                    child: Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Categoría: ${receta['categoria']}', style: TextStyle(fontSize: 18)),
                            Text('Autor: ${receta['autor']}', style: TextStyle(fontSize: 18)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Ingredientes:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Text(_mostrarIngredientes(receta['ingredientes']), style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Preparación:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Text(_mostrarPreparacion(receta['preparacion']), style: TextStyle(fontSize: 18)),
                    Divider(),
                  ],
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }

  //Muestra los ingredientes de la receta con un guión y salto de linea
  String _mostrarIngredientes(String ingredientes) {
    return '- ' + ingredientes.trim().replaceAll(RegExp(r','), '\n-');
  }

  //Muestra la preparación de la receta con un número y salto de linea
  String _mostrarPreparacion(String preparacion) {
    int numero = 1;
    bool continuar = true;
    while (continuar) {
      if (preparacion.indexOf('${numero.toString()}.') != -1) {
        preparacion = preparacion.trim().replaceAll('${numero.toString()}.', '\n\n${numero.toString()}. ');
        numero++;
      } else {
        continuar = false;
      }
    }
    return preparacion;
  }
}
