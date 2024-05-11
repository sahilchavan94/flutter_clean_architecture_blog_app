part of 'favs_bloc.dart';

@immutable
sealed class FavsEvent {}

class FavsAddToFavsEvent extends FavsEvent {
  final BlogModel blogModel;
  FavsAddToFavsEvent({required this.blogModel});
}

class FavsCheckInFavsEvent extends FavsEvent {
  final String uid;
  FavsCheckInFavsEvent({required this.uid});
}
