import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel{
  String? category;
  String? id;
  String? icon;

  CategoryModel.fromDocument(DocumentSnapshot snapshot){
    id = snapshot.reference.id;
    category = snapshot.get('category');
    icon = snapshot.get('icon');
  }
}