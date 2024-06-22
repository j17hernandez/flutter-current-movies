import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:CurrentMovies/src/data/repositories/user_repository.domain.dart';
import 'package:CurrentMovies/src/data/repositories_impl/user_repository_impl.data.dart';
import 'package:CurrentMovies/src/data/sources/daos/user_dao.data.dart';
import 'package:CurrentMovies/src/data/sources/db_config.dart';
import 'package:CurrentMovies/src/pages/bloc/login_page_bloc.dart';
import 'package:CurrentMovies/src/pages/splash_custom_page.dart';
import 'package:CurrentMovies/src/routes/routes.dart';
import 'package:CurrentMovies/src/utils/app_colors.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    DbConfig.initDatabase();
  });

  runApp(MultiProvider(providers: [
    Provider<UserRepository>(
      create: (_) => UserRepositoryImpl(UserDAO()),
    ),
    ChangeNotifierProvider(
      create: (BuildContext context) =>
          LoginPageBloc(userRepository: context.read()),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Current Movies',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.colorScheme),
        appBarTheme:
            const AppBarTheme(backgroundColor: AppColors.$colorBackgroundApp),
      ),
      initialRoute: SplashCustomPage.route,
      routes: getAplicationRoutes(),
    );
  }
}
