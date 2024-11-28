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
  TextEditingController imagenCtrl = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar receta'),
        backgroundColor: Colors.purple.shade200,
        foregroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
      ),
    );
  }
}
