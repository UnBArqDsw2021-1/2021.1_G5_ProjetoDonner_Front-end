import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donner/models/client_model.dart';
import 'package:donner/models/user_model.dart';

class RegisterController {
  late ClientModel client = ClientModel();
  RegisterController();

  void onChange({
    String? email,
    String? name,
    String? phone,
    String? photoUrl,
    String? description,
    String? state,
    String? city,
  }) {
    client = client.copyWith(
      name: name,
      email: email,
      phone: phone,
      photoUrl: photoUrl,
      description: description,
      state: state,
      city: city,
    );
  }

  void saveClient() {
    print(client.toString());
  }
}
