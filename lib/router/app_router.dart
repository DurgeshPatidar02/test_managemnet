import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test_managment/screens/auth/login.dart';
import 'package:test_managment/screens/auth/signup.dart';
import 'package:test_managment/screens/test/cubit/bottomNavBar/BNBCubit.dart';
import 'package:test_managment/screens/test/cubit/question/addQuestionCubit.dart';
import 'package:test_managment/screens/test/cubit/question/cmsCubit/cmsFileCubit.dart';
import 'package:test_managment/screens/test/model/testModel.dart';
import 'package:test_managment/screens/test/model/unitModel.dart';

import '../home.dart';
import '../screens/test/cubit/fileInsertCubit.dart';
import '../screens/test/cubit/test/tab1/testTab1Cubit.dart';
import '../screens/test/cubit/test/tab2/testTab2Cubit.dart';
import '../screens/test/cubit/unit/Tab1Cubit.dart';
import '../screens/test/cubit/unit/Tab2Cubit.dart';
import '../screens/test/testOperation/question/QuestionsCrudServices.dart';
import '../screens/test/testOperation/select_create_Unit.dart';
import '../screens/test/testOperation/select_create_test.dart';
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
        if (isLoggedIn && isLogin) return '/home';

        return null;
      },
      routes: [
        GoRoute(
            path: '/home',
            name: AppRoutes.home,
            builder: (context, state) => const Home()),
        GoRoute(
            path: '/login',
            name: AppRoutes.login,
            builder: (context, state) => const Login()),
        GoRoute(
            path: '/signup',
            name: AppRoutes.signup,
            builder: (context, state) => const Signup()),
        // GoRoute(
        //     path: '/show_test',
        //     name: AppRoutes.showTest,
        //     builder: (context, state) => const ShowTest()),

        GoRoute(
            path: '/SelectCreateUnit',
            name: AppRoutes.selectCreateUnit,
            // builder: (context, state) => const SelectCreateUnit()),
            builder: (context, state) {
              return MultiBlocProvider(providers: [
                BlocProvider(create: (_) => FetchTab1Cubit()),
                BlocProvider(create: (_) => FetchTab2Cubit()),
              ], child: const SelectCreateUnit());
            }),
        GoRoute(
            path: '/SelectCreateTest',
            name: AppRoutes.selectCreateTest,
            builder: (context, state) {
              final unit = state.extra;

              if (unit == null || unit is! UnitModel) {
                return const Scaffold(
                  body: Center(
                    child: Text('Invalid navigation: Unit not found'),
                  ),
                );
              }
              return MultiBlocProvider(providers: [
                BlocProvider(create: (_) => TestTab1Cubit()),
                BlocProvider(create: (_) => TestTab2Cubit()),
              ], child: SelectCreateTest(unit: unit));
            }),
    
        GoRoute(
            path: '/questionsCrudServices',
            name: AppRoutes.questionsCrudServices,
            builder: (context, state) {
             final extra = state.extra as Map<String, dynamic>?;
             final test = extra?['test'];
             final unit = extra?['unit'];

              if (test == null || test is! TestModel && unit == null ||unit is! UnitModel ) {
                return const Scaffold(
                  body: Center(
                    child: Text('Invalid navigation: Unit not found'),
                  ),
                );
              }
              return MultiBlocProvider(providers: [
                BlocProvider(create: (_) => TestTab1Cubit()),
                BlocProvider(create: (_) => TestTab2Cubit()),
                BlocProvider(create: (_) => CmsFileCubit()),
                BlocProvider(create: (_) => BNBCubit()),
                BlocProvider(create: (_) => FileInsertCubit()),
              ], child: QuestionsCrudServices(test: test, unit: unit, ));
            })
      ]);
}
