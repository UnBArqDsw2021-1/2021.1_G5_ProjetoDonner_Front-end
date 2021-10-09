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
    required name,
    required email,
    this.phone,
    this.photoUrl,
    this.description,
    this.announcements,
    this.state,
    this.city,
  }) : super(name, email);

  ClientModel copyWith({
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

  factory ClientModel.fromMap(Map<String, dynamic> map) {
    return ClientModel(
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      photoUrl: map['photoUrl'],
      description: map['description'],
      state: map['state'],
      city: map['city'],
      announcements: List<dynamic>.from(map['announcements'] ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory ClientModel.fromJson(String source) =>
      ClientModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ClientModel(name: $name, email: $email, phone: $phone, photoUrl: $photoUrl, description: $description, state: $state, city: $city, announcements: $announcements)';
  }

  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) return true;

  //   return other is ClientModel &&
  //     other.phone == phone &&
  //     other.photoUrl == photoUrl &&
  //     other.description == description &&
  //     other.state == state &&
  //     other.city == city &&
  //     listEquals(other.announcements, announcements);
  // }

  // @override
  // int get hashCode {
  //   return phone.hashCode ^
  //     photoUrl.hashCode ^
  //     description.hashCode ^
  //     state.hashCode ^
  //     city.hashCode ^
  //     announcements.hashCode;
  // }
}
