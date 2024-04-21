// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserEntity {
  final String uid;
  final String firstname;
  final String lastname;
  final String email;
  final List interestedCategories;
  final String profileImageUrl;

  UserEntity({
    required this.uid,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.interestedCategories,
    required this.profileImageUrl,
  });

  // factory UserEntity.toEntity(UserModel userModel) => UserEntity(
  //       firstname: userModel.firstname,
  //       lastname: userModel.lastname,
  //       email: userModel.email,
  //       interestedCategories: userModel.interestedCategories,
  //     );

  // Map<String, dynamic> toJson() => {
  //       'firstname': firstname,
  //       'lastname': lastname,
  //       'email': email,
  //     };
}
