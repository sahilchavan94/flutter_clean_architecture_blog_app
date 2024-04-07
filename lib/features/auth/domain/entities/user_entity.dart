// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blog_app/features/auth/data/models/user_model.dart';

class UserEntity {
  final String firstname;
  final String lastname;
  final String email;

  UserEntity({
    required this.firstname,
    required this.lastname,
    required this.email,
  });

  factory UserEntity.toEntity(UserModel userModel) => UserEntity(
        firstname: userModel.firstname,
        lastname: userModel.lastname,
        email: userModel.email,
      );

  // Map<String, dynamic> toJson() => {
  //       'firstname': firstname,
  //       'lastname': lastname,
  //       'email': email,
  //     };
}
