import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_tracker/features/auth/domain/usecases/check_auth_status_usecase.dart';
import 'package:job_tracker/features/auth/domain/usecases/register_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;

  final CheckAuthStatusUseCase checkAuthStatusUseCase;
  final LogoutUseCase logoutUseCase;
  final RegisterUseCase registerUseCase;
  AuthBloc({
    required this.loginUseCase,
    required this.checkAuthStatusUseCase,
    required this.logoutUseCase,
    required this.registerUseCase,
  }) : super(AuthInitial()) {
    on<LogoutRequested>((event, emit) async {
      print("logout event");

      await logoutUseCase();

      print("signed out");

      emit(Unauthenticated());

      print("unauth emitted");
    });

    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());

      try {
        await loginUseCase(email: event.email, password: event.password);

        emit(AuthSuccess());
      } on FirebaseAuthException catch (e) {
        emit(AuthFailure(e.message ?? "Login failed"));
      } catch (e) {
        emit(const AuthFailure("Something went wrong"));
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

    on<RegisterRequested>((event, emit) async {
      emit(AuthLoading());

      try {
        await registerUseCase(email: event.email, password: event.password);

        emit(Authenticated());
      } on FirebaseAuthException catch (e) {
        emit(AuthFailure(e.message ?? "Registration failed"));
      } catch (e) {
        emit(const AuthFailure("Something went wrong"));
      }
    });
  }
}
