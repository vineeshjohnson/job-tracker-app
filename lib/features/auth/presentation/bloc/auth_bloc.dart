import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/login_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final LoginUseCase loginUseCase;

  AuthBloc({
    required this.loginUseCase,
  }) : super(AuthInitial()) {

    on<LoginRequested>((event, emit) async {

      emit(AuthLoading());

      try {

        await loginUseCase(
          email: event.email,
          password: event.password,
        );

        emit(AuthSuccess());

      } on FirebaseAuthException catch (e) {

        emit(
          AuthFailure(
            e.message ?? "Login failed",
          ),
        );

      } catch (e) {

        emit(
          const AuthFailure(
            "Something went wrong",
          ),
        );
      }
    });
  }
}