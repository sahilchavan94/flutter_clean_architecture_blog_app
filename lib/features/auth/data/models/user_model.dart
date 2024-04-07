class UserModel {
  final String firstname;
  final String lastname;
  final String email;

  UserModel({
    required this.firstname,
    required this.lastname,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        firstname: json['firstname'] ?? '',
        lastname: json['lastname'] ?? '',
        email: json['email'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'firstname': firstname,
        'lastname': lastname,
        'email': email,
      };
}
