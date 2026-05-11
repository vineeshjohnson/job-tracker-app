import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase({required this.repository});

  Future<void> call({required String email, required String password}) async {
    await repository.login(email: email, password: password);
  }
}
