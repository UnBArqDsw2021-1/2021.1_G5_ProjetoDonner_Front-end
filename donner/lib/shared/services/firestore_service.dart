import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donner/models/announcement_model.dart';
import 'package:donner/models/client_model.dart';

class FirestoreService {
  final CollectionReference _userCollectionRef =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference _postCollectionRef =
      FirebaseFirestore.instance.collection('posts');

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

  Future<QuerySnapshot> getCategories() async {
    final CollectionReference categoriesRef =
        FirebaseFirestore.instance.collection('categories');

    return categoriesRef.get();
  }

  Future addPost(AnnouncementModel announcement) async {
    Map<String, dynamic> data = announcement.toMap();

    await _postCollectionRef
        .doc(announcement.id)
        .set(data)
        .catchError((e) => print(e));
  }

  Future<QuerySnapshot> getAnnouncements() async {
    final CollectionReference announcementsRef =
        FirebaseFirestore.instance.collection('posts');

    return announcementsRef.get();
  }
}
