import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:job_tracker/app/theme/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_tracker/features/auth/presentation/bloc/auth_state.dart';
import 'package:job_tracker/features/auth/presentation/pages/login_page.dart';
import 'package:job_tracker/features/auth/presentation/pages/splash_page.dart';
import 'package:job_tracker/features/home/presentation/pages/home_page.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'features/auth/data/datasources/auth_remote_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/usecases/login_usecase.dart';
import 'features/auth/domain/usecases/check_auth_status_usecase.dart';
import 'features/auth/domain/usecases/logout_usecase.dart';
import 'features/home/data/datasources/job_remote_datasource.dart';
import 'features/home/data/repositories/job_repository_impl.dart';
import 'features/home/domain/usecases/add_job_usecase.dart';
import 'features/home/presentation/bloc/job_bloc.dart';
import 'features/home/domain/usecases/get_jobs_usecase.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final firebaseAuth = FirebaseAuth.instance;

  final remoteDataSource = AuthRemoteDataSource(firebaseAuth: firebaseAuth);

  final repository = AuthRepositoryImpl(remoteDataSource: remoteDataSource);

  final loginUseCase = LoginUseCase(repository: repository);
  final checkAuthStatusUseCase = CheckAuthStatusUseCase(repository: repository);
  final logoutUseCase = LogoutUseCase(repository: repository);
  final firestore = FirebaseFirestore.instance;

final jobRemoteDataSource = JobRemoteDataSource(
  firestore: firestore,
);

final jobRepository = JobRepositoryImpl(
  remoteDataSource: jobRemoteDataSource,
);

final addJobUseCase = AddJobUseCase(
  repository: jobRepository,
);

final getJobsUseCase = GetJobsUseCase(
  repository: jobRepository,
);
  runApp(

  MultiBlocProvider(

    providers: [

      BlocProvider(

        create: (_) => AuthBloc(

          loginUseCase: loginUseCase,

          checkAuthStatusUseCase: checkAuthStatusUseCase,

          logoutUseCase: logoutUseCase,
        ),
      ),

      BlocProvider(

        create: (_) => JobBloc(
          addJobUseCase: addJobUseCase,
            getJobsUseCase: getJobsUseCase,
        ),
      ),
    ],

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
      home: BlocBuilder<AuthBloc, AuthState>(

  builder: (context, state) {

    if (state is Authenticated) {
      return const HomePage();
    }

    if (state is Unauthenticated) {
      return const LoginPage();
    }

    return const SplashPage();
  },
),
      theme: AppTheme.lightTheme,
    );
  }
}
