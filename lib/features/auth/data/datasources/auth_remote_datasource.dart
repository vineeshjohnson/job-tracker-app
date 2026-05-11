import 'package:firebase_auth/firebase_auth.dart';

class AuthRemoteDataSource {

  final FirebaseAuth firebaseAuth;

  AuthRemoteDataSource({
    required this.firebaseAuth,
  });

  Future<void> login({
    required String email,
    required String password,
  }) async {

    await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}