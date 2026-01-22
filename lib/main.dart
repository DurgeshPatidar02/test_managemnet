import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:test_managment/router/app_router.dart';
import 'package:test_managment/screens/auth/cubit/authCubit.dart';
import 'package:test_managment/screens/test/cubit/fetch_cubit/testFetchCubit.dart';
import 'package:test_managment/screens/test/cubit/fetch_unit/FetchTab1Cubit.dart';
import 'package:test_managment/screens/test/cubit/fetch_unit/FetchTab2Cubit.dart';
import 'package:test_managment/screens/test/cubit/insert_cubit.dart';

import 'core/theme/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      anonKey: dotenv.env['SUPABASW_ANON_KEY']!);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => InsertCubit()),
          BlocProvider(create: (_) => TestFetchCubit()),
          BlocProvider(create: (_) => AuthCubit()),
          BlocProvider(create: (_) => FetchTab1Cubit()),
          BlocProvider(create: (_) => FetchTab2Cubit()),
        ],
        child: MaterialApp.router(
          routerConfig: AppRouter.router,
          debugShowCheckedModeBanner: false,
          theme: appTheme,
        ));
  }
}
