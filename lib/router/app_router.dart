import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test_managment/screens/auth/login.dart';
import 'package:test_managment/screens/auth/signup.dart';
import 'package:test_managment/screens/test/insert_test/insertTest.dart';
import 'package:test_managment/screens/test/model/unitModel.dart';
import 'package:test_managment/screens/test/show_test/showTest.dart';

import '../screens/test/insert_test/createTest.dart';
import '../screens/test/insert_test/select_create_Unit.dart';
import 'app_routes.dart';

final supabase = Supabase.instance.client;

class AppRouter {
  static final router = GoRouter(
      initialLocation: '/login',
      redirect: (context, state) {
        final session = supabase.auth.currentSession;
        final isLoggedIn = session != null;
        final isLogin = state.matchedLocation == '/login';

        if (!isLoggedIn && !isLogin) return '/login';
        if (isLoggedIn && isLogin) return '/show_test';

        return null;
      },
      routes: [
        GoRoute(
            path: '/login',
            name: AppRoutes.login,
            builder: (context, state) => const Login()),
        GoRoute(
            path: '/signup',
            name: AppRoutes.signup,
            builder: (context, state) => const Signup()),
        GoRoute(
            path: '/show_test',
            name: AppRoutes.showTest,
            builder: (context, state) => const ShowTest()),
        GoRoute(
            path: '/insert_test',
            name: AppRoutes.insertTest,
            builder: (context, state) {
              final unit = state.extra;

              if (unit == null || unit is! UnitModel) {
                return const Scaffold(
                  body: Center(
                    child: Text('Invalid navigation: Unit not found'),
                  ),
                );
              }
              return InsertTest(unit: unit);
            }),
        GoRoute(
            path: '/SelectCreateUnit',
            name: AppRoutes.selectCreateUnit,
            builder: (context, state) => const SelectCreateUnit()),
        GoRoute(
            path: '/CreateTest',
            name: AppRoutes.createTest,
            builder: (context, state) => const CreateTest()),

      ]);
}
