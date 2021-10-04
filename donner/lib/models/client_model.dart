import 'package:donner/models/user_model.dart';

class ClientModel extends User {
  String? phone;
  String? photoUrl;
  String? description;
  String? state;
  String? city;
  List<dynamic>? announcements;

  ClientModel({
    this.phone,
    this.photoUrl,
    this.description,
    this.announcements,
    this.state,
    this.city,
  }) : super("", "");

  Map<String, dynamic> toMap() {
    return {
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
      phone: map['phone'],
      photoUrl: map['photoUrl'],
      description: map['description'],
      state: map['state'],
      city: map['city'],
      announcements: List.from(map['announcements']),
    );
  }
  @override
  String toString() {
    return 'ClientModel(name: $name, email: $email, phone: $phone, photoUrl: $photoUrl, description: $description, state: $state, city: $city,announcements: $announcements)';
  }

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
      phone: phone ?? this.phone,
      photoUrl: photoUrl ?? this.photoUrl,
      description: description ?? this.description,
      state: state ?? this.state,
      city: city ?? this.city,
      announcements: announcements ?? this.announcements,
    );
  }
}
