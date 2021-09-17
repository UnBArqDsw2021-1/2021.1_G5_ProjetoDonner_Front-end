import 'package:donner/widgets/models/user_model.dart';

class ClientModel extends User {
  String _phone;
  String _photoUrl;
  String _description;
  List<dynamic> _announcements;

  ClientModel({
    required String phone,
    required String photoUrl,
    required String description,
    required List<dynamic> announcements,
    required String name,
    required String email,
  })  : _phone = phone,
        _photoUrl = photoUrl,
        _description = description,
        _announcements = announcements,
        super(name, email);

  String getPhone() {
    return _phone;
  }

  void setPhone(String phone) {
    _phone = phone;
  }

  String getPhotoUrl() {
    return _photoUrl;
  }

  void setPhotoUrl(String photoUrl) {
    _photoUrl = photoUrl;
  }

  String getDescription() {
    return _description;
  }

  void setDescription(String description) {
    _description = description;
  }

  List<dynamic> getAnnoucements() {
    return _announcements;
  }

  void setAnnoucements(List<dynamic> announcements) {
    _announcements = announcements;
  }

  Map<String, dynamic> toMap() {
    return {
      '_phone': _phone,
      '_photoUrl': _photoUrl,
      '_description': _description,
      '_announcements': _announcements,
    };
  }

  factory ClientModel.fromMap(Map<String, dynamic> map) {
    return ClientModel(
      name: map['name'],
      email: map['email'],
      phone: map['_phone'],
      photoUrl: map['_photoUrl'],
      description: map['_description'],
      announcements: List.from(map['_announcements']),
    );
  }
  @override
  String toString() {
    return 'ClientModel(_name: ${getName()},_email: ${getEmail()} ,_phone: $_phone, _photoUrl: $_photoUrl, _description: $_description, _annoucements: $_announcements)';
  }

// ClientModel copyWith({
  //   String? _phone,
  //   String? _photoUrl,
  //   String? _description,
  //   List? _annoucements,
  // }) {
  //   return ClientModel(
  //     _phone: _phone ?? this._phone,
  //     _photoUrl: _photoUrl ?? this._photoUrl,
  //     _description: _description ?? this._description,
  //     _annoucements: _annoucements ?? this._annoucements,
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory ClientModel.fromJson(String source) => ClientModel.fromMap(json.decode(source));

  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) return true;
  //   final listEquals = const DeepCollectionEquality().equals;

  //   return other is ClientModel &&
  //     other._phone == _phone &&
  //     other._photoUrl == _photoUrl &&
  //     other._description == _description &&
  //     listEquals(other._annoucements, _annoucements);
  // }

  // @override
  // int get hashCode {
  //   return _phone.hashCode ^
  //     _photoUrl.hashCode ^
  //     _description.hashCode ^
  //     _annoucements.hashCode;
  // }
}
