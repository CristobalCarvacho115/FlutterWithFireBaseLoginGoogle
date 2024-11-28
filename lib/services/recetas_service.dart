import 'package:cloud_firestore/cloud_firestore.dart';

class RecetasService {
  //Mostrar recetas de toda la gente
  Stream<QuerySnapshot> mostrarRecetasGlobales() {
    return FirebaseFirestore.instance.collection('recetas').snapshots();
  }

  //Mostrar receta única
  Stream<DocumentSnapshot> mostrarReceta(String id) {
    return FirebaseFirestore.instance.collection('recetas').doc(id).snapshots();
  }

  //Agregar receta
  Future<void> agregarReceta(String nombre, String Autor, String ingredientes, String preparacion, String categoria, String imagen) async {
    await FirebaseFirestore.instance.collection('recetas').doc().set({
      'nombre': nombre,
      'autor': Autor,
      'ingredientes': ingredientes,
      'preparacion': preparacion,
      'categoria': categoria,
      'imagen': imagen,
    });
  }

  //Eliminar receta
  Future<void> eliminarReceta(String id) async {
    await FirebaseFirestore.instance.collection('recetas').doc(id).delete();
  }
}
