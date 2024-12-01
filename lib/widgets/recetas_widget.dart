import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class recetas_widget extends StatelessWidget {
  const recetas_widget({
    super.key,
    required this.receta,
  });

  final QueryDocumentSnapshot<Object?> receta;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 10),
              constraints: BoxConstraints(
                minWidth: 120,
                minHeight: 120,
                maxWidth: 120,
                maxHeight: 120,
              ),
              child: Image.asset(
                'assets/images/${receta['imagen']}',
                fit: BoxFit.fitHeight,
              ),
            ),
            Container(
              constraints: BoxConstraints(
                maxWidth: 240,
                // maxHeight: 120,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(receta['nombre'], style: TextStyle(fontSize: 17)),
                  Text('Categoría: ${receta['categoria']}', style: TextStyle(fontSize: 15)),
                  Text('Autor: ${receta['autor']}', style: TextStyle(fontSize: 15)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
