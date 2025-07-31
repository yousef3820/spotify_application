import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spotify_application_1/core/configs/theme/app_theme.dart';
import 'package:flutter_spotify_application_1/domain/usecases/favourites_usecase.dart';
import 'package:flutter_spotify_application_1/presentation/features/choose_mode/bloc/theme_cubit.dart';
import 'package:flutter_spotify_application_1/presentation/features/favourites/bloc/favourites_cubit_cubit.dart';
import 'package:flutter_spotify_application_1/presentation/features/song_player/bloc/cubit/song_player_cubit.dart';
import 'package:flutter_spotify_application_1/presentation/features/splash/pages/splash.dart';
import 'package:flutter_spotify_application_1/serviceLocator.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await initializeDependancies();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );

  runApp(BlocProvider(create: (_) => SongPlayerCubit(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(
          create: (context) => FavoritesCubit(
            sl<GetFavoritesUseCase>(),
            sl<AddFavoriteUseCase>(),
            sl<RemoveFavoriteUseCase>(),
            sl<GetSongByUrlUseCase>(),
          )
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, mode) {
          return MaterialApp(
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: mode,
            debugShowCheckedModeBanner: false,
            home: const SplashPage(),
          );
        },
      ),
    );
  }
}
