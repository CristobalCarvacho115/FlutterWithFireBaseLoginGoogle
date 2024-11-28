import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class recetas_globales_widget extends StatelessWidget {
  const recetas_globales_widget({
    super.key,
    required this.receta,
  });

  final QueryDocumentSnapshot<Object?> receta;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      color: Colors.white,
      child: Slidable(
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {},
              icon: Icons.delete,
              label: 'Eliminar',
              backgroundColor: Colors.red,
            )
          ],
        ),
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
            Expanded(
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(receta['nombre'], style: TextStyle(fontSize: 18)),
                      Text('Categoría: ${receta['categoria']}', style: TextStyle(fontSize: 14)),
                      Text('Autor: ${receta['autor']}', style: TextStyle(fontSize: 14)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [ElevatedButton(onPressed: () {}, child: Text('Ver'))],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _mostrarIngredientes(String ingredientes) {
    return '- ' + ingredientes.trim().replaceAll(RegExp(r','), '\n-');
  }
}
