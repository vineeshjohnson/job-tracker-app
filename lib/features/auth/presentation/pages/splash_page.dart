import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_tracker/features/home/presentation/pages/home_page.dart';

import 'login_page.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();

    context.read<AuthBloc>().add(
      CheckAuthStatus(),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: BlocListener<AuthBloc, AuthState>(

        listener: (context, state) {

          if (state is Authenticated) {

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const HomePage(),
              ),
            );
          }

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
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}