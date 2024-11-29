import 'package:cloud_firestore/cloud_firestore.dart';

//Mostrar categorias
class CategoriasService {
  Stream<QuerySnapshot> mostrarRecetasGlobales() {
    return FirebaseFirestore.instance.collection('categorias').snapshots();
  }
}
