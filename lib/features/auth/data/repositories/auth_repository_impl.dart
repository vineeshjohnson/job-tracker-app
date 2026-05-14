import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> login({required String email, required String password}) async {
    await remoteDataSource.login(email: email, password: password);
  }

  @override
  bool isLoggedIn() {
    return remoteDataSource.isLoggedIn();
  }

  @override
  Future<void> logout() async {
    await remoteDataSource.logout();
  }

  @override
  Future<void> register({
    required String email,

    required String password,
  }) async {
    await remoteDataSource.register(email: email, password: password);
  }
}
