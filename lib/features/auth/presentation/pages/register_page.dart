import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is Authenticated) {
                Navigator.pop(context);
              }

              if (state is AuthFailure) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },

            builder: (context, state) {
              return Form(
                key: formKey,

                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,

                      decoration: const InputDecoration(labelText: "Email"),

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter email";
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    TextFormField(
                      controller: passwordController,

                      obscureText: true,

                      decoration: const InputDecoration(labelText: "Password"),

                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return "Minimum 6 characters";
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    TextFormField(
                      controller: confirmPasswordController,

                      obscureText: true,

                      decoration: const InputDecoration(
                        labelText: "Confirm Password",
                      ),

                      validator: (value) {
                        if (value != passwordController.text) {
                          return "Passwords do not match";
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 30),

                    if (state is AuthLoading)
                      const CircularProgressIndicator()
                    else
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                              RegisterRequested(
                                email: emailController.text.trim(),

                                password: passwordController.text.trim(),
                              ),
                            );
                          }
                        },

                        child: const Text("Create Account"),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
