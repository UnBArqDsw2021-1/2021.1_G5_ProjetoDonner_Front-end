abstract class User {
  String _name;
  String _email;

  User(this._name, this._email);

  void setName(String name) {
    _name = name;
  }

  String getName() {
    return _name;
  }

  void setEmail(String email) {
    _email = email;
  }

  String getEmail() {
    return _email;
  }
}
