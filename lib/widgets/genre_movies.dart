import 'package:universal_html/js.dart' as js;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movies_catalog/bloc/movies_by_genre_bloc.dart';
import 'package:movies_catalog/model/Movie.dart';
import 'package:movies_catalog/model/MovieResponse.dart';
import 'package:rating_bar/rating_bar.dart';

class GenreMovies extends StatefulWidget {
  final int genreId;

  GenreMovies({Key key, @required this.genreId}) : super(key: key);

  @override
  _GenreMoviesState createState() => _GenreMoviesState(genreId);
}

class _GenreMoviesState extends State<GenreMovies> {
  final int genreId;

  _GenreMoviesState(this.genreId);

  @override
  void initState() {
    super.initState();

    moviesByGenreBloc..getMoviesByGenre(genreId);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieResponse>(
      stream: moviesByGenreBloc.subject.stream,
      builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error);
        }
        if (!snapshot.hasData) {
          return Container();
        }
        return MovieListForGenre(movies: snapshot.data.movies);
      },
    );
  }
}

class MovieListForGenre extends StatelessWidget {
  final List<Movie> movies;

  const MovieListForGenre({Key key, this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270.0,
      padding: EdgeInsets.only(left: 10.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 15.0),
            child: InkWell(
              onTap: () {
                if (kIsWeb) {
                  js.context.callMethod("open", [
                    "http://www.google.com/search?q=${movies[index].title.split(" ").join("+")}"
                  ]);
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      width: 120.0,
                      height: 180.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(2.0)),
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "https://image.tmdb.org/t/p/w200/" +
                                    movies[index].poster)),
                      )),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: 100,
                    child: Text(
                      movies[index].title,
                      maxLines: 2,
                      style: TextStyle(
                          height: 1.4,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 11.0),
                    ),
                  ),
                  RatingBar.readOnly(
                    emptyIcon: Icons.star_border,
                    filledColor: Colors.amber[800],
                    size: 16,
                    filledIcon: Icons.star,
                    initialRating: (movies[index].rating ?? 0) / 2,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
