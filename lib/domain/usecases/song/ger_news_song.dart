import 'package:dartz/dartz.dart';
import 'package:flutter_spotify_application_1/core/configs/usecase/usecase.dart';
import 'package:flutter_spotify_application_1/domain/repos/song/song_repo.dart';
import 'package:flutter_spotify_application_1/serviceLocator.dart';
class GetNewestSongsUsecase implements Usecase <Either,dynamic> {
  @override
  Future<Either> execute({params}) {
    return sl<SongRepo>().GetNewsSongs();
  }
}
