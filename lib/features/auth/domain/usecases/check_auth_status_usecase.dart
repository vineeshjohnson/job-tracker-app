import '../repositories/auth_repository.dart';

class CheckAuthStatusUseCase {

  final AuthRepository repository;

  CheckAuthStatusUseCase({
    required this.repository,
  });

  bool call() {

    return repository.isLoggedIn();
  }
}