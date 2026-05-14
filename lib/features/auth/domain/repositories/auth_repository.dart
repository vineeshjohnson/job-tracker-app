abstract class AuthRepository {

  Future<void> login({
    required String email,
    required String password,
  });

  bool isLoggedIn();

  Future<void> logout();
  Future<void> register({

  required String email,

  required String password,
});
}