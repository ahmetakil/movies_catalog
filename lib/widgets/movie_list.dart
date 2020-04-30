import 'package:flutter/material.dart';
import 'package:movies_catalog/model/Movie.dart';
import 'package:movies_catalog/widgets/movie_widget.dart';
import 'package:page_indicator/page_indicator.dart';

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList({Key key, this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (movies.length == 0) {
      return Container(
        child: Text("No Movies :("),
      );
    }
    return PageIndicatorContainer(
      shape: IndicatorShape.circle(size: 6),
      align: IndicatorAlign.bottom,
      indicatorColor: Colors.white,
      indicatorSelectorColor: Colors.amber,
      length: movies.take(8).length,
      indicatorSpace: 6,
      child: PageView(
        scrollDirection: Axis.horizontal,
        children: movies.take(8).map((m) => MovieWidget(movie: m)).toList(),
      ),
    );
  }
}
