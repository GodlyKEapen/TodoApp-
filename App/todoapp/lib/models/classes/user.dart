

class User {
  String username;
  String lastname;
  String firstname;
  String emailadress;
  String password;
  String api_key;
  int id;

  User(this.username, this.lastname, this.firstname, this.emailadress, this.password, this.api_key, this.id);

 factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User(
      parsedJson['username'],
      parsedJson['lastname'],
      parsedJson['firstname'],
      parsedJson['emailadress'],
      parsedJson['password'],
      parsedJson['api_key'],
      parsedJson['id']
    );
  }
}