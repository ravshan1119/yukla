import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yukla/cubits/article/article_cubit.dart';
import 'package:yukla/cubits/auth/auth_cubit.dart';
import 'package:yukla/cubits/profile/profile_cubit.dart';
import 'package:yukla/cubits/send_message/send_message_cubit.dart';
import 'package:yukla/cubits/tab/tab_cubit.dart';
import 'package:yukla/cubits/user_data/user_data_cubit.dart';
import 'package:yukla/cubits/website/website_cubit.dart';
import 'package:yukla/data/local/storage_repository.dart';
import 'package:yukla/data/network/api_service.dart';
import 'package:yukla/data/repositories/articles_repository.dart';
import 'package:yukla/data/repositories/auth_repository.dart';
import 'package:yukla/data/repositories/clound_message_repository.dart';
import 'package:yukla/data/repositories/profile_repository.dart';
import 'package:yukla/data/repositories/website_repository.dart';
import 'package:yukla/presentation/app_routes.dart';
import 'package:yukla/utils/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await StorageRepository.getInstance();
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  runApp(App(apiService: ApiService()));
}

class App extends StatelessWidget {
  const App({super.key, required this.apiService});

  final ApiService apiService;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(apiService: apiService),
        ),
        RepositoryProvider(
          create: (context) => ProfileRepository(apiService: apiService),
        ),
        RepositoryProvider(
          create: (context) => WebsiteRepository(apiService: apiService),
        ),
        RepositoryProvider(
          create: (context) => ArticleRepository(apiService: apiService),
        ),
        RepositoryProvider(
          create: (context) => CloudMessageRepository(apiService: apiService),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(create: (context) => TabCubit()),
          BlocProvider(create: (context) => UserDataCubit()),
          BlocProvider(
              create: (context) => ProfileCubit(
                  profileRepository: context.read<ProfileRepository>())),
          BlocProvider(
              create: (context) => WebsiteCubit(
                  websiteRepository: context.read<WebsiteRepository>())),
          BlocProvider(
              create: (context) => ArticleCubit(
                  articleRepository: context.read<ArticleRepository>())),
          BlocProvider(create: (context) => SendMessageCubit()),
        ],
        child: const MyApp(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.darkTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.dark,
          onGenerateRoute: AppRoutes.generateRoute,
          initialRoute: RouteNames.splashScreen,
        );
      },
    );
  }
}
