import 'package:movies_catalog/model/MovieResponse.dart';
import 'package:movies_catalog/repository/MovieRepository.dart';
import 'package:rxdart/rxdart.dart';

class PlayingMoviesBloc {

  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<MovieResponse> _subject =  BehaviorSubject();

  getPlayingMovies() async{

    final response = await _repository.getPlayingMovies();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<MovieResponse> get subject => _subject;

}

final nowPlayingMoviesBloc = PlayingMoviesBloc();