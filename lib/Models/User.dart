
class User{
  String _name;
  String _lastName;
  String _email;
  String _password;

  User(this._name, this._lastName, this._email, this._password);

  String get password => _password;

  set password(String value) {
    _password = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get lastName => _lastName;

  set lastName(String value) {
    _lastName = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  @override
  String toString() {
    return 'User{_name: $_name, _lastName: $_lastName, _email: $_email, _password: $_password}';
  }
}