import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gourmet_tagua_tagua/services/recetas_service.dart';
import 'package:gourmet_tagua_tagua/widgets/recetas_gloables_widget.dart';

class RecetasGlobales extends StatelessWidget {
  const RecetasGlobales({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        color: Colors.red.shade100,
        child: StreamBuilder(
          stream: RecetasService().mostrarRecetasGlobales(),
          // initialData: initialData,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var receta = snapshot.data!.docs[index];
                return recetas_globales_widget(receta: receta);
              },
            );
          },
        ),
      ),
    );
  }
}
