// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blog_app/features/auth/data/models/user_model.dart';

class UserEntity {
  final String firstname;
  final String lastname;
  final String email;
  final List<String> interestedCategories;

  UserEntity({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.interestedCategories,
  });

  factory UserEntity.toEntity(UserModel userModel) => UserEntity(
        firstname: userModel.firstname,
        lastname: userModel.lastname,
        email: userModel.email,
        interestedCategories: userModel.interestedCategories,
      );

  // Map<String, dynamic> toJson() => {
  //       'firstname': firstname,
  //       'lastname': lastname,
  //       'email': email,
  //     };
}
