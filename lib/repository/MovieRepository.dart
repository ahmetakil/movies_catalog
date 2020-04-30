import 'package:dio/dio.dart';
import 'package:movies_catalog/bloc/genres_bloc.dart';
import 'package:movies_catalog/model/GenreResponse.dart';
import 'package:movies_catalog/model/MovieResponse.dart';

class MovieRepository {
  static const api_key = "8a1227b5735a7322c4a43a461953d4ff";
  static const url = "https://api.themoviedb.org/3";
  final Dio _dio = Dio();

  final popularUrl = "$url/movie/top_rated";
  final playingUrl = "$url/movie/now_playing";
  final moviesUrl = "$url/discover/movie";
  final genresUrl = "$url/genre/movie/list";

  Future<MovieResponse> getMovies() async {
    try {
      Response response = await _dio.get(popularUrl, queryParameters: {
        'api_key': api_key,
        'language': "en-US",
        'page': 1,
      });
      return MovieResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("getMovies threw an exception: $error and stack: $stackTrace");
      return MovieResponse.withError(error);
    }
  }

  Future<MovieResponse> getPlayingMovies() async {
    try {
      Response response = await _dio.get(playingUrl, queryParameters: {
        'api_key': api_key,
        'language': 'en-US',
        'page': 1
      });
      return MovieResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print(
          "getPlayingMovies threw an exception: $error and stack: $stackTrace");
      return MovieResponse.withError(error);
    }
  }

  Future<GenreResponse> getGenres() async {
    try {
      Response response = await _dio.get(genresUrl,
          queryParameters: {"api_key": api_key, "language": "en-US"});
      return GenreResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return GenreResponse.withError(error);
    }
  }

  Future<MovieResponse> getMovieByGenre(int id) async {
    var params = {"api_key": api_key, "language": "en-US", "page": 1, "with_genres": id};
    try {
      Response response = await _dio.get(moviesUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MovieResponse.withError("$error");
    }
  }
}
