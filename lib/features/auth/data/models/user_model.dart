class UserModel {
  final String firstname;
  final String lastname;
  final String email;
  final List interestedCategories;

  UserModel({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.interestedCategories,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        firstname: json['firstname'] ?? '',
        lastname: json['lastname'] ?? '',
        email: json['email'] ?? '',
        interestedCategories: json['interested_categories'] ?? [],
      );

  Map<String, dynamic> toJson() => {
        'firstname': firstname,
        'lastname': lastname,
        'email': email,
      };
}
