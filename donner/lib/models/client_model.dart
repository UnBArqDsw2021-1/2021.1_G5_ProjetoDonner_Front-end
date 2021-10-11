import 'dart:convert';

import 'package:donner/models/user_model.dart';

class ClientModel extends User {
  String? phone;
  String? photoUrl;
  String? description;
  String? state;
  String? city;
  List<dynamic>? announcements;

  ClientModel({
    required id,
    required name,
    required email,
    this.phone,
    this.photoUrl,
    this.description,
    this.announcements,
    this.state,
    this.city,
  }) : super(name, email, id);

  ClientModel copyWith({
    String? id,
    String? email,
    String? name,
    String? phone,
    String? photoUrl,
    String? description,
    String? state,
    String? city,
    List<dynamic>? announcements,
  }) {
    return ClientModel(
      id: id ?? super.id,
      name: name ?? super.name,
      email: email ?? super.email,
      phone: phone ?? this.phone,
      photoUrl: photoUrl ?? this.photoUrl,
      description: description ?? this.description,
      state: state ?? this.state,
      city: city ?? this.city,
      announcements: announcements ?? this.announcements,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'photoUrl': photoUrl,
      'description': description,
      'state': state,
      'city': city,
      'announcements': announcements,
    };
  }

  // factory ClientModel.fromMap(Map<String, dynamic> map) {
  //   return ClientModel(
  //     name: map['name'],
  //     email: map['email'],
  //     photoUrl: map['photoUrl'],
  //     phone: map['phone'],
  //     description: map['description'],
  //     state: map['state'],
  //     city: map['city'],
  //     announcements: List<dynamic>.from(map['announcements'] ?? []),
  //   );
  // }

  String toJson() => json.encode(toMap());

  // factory ClientModel.fromJson(String source) =>
  //     ClientModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ClientModel(name: $name, email: $email, phone: $phone, photoUrl: $photoUrl, description: $description, state: $state, city: $city, announcements: $announcements)';
  }

  factory ClientModel.fromSnapshot(var snapshot) {
    return ClientModel(
      id: snapshot['id'],
      name: snapshot['name'],
      email: snapshot['email'],
      photoUrl: snapshot['photoUrl'],
      phone: snapshot['phone'],
      description: snapshot['description'],
      state: snapshot['state'],
      city: snapshot['city'],
      announcements: snapshot['announcements'],
    );
  }
}
