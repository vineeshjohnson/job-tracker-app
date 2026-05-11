import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:job_tracker/app/theme/app_theme.dart';
import 'package:job_tracker/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'features/auth/data/datasources/auth_remote_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/usecases/login_usecase.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final firebaseAuth = FirebaseAuth.instance;

  final remoteDataSource = AuthRemoteDataSource(firebaseAuth: firebaseAuth);

  final repository = AuthRepositoryImpl(remoteDataSource: remoteDataSource);

  final loginUseCase = LoginUseCase(repository: repository);

  runApp(
    BlocProvider(
      create: (context) => AuthBloc(loginUseCase: loginUseCase),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      theme: AppTheme.lightTheme,
    );
  }
}
