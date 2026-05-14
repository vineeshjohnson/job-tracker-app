import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:job_tracker/app/theme/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_tracker/features/auth/domain/usecases/register_usecase.dart';
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
import 'features/home/domain/usecases/delete_job_usecase.dart';
import 'features/home/domain/usecases/update_job_status_usecase.dart';
import 'app/theme/theme_cubit.dart';
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

  final jobRemoteDataSource = JobRemoteDataSource(firestore: firestore);

  final jobRepository = JobRepositoryImpl(
    remoteDataSource: jobRemoteDataSource,
  );

  final addJobUseCase = AddJobUseCase(repository: jobRepository);

  final getJobsUseCase = GetJobsUseCase(repository: jobRepository);
  final deleteJobUseCase = DeleteJobUseCase(repository: jobRepository);
  final updateJobStatusUseCase = UpdateJobStatusUseCase(
    repository: jobRepository,
  );
final registerUseCase = RegisterUseCase(
  repository: repository,
);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(
          create: (_) => AuthBloc(
            loginUseCase: loginUseCase,

            checkAuthStatusUseCase: checkAuthStatusUseCase,

            logoutUseCase: logoutUseCase,
            registerUseCase: registerUseCase,
          ),
        ),

        BlocProvider(
          create: (_) => JobBloc(
            addJobUseCase: addJobUseCase,
            getJobsUseCase: getJobsUseCase,
            deleteJobUseCase: deleteJobUseCase,
            updateJobStatusUseCase: updateJobStatusUseCase,
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
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        Widget page;

        if (state is Authenticated) {
          page = const HomePage();
        } else if (state is Unauthenticated) {
          page = const LoginPage();
        } else {
          page = const SplashPage();
        }

        return BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,

              theme: AppTheme.lightTheme,

              darkTheme: AppTheme.darkTheme,

              themeMode: themeMode,

              home: page,
            );
          },
        );
      },
    );
  }
}
