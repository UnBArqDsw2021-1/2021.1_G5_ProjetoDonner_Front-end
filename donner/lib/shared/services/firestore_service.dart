import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donner/models/client_model.dart';

class FirestoreService {
  final CollectionReference _userCollectionRef =
      FirebaseFirestore.instance.collection('users');

  Future addUser(ClientModel client, String uid) async {
    Map<String, dynamic> data = client.toMap();

    await _userCollectionRef.doc(uid).set(data).catchError((e) => print(e));
  }

  Future<DocumentSnapshot> findUser(String uid) async {
    final user = await _userCollectionRef.doc(uid).get();
    if (user.exists) {
      return user;
    }
    return user;
  }

  Future updateUser({required ClientModel user}) async {
    Map<String, dynamic> data = user.toMap();
    await _userCollectionRef
        .doc(user.id)
        .update(data)
        .catchError((e) => print(e));
  }
}
