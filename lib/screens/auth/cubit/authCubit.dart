import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test_managment/router/app_routes.dart';

import 'authState.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitial());

  Future<void> logOut({required BuildContext context}) async {
    emit(AuthLoading());
    final supabase = Supabase.instance.client;
    try {
      final response = supabase.auth.signOut();
      emit(LogOutSuccess());
      context.goNamed(AppRoutes.login);
    } catch (e) {
      emit(LogOutError(msg: e.toString()));
    }
  }

  Future<void> signUp(
      {required String mail,
      required String password,
      required BuildContext context}) async {
    final supabase = Supabase.instance.client;
    emit(AuthLoading());

    try {
      final response =
          await supabase.auth.signUp(email: mail, password: password);
      final user = response.user;
      if (user != null) {
        emit(AuthSuccess(UserId: user.id));
        context.go(AppRoutes.showTest);
      }
    } catch (e) {
      emit(AuthError(msg: e.toString()));
    }
  }

  Future<void> logIn({required String mail, required String password}) async {
    final supabase = Supabase.instance.client;
    emit(AuthLoading());

    try {
      final response = await supabase.auth
          .signInWithPassword(email: mail, password: password);
      final user = response.user;
      if (user != null) {
        emit(LogInSuccess(UserId: user.id));
      }
    } catch (e) {
      emit(LogInError(msg: e.toString()));
    }
  }
}
