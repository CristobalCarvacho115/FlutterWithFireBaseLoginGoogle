import 'package:cloud_firestore/cloud_firestore.dart';

class CategoriasService {
  //Mostrar categorias
  Stream<QuerySnapshot> mostrarCategorias() {
    return FirebaseFirestore.instance.collection('categorias').snapshots();
  }

  //Mostrar categoría unica
  Stream<DocumentSnapshot> mostrarRecetaUnica(String tipo) {
    return FirebaseFirestore.instance.collection('recetas').doc(tipo).snapshots();
  }
}
