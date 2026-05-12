import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../../../auth/presentation/pages/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Home"),

        actions: [

          IconButton(

            onPressed: () {

              context.read<AuthBloc>().add(
                LogoutRequested(),
              );
            },

            icon: const Icon(Icons.logout),
          ),
        ],
      ),

      body: BlocListener<AuthBloc, AuthState>(

        listener: (context, state) {

          if (state is Unauthenticated) {

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const LoginPage(),
              ),
            );
          }
        },

        child: const Center(
          child: Text("Home Page"),
        ),
      ),
    );
  }
}