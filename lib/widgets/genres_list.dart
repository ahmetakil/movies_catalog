import 'package:flutter/material.dart';
import 'package:movies_catalog/bloc/genres_bloc.dart';
import 'package:movies_catalog/bloc/movies_by_genre_bloc.dart';
import 'package:movies_catalog/model/Genre.dart';
import 'package:movies_catalog/model/GenreResponse.dart';
import 'package:movies_catalog/style/styles.dart';

import 'genre_movies.dart';

class GenresList extends StatefulWidget {
  @override
  _GenresListState createState() => _GenresListState();
}

class _GenresListState extends State<GenresList> {
  @override
  void initState() {
    super.initState();
    genresBloc.getGenres();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GenreResponse>(
      stream: genresBloc.subject.stream,
      builder: (ctx, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error);
        }
        if (!snapshot.hasData) {
          return Container(
            width: 25,
            height: 25,
            child: CircularProgressIndicator(),
          );
        }
        List<Genre> genres = snapshot.data.genres;

        return Genres(genres: genres);
      },
    );
  }
}

class Genres extends StatefulWidget {

  final List<Genre> genres;

  const Genres({Key key, this.genres}) : super(key: key);

  @override
  _GenresState createState() => _GenresState();
}

class _GenresState extends State<Genres> with SingleTickerProviderStateMixin{

  List<Genre> genres;
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    genres = widget.genres;
    _tabController = TabController(vsync: this, length: genres.length);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        moviesByGenreBloc..drainStream();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 307.0,
        child: DefaultTabController(
          length: genres.length,
          child: Scaffold(
            backgroundColor: Styles.BACKGROUND_COLOR,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(50.0),
              child: AppBar(
                backgroundColor: Styles.BACKGROUND_COLOR,
                bottom: TabBar(
                  controller: _tabController,
                  indicatorColor: Colors.amber,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 3.0,
                  unselectedLabelColor: Colors.white,
                  labelColor: Colors.white,
                  isScrollable: true,
                  tabs: genres.map((Genre genre) {
                    return Container(
                        padding: EdgeInsets.only(bottom: 15.0, top: 10.0),
                        child: new Text(genre.name.toUpperCase(),
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            )));
                  }).toList(),
                ),
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
              children: genres.map((Genre genre) {
                return GenreMovies(
                  genreId: genre.id,
                );
              }).toList(),
            ),
          ),
        ));
  }
}
