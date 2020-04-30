
class Movie {
  final int id;
  final String title;
  final String backPoster;
  final String poster;
  final double rating;
  final double popularity;
  final String overview;

  Movie(this.id, this.title, this.backPoster, this.poster,
      this.rating, this.popularity, this.overview);

  Movie.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        backPoster = json["backdrop_path"],
        popularity = json["popularity"],
        poster = json["poster_path"],
        overview = json["overview"],
        rating = json["vote_average"].toDouble();
}
