import 'package:donner/models/user_model.dart';

class ClientModel extends User {
  String phone;
  String photoUrl;
  String description;
  List<dynamic> announcements;

  ClientModel({
    required this.phone,
    required this.photoUrl,
    required this.description,
    required this.announcements,
    required String name,
    required String email,
  }) : super(name, email);

  Map<String, dynamic> toMap() {
    return {
      'phone': phone,
      'photoUrl': photoUrl,
      'description': description,
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
      announcements: List.from(map['announcements']),
    );
  }
  @override
  String toString() {
    return 'ClientModel(name: $name, email: $email, phone: $phone, photoUrl: $photoUrl, description: $description, announcements: $announcements)';
  }
}
