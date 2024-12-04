import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  CollectionReference? collectionReference;

  FirestoreService() {
    collectionReference = firebaseFirestore.collection('jaguares');
  }

  Stream<QuerySnapshot> SELECT(String id) {
    return collectionReference!.where('adoptante', isEqualTo: id).snapshots();
  }

  Stream<QuerySnapshot> SELECTALL() {
    CollectionReference? collectionReference2;
    collectionReference2 = firebaseFirestore.collection('jaguaresLibres');
    print(collectionReference2.parameters.entries.first.value);
    return collectionReference2!
        .snapshots(); // Retorna todos los documentos de Firebase
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> SELECT_JAGUARES_PARA_ADOPTAR() {
    return firebaseFirestore.collection('jaguaresParaAdoptar').snapshots();
  }
}
