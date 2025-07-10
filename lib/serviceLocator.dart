
import 'package:appwrite/appwrite.dart';
import 'package:flutter_spotify_application_1/data/datasource/auth/auth_firebase_service.dart';
import 'package:flutter_spotify_application_1/data/datasource/song/song_appwrite_service.dart';
import 'package:flutter_spotify_application_1/data/repos/auth/auth_repo_impl.dart';
import 'package:flutter_spotify_application_1/data/repos/song/song_repo_impl.dart';
import 'package:flutter_spotify_application_1/domain/repos/auth/auth_repo.dart';
import 'package:flutter_spotify_application_1/domain/repos/song/song_repo.dart';
import 'package:flutter_spotify_application_1/domain/usecases/favourites_usecase.dart';
import 'package:flutter_spotify_application_1/domain/usecases/getuser_usecase.dart';
import 'package:flutter_spotify_application_1/domain/usecases/sigin_usecase.dart';
import 'package:flutter_spotify_application_1/domain/usecases/signup_usecae.dart';
import 'package:flutter_spotify_application_1/domain/usecases/song/ger_news_song.dart';
import 'package:flutter_spotify_application_1/domain/usecases/song/get_play_list_song.dart';
import 'package:flutter_spotify_application_1/domain/usecases/song/search_songs_usecase.dart';
import 'package:flutter_spotify_application_1/presentation/features/favourites/bloc/favourites_cubit_cubit.dart';
import 'package:flutter_spotify_application_1/presentation/features/search/bloc/cubit/search_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependancies() async {
  // Existing registrations
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());
  sl.registerSingleton<AuthRepository>(AuthRepoImpl());
  sl.registerLazySingleton(() => SongAppwriteService(
    client: Client()
      ..setEndpoint('https://fra.cloud.appwrite.io/v1')
      ..setProject('6830d46f00113962f1fd'),
    databaseId: '6856e4f100066df3deb4',
    collectionId: '6856e4fa0038fac880c9',
  ));
  sl.registerLazySingleton<SongRepo>(() => SongRepoImpl(songAppwriteService: sl()));
  sl.registerSingleton<SignupUsecae>(SignupUsecae());
  sl.registerSingleton<SiginUsecase>(SiginUsecase());
  sl.registerSingleton<GetNewestSongsUsecase>(GetNewestSongsUsecase());
  sl.registerSingleton<GetPlayListSongUsecase>(GetPlayListSongUsecase());
  sl.registerSingleton<GetUserUseCase>(GetUserUseCase());

  // Add these new registrations for favorites functionality
  sl.registerSingleton<GetFavoritesUseCase>(GetFavoritesUseCase(sl<AuthRepository>()));
  sl.registerSingleton<AddFavoriteUseCase>(AddFavoriteUseCase(sl<AuthRepository>()));
  sl.registerSingleton<RemoveFavoriteUseCase>(RemoveFavoriteUseCase(sl<AuthRepository>()));
  sl.registerSingleton<GetSongByUrlUseCase>(GetSongByUrlUseCase(sl()));

  // Register the FavoritesCubit
  sl.registerFactory(() => FavoritesCubit(
    sl<GetFavoritesUseCase>(),
    sl<AddFavoriteUseCase>(),
    sl<RemoveFavoriteUseCase>(),
    sl<GetSongByUrlUseCase>(),
  ));
  sl.registerSingleton<SearchSongsUsecase>(SearchSongsUsecase(sl()));
  sl.registerFactory(() => SearchCubit(sl()));
}