import '../repositories/auth_repository.dart';

class RegisterUseCase {

  final AuthRepository repository;

  RegisterUseCase({
    required this.repository,
  });

  Future<void> call({

    required String email,

    required String password,

  }) async {

    await repository.register(

      email: email,

      password: password,
    );
  }
}