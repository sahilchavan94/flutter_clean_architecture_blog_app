// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:blog_app/core/common/cubits/cubit/current_user_cubit.dart';
import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/features/auth/domain/entities/user_entity.dart';
import 'package:blog_app/features/auth/domain/usecases/get_user.dart';
import 'package:blog_app/features/auth/domain/usecases/sign_in.dart';
import 'package:blog_app/features/auth/domain/usecases/sign_out.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:blog_app/features/auth/domain/usecases/sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUp signUp;
  final SignIn signIn;
  final GetUser getUser;
  final SignOut signOut;
  final CurrentUserCubit currentUserCubit;

  AuthBloc(
    this.signUp,
    this.signIn,
    this.currentUserCubit,
    this.getUser,
    this.signOut,
  ) : super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignup>(_authSignUp);
    on<AuthSignIn>(_authSignIn);
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);
    on<AuthSignOut>(_authSignOut);
  }

  FutureOr<void> _isUserLoggedIn(
      AuthIsUserLoggedIn event, Emitter<AuthState> emit) async {
    final response = await getUser.call();
    response.fold(
      (l) => emit(AuthFailure("User not logged in")),
      (r) => _emitAuthSuccess(emit, r),
    );
  }

  FutureOr<void> _authSignUp(AuthSignup event, Emitter<AuthState> emit) async {
    try {
      final response = await signUp.call(
        event.firstname,
        event.lastname,
        event.email,
        event.password,
      );
      response.fold(
        (l) => emit(AuthFailure(l.message)),
        (r) => emit(AuthSuccess()),
      );
    } on ServerException catch (e) {
      emit(AuthFailure(e.error));
    }
  }

  FutureOr<void> _authSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
    try {
      final response = await signIn.call(
        event.email,
        event.password,
      );
      response.fold(
        (l) => emit(AuthFailure(l.message)),
        (r) => emit(AuthSuccess()),
      );
    } on ServerException catch (e) {
      emit(AuthFailure(e.error));
    }
  }

  FutureOr<void> _authSignOut(
      AuthSignOut event, Emitter<AuthState> emit) async {
    try {
      final response = await signOut.call();
      response.fold((l) => emit(AuthFailure(l.message)), (r) {
        //update the user cubit
        _emitAuthSuccess(emit, null);
        //update the state
        emit(AuthSignedOut());
      });
    } on ServerException catch (e) {
      emit(AuthFailure(e.error));
    }
  }

  //method to update the cubit state of auth success
  void _emitAuthSuccess(
    Emitter<AuthState> emit,
    UserEntity? user,
  ) {
    currentUserCubit.updateUser(user);
  }
}