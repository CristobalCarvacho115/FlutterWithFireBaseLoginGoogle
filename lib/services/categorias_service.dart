import 'package:cloud_firestore/cloud_firestore.dart';

class CategoriasService {
  //Mostrar categorias usado para dropdown/ComboBox
  Stream<QuerySnapshot> mostrarCategorias() {
    return FirebaseFirestore.instance.collection('categorias').snapshots();
  }
}
