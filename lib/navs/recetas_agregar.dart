import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
  TextEditingController categoriaCtrl = TextEditingController();
  String imagen = 'generica';
  final String autor = FirebaseAuth.instance.currentUser!.displayName!;

  String? nombreError;
  String? ingredientesError;
  String? preparacionError;
  String? categoriaError;
  String? imagenError;
  String? autorError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar receta'),
        backgroundColor: Colors.purple.shade300,
        foregroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
      ),
    );
  }

  String _imagenGuardar(String imagen) {
    switch (imagen) {
      case 'Guisos':
        return 'guiso.jpg';
      case 'Saludable':
        return 'saludable.jpg';
      case 'Pasteles':
        return 'pastel.jpg';
      case 'Sopas':
        return 'sopa.jpg';
      default:
        return 'generica.jpg';
    }
  }
}
