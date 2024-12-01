import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gourmet_tagua_tagua/services/categorias_service.dart';
import 'package:gourmet_tagua_tagua/services/recetas_service.dart';

class RecetasAgregar extends StatefulWidget {
  const RecetasAgregar({super.key});

  @override
  State<RecetasAgregar> createState() => _RecetasAgregarState();
}

class _RecetasAgregarState extends State<RecetasAgregar> {
  final formKey = GlobalKey<FormState>();

  TextEditingController nombreCtrl = TextEditingController();
  TextEditingController ingredientesCtrl = TextEditingController();
  TextEditingController preparacionCtrl = TextEditingController();
  String categoriaSeleccionada = 'Guisos';
  String imagen = 'guiso.jpg';
  final String autor = FirebaseAuth.instance.currentUser!.displayName!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar receta'),
        backgroundColor: Colors.purple.shade300,
        foregroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: TextFormField(
                    validator: (nombre) {
                      if (nombre!.isEmpty) {
                        return 'El nombre es requerido';
                      } else if (nombre.length > 50) {
                        return 'El nombre debe tener menos de 40 caracteres';
                      }
                      return null;
                    },
                    controller: nombreCtrl,
                    decoration: InputDecoration(
                      labelText: 'Nombre',
                      labelStyle: TextStyle(fontSize: 20),
                      hintText: 'Nombre de la receta',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: TextFormField(
                    validator: (ingrediente) {
                      if (ingrediente!.isEmpty) {
                        return 'Por favor ingrese los ingredientes';
                      }
                      return null;
                    },
                    controller: ingredientesCtrl,
                    decoration: InputDecoration(
                      labelText: 'Ingredientes',
                      labelStyle: TextStyle(fontSize: 20),
                      hintText: 'Separe con una coma (x, y) los ingredientes',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: TextFormField(
                    validator: (preparacion) {
                      if (preparacion!.isEmpty) {
                        return 'Por favor ingrese los pasos';
                      }
                      return null;
                    },
                    controller: preparacionCtrl,
                    decoration: InputDecoration(
                      labelText: 'Preparación',
                      labelStyle: TextStyle(fontSize: 20),
                      hintText: 'Separe con números y un punto (1. xx 2. yy)',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      child: Text('Categoria:', style: TextStyle(fontSize: 20)),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      child: StreamBuilder<QuerySnapshot>(
                        stream: CategoriasService().mostrarCategorias(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          }

                          List<DropdownMenuItem<String>> categoriasItems = snapshot.data!.docs.map((doc) {
                            Map<String, dynamic> categoria = doc.data() as Map<String, dynamic>;
                            return DropdownMenuItem<String>(
                              value: categoria['tipo'],
                              child: Text(
                                categoria['tipo'],
                                style: TextStyle(fontSize: 20),
                              ),
                            );
                          }).toList();

                          return Container(
                            child: DropdownButton<String>(
                              hint: Text('Selecciona una categoría       '),
                              value: categoriaSeleccionada,
                              items: categoriasItems,
                              onChanged: (value) {
                                setState(() {
                                  categoriaSeleccionada = value!;
                                  imagen = _imagenSeleccionada(categoriaSeleccionada);
                                  ;
                                });
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.purple.shade300),
                    ),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        await RecetasService().agregarReceta(
                          nombreCtrl.text,
                          autor,
                          ingredientesCtrl.text,
                          preparacionCtrl.text,
                          categoriaSeleccionada,
                          imagen,
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      'Agregar Receta',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _imagenSeleccionada(String categoria) {
    switch (categoria) {
      case 'Guisos':
        return 'guiso.jpg';
      case 'Fritura':
        return 'fritura.jpg';
      case 'Navideño':
        return 'navideno.jpg';
      case 'Vegetariano':
        return 'vegetariano.jpg';
      case 'Postres':
        return 'postre.jpg';
      case 'Pastas':
        return 'pasta.jpg';
      default:
        return 'guiso.jpg';
    }
  }
}
