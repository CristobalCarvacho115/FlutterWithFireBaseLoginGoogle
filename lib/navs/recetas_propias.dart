import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gourmet_tagua_tagua/navs/recetas_mostrar.dart';
import 'package:gourmet_tagua_tagua/services/recetas_service.dart';
import 'package:gourmet_tagua_tagua/widgets/recetas_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class RecetasPropias extends StatefulWidget {
  const RecetasPropias({super.key});

  @override
  State<RecetasPropias> createState() => _RecetasPropiasState();
}

class _RecetasPropiasState extends State<RecetasPropias> {
  final String autor = FirebaseAuth.instance.currentUser!.displayName!;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        color: Colors.red.shade100,
        child: StreamBuilder(
          stream: RecetasService().mostrarRecetasPropias(autor),
          // initialData: initialData,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var receta = snapshot.data!.docs[index];
                return Slidable(
                  //EDITAR
                  endActionPane: ActionPane(
                    motion: ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          MaterialPageRoute route = MaterialPageRoute(
                            builder: (context) => RecetaMostrar(
                              receta: receta,
                            ),
                          );
                          Navigator.push(context, route).then((value) {
                            setState(() {});
                          });
                        },
                        backgroundColor: Colors.blue,
                        label: 'Ver Receta',
                        icon: MdiIcons.eye,
                      ),
                    ],
                  ),
                  //BORRAR
                  startActionPane: ActionPane(
                    motion: ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          _confirmBorrado(context).then((confirmaBorrado) {
                            if (confirmaBorrado) {
                              setState(
                                () {
                                  RecetasService().eliminarReceta(receta.id);
                                },
                              );
                            }
                          });
                        },
                        backgroundColor: Colors.red,
                        label: 'Borrar Tarjeta',
                        icon: MdiIcons.trashCan,
                      ),
                    ],
                  ),
                  child: recetas_widget(receta: receta),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<dynamic> _confirmBorrado(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('¿Desesa borrar la receta?'),
          content: Text('No podrá recuperar la receta una vez borrada.'),
          actions: [
            TextButton(
              child: Text('CANCELAR'),
              onPressed: () => Navigator.pop(context, false),
            ),
            FilledButton(
              child: Text('ACEPTAR'),
              onPressed: () => Navigator.pop(context, true),
            ),
          ],
        );
      },
    );
  }
}
