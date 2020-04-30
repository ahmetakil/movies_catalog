import 'package:movies_catalog/model/Movie.dart';

class MovieResponse {
  final List<Movie> movies;
  final String error;

  MovieResponse(this.movies, this.error);

  MovieResponse.fromJson(Map<String, dynamic> json)
      : movies = (json["results"] as List)
      .map((res) => Movie.fromJson(res))
      .toList(),
        error = "";


  MovieResponse.withError(String error)
      : movies = [],
        error = error;

}
