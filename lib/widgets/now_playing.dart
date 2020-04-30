import 'package:flutter/material.dart';
import 'package:movies_catalog/bloc/playing_movies_bloc.dart';
import 'package:movies_catalog/model/MovieResponse.dart';
import 'package:movies_catalog/widgets/movie_list.dart';

class NowPlaying extends StatefulWidget {
  @override
  _NowPlayingState createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nowPlayingMoviesBloc.getPlayingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.35,
      child: StreamBuilder<MovieResponse>(
        stream: nowPlayingMoviesBloc.subject.stream,
        builder: (ctx, snapshot) {
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }
          if (!snapshot.hasData) {
            return Container();
          }
          return MovieList(movies: snapshot.data.movies);
        },
      ),
    );
  }
}
