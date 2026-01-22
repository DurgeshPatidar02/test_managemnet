import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_managment/screens/auth/cubit/authCubit.dart';
import 'package:test_managment/screens/auth/cubit/authState.dart';

import '../../core/theme/theme.dart';
import '../../core/widgets/button.dart';
import '../../core/widgets/space.dart';
import '../../router/app_routes.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _mailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _agianPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscurePassword2 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ACCENT_COLOR,
        body: BlocConsumer<AuthCubit, AuthStates>(builder: (context, state) {
          return ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    children: [
                      Space.height(height: 20),
                      Text("SignUp",
                          style: appTheme.textTheme.bodyLarge
                              ?.copyWith(fontSize: 26)),
                      Container(
                        width: MediaQuery.of(context).size.width * .9,
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
                                  if (value != _agianPasswordController.text) {
                                    return "Password Not Matched";
                                  }
                                  return null;
                                },
                              ),
                              Space.height(height: 20),
                              TextFormField(
                                controller: _agianPasswordController,
                                obscureText: _obscurePassword2,
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
                                        _obscurePassword2 = !_obscurePassword2;
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
                                  if (value != _passwordController.text) {
                                    return "Password Not Matched";
                                  }
                                  return null;
                                },
                              ),
                              Space.height(height: 40),
                              EButton(
                                  text: "SignUp",
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  context: context,
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      String mail = _mailController.text
                                          .trim()
                                          .toLowerCase();
                                      String password =
                                          _passwordController.text.trim();
                                      context.read<AuthCubit>().signUp(
                                          mail: mail, password: password, context: context);
                                    }
                                  }),
                              Space.height(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("already SignUp"),
                                  TextButton(
                                      onPressed: () {
                                        context.goNamed(AppRoutes.login);
                                      },
                                      child: Text("LogIn"))
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
          if (state is AuthSuccess) {
            context.go(AppRoutes.showTest);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("SignUp Successfully"),
                backgroundColor: Colors.green,
              ),
            );
            context.goNamed(AppRoutes.showTest);
          }
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("SignUp Failed ${state.msg}"),
              backgroundColor: Colors.red,
            ));
          }
        }));
  }
}
