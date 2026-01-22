import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test_managment/core/theme/theme.dart';
import 'package:test_managment/router/app_routes.dart';
import 'package:test_managment/screens/auth/cubit/authState.dart';

import '../../core/widgets/button.dart';
import '../../core/widgets/space.dart';
import 'cubit/authCubit.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _mailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ACCENT_COLOR,
        body: BlocConsumer<AuthCubit, AuthStates>(builder: (context, state) {
          if(state is AuthLoading){
            return Center(child: CircularProgressIndicator(),);
          }
          return ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    children: [
                      Space.height(height: 20),
                      Text("Login",
                          style: appTheme.textTheme.bodyLarge
                              ?.copyWith(fontSize: 26)),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * .9,
                        height: 1,
                        color: Colors.black,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Space.height(height: 50),
                              TextFormField(
                                controller: _mailController,
                                maxLines: 1,
                                decoration: InputDecoration(
                                  labelText: "Enter Mail ID",
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Email required';
                                  }
                                  final regex = RegExp(
                                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                  if (!regex.hasMatch(value)) {
                                    return 'Enter valid email';
                                  }
                                },
                              ),
                              Space.height(height: 20),
                              TextFormField(
                                controller: _passwordController,
                                obscureText: _obscurePassword,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscurePassword
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscurePassword = !_obscurePassword;
                                      });
                                    },
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Password required';
                                  }
                                  if (value.length < 8) {
                                    return 'Minimum 8 characters';
                                  }
                                  return null;
                                },
                              ),
                              Space.height(height: 40),
                              EButton(
                                  text: "Login",
                                  width:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.8,
                                  context: context,
                                  onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        String mail = _mailController.text
                                            .trim()
                                            .toLowerCase();
                                        String password =
                                        _passwordController.text.trim();
                                        context.read<AuthCubit>().logIn(
                                            mail: mail, password: password);
                                      }
                                      //execute further proceess

                                  }),
                              Space.height(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("If you don`t have account"),
                                  TextButton(
                                      onPressed: () {
                                        context.goNamed(AppRoutes.signup);
                                      },
                                      child: Text("SignUP"))
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        }, listener: (context, state) {
          if (state is LogInSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Login Successful"),
              backgroundColor: Colors.green,
            ));
            context.goNamed(AppRoutes.showTest);

          }
          if (state is LogInError){
          ScaffoldMessenger.of (context)
          .showSnackBar(SnackBar(
          content: Text("Login Failed"),
          backgroundColor: Colors.red,
          ));
        }
        }));
  }
}
