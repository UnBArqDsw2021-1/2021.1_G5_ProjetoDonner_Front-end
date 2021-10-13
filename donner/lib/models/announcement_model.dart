import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class AnnouncementModel {
  String? id;
  String? title;
  String? owner;
  String? images;
  String? categoryId;
  String? description;
  bool? isDonation;
  AnnouncementModel({
    this.categoryId,
    this.description,
    this.id,
    this.isDonation,
    this.owner,
    this.title,
    this.images,
  });
  AnnouncementModel copyWith({
    String? categoryId,
    String? description,
    String? id,
    bool? isDonation,
    String? owner,
    String? title,
    String? images,
  }) {
    return AnnouncementModel(
      categoryId: categoryId ?? this.categoryId,
      description: description ?? this.description,
      id: id ?? this.id,
      isDonation: isDonation ?? this.isDonation,
      owner: owner ?? this.owner,
      title: title ?? this.title,
      images: images ?? this.images,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'categoryId': categoryId,
      'description': description,
      'id': id,
      'isDonation': isDonation,
      'owner': owner,
      'title': title,
      'images': images,
    };
  }

  factory AnnouncementModel.fromMap(Map<String, dynamic> map) {
    return AnnouncementModel(
      categoryId: map['categoryId'],
      description: map['description'],
      id: map['id'],
      isDonation: map['isDonation'],
      owner: map['owner'],
      title: map['title'],
      images: map['images'],
    );
  }
  
  AnnouncementModel.fromDocument(DocumentSnapshot snapshot){
    id = snapshot.get('id');
    title = snapshot.get('title');
    description = snapshot.get('description');
    owner = snapshot.get('owner');
    images = snapshot.get('images');
    categoryId = snapshot.get('categoryId');
    isDonation = snapshot.get('isDonation');
  }
  String toJson() => json.encode(toMap());

  factory AnnouncementModel.fromJson(String source) =>
      AnnouncementModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AnnouncementModel(categoryId: $categoryId, description: $description, id: $id, isDonation: $isDonation, owner: $owner, title: $title, images: $images)';
  }
}
