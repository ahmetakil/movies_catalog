import 'package:movies_catalog/model/MovieResponse.dart';
import 'package:movies_catalog/repository/MovieRepository.dart';
import 'package:rxdart/rxdart.dart';

class MoviesListBloc {
  final _movieRepository = MovieRepository();
  final BehaviorSubject<MovieResponse> _subject = BehaviorSubject();

  getMovies() async {
    MovieResponse response = await _movieRepository.getMovies();
    _subject.sink.add(response);
  }

  dispose(){
    _subject.close();
  }

  BehaviorSubject<MovieResponse> get subject => _subject;

}

final moviesBloc = MoviesListBloc();
