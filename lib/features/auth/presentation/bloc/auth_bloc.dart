import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_tracker/features/auth/domain/usecases/check_auth_status_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final LoginUseCase loginUseCase;

  final CheckAuthStatusUseCase checkAuthStatusUseCase;
final LogoutUseCase logoutUseCase;
AuthBloc({
  required this.loginUseCase,
  required this.checkAuthStatusUseCase,
  required this.logoutUseCase,
}) : super(AuthInitial()) {

on<LogoutRequested>((event, emit) async {

  await logoutUseCase();

  emit(Unauthenticated());
});


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

    on<CheckAuthStatus>((event, emit) {

      final isLoggedIn = checkAuthStatusUseCase();

      if (isLoggedIn) {

        emit(Authenticated());

      } else {

        emit(Unauthenticated());
      }
    });
  }
}