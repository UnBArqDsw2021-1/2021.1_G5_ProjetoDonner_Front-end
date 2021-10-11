abstract class User {
  String _id;
  String name;
  String email;

  User(
    this.name,
    this.email,
    this._id
  );

  get id => _id;

  @override
  String toString() => 'User(name: $name, email: $email)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is User &&
      other.name == name &&
      other.email == email;
  }

  @override
  int get hashCode => name.hashCode ^ email.hashCode;
}
