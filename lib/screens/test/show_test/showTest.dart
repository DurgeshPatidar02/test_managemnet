import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_managment/router/app_routes.dart';
import 'package:test_managment/screens/auth/cubit/authCubit.dart';
import 'package:test_managment/screens/test/cubit/fetch_cubit/testFetchCubit.dart';
import 'package:test_managment/screens/test/cubit/fetch_cubit/testFetchState.dart';

import '../../../core/theme/theme.dart';
import '../../auth/cubit/authState.dart';

class ShowTest extends StatefulWidget {
  const ShowTest({super.key});

  @override
  State<ShowTest> createState() => _ShowTestState();
}

class _ShowTestState extends State<ShowTest> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<TestFetchCubit>().fetchTest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test"),
        actions: [
          TextButton(
              onPressed: () async {
                context.read<AuthCubit>().logOut(context: context);
              },
              child: Text("LogOut"))
        ],
      ),
      body: BlocConsumer<TestFetchCubit, TestFetchState>(
          builder: (context, state) {
            if (state is TestFetchSuccess) {
              return ListView.builder(
                  itemCount: 5, itemBuilder: (context, index) {});
            } else {
              return const Center(child: Text("Show Test Screen"));
            }
          },
          listener: (context, state) {
            if(state is LogOutSuccess){
              context.goNamed(AppRoutes.login);
            }
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: PRIMARY_COLOR,
        onPressed: () {
          context.pushNamed(AppRoutes.selectCreateUnit);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
