import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_managment/core/theme/theme.dart';
import 'package:test_managment/core/widgets/testCard.dart';
import 'package:test_managment/router/app_routes.dart';
import 'package:test_managment/screens/auth/cubit/authCubit.dart';
import 'package:test_managment/screens/auth/cubit/authState.dart';
import 'package:test_managment/screens/auth/login.dart';

import 'core/widgets/space.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          PopupMenuButton<String>(
            onSelected: (v) {
              if (v == "Logout") {
                context.read<AuthCubit>().logOut();
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: "Logout",
                  child: Text("Logout"),
                )
              ];
            },
          )
        ],
      ),
      body: BlocConsumer< AuthCubit, AuthStates>(builder: (context, state) {
        if(state is AuthLoading){
          return Center(child: CircularProgressIndicator(),);
        }

          return Padding(
              padding: EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          context.pushNamed(AppRoutes.selectCreateUnit);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.width * 0.3,
                          decoration: BoxDecoration(
                              color: ACCENT_COLOR,
                              borderRadius: BorderRadiusGeometry.circular(10.0),
                              border: Border.all()),
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                const CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  child: Icon(
                                    Icons.my_library_books,
                                    size: 80,
                                  ),
                                ),
                                Space.width(width: 20),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * .5,
                                  child: const Text(
                                    "Test Management",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Space.height(height: 20),
                  ],
                ),
              ));

      }, listener: (context, state) {
        if (state is LogOutSuccess) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Login()));
        }

      }),
    );
  }
}
