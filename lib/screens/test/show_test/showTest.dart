// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:test_managment/router/app_routes.dart';
// import 'package:test_managment/screens/auth/cubit/authCubit.dart';
//
// import '../../../core/theme/theme.dart';
// import '../../auth/cubit/authState.dart';
//
// class ShowTest extends StatefulWidget {
//   const ShowTest({super.key});
//
//   @override
//   State<ShowTest> createState() => _ShowTestState();
// }
//
// class _ShowTestState extends State<ShowTest> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     // context.read<TestFetchCubit>().fetchTest();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Test"),
//         actions: [
//           TextButton(
//               onPressed: () async {
//                 // context.read<AuthCubit>().logOut(context: context);
//               },
//               child: Text("LogOut"))
//         ],
//       ),
//       body: Center(child: Text("Home"),),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: PRIMARY_COLOR,
//         onPressed: () {
//           context.pushNamed(AppRoutes.selectCreateUnit);
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
