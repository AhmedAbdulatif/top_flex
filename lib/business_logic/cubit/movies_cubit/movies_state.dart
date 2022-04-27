import 'package:equatable/equatable.dart';
import 'package:top_flex/data/models/tv_shows_model.dart';

abstract class MovieState{}
class GetMoviesInitialState extends MovieState{}

class GetTvTrendingLoadingState extends MovieState{}
class GetTvTrendingSuccessState extends MovieState{}
class GetTvTrendingErrorState extends MovieState{
  final String error;

  GetTvTrendingErrorState(this.error);
}

class GetTvPopularLoadingState extends MovieState{}
class GetTvPopularSuccessState extends MovieState{}
class GetTvPopularErrorState extends MovieState{
  final String error;

  GetTvPopularErrorState(this.error);
}

class GetTvAirTodayLoadingState extends MovieState{}
class GetTvAirTodaySuccessState extends MovieState{}
class GetTvAirTodayErrorState extends MovieState{
  final String error;

  GetTvAirTodayErrorState(this.error);
}

class GetTopTvShowsLoadingState extends MovieState{}
class GetTopTvShowsSuccessState extends MovieState{}
class GetTopTvShowsErrorState extends MovieState{
  final String error;

  GetTopTvShowsErrorState(this.error);
}

class GetTopTvDetailsLoadingState extends MovieState{}
class GetTopTvDetailsSuccessState extends MovieState{}
class GetTopTvDetailsErrorState extends MovieState{
  final String error;

  GetTopTvDetailsErrorState(this.error);
}

class GetTvRelatedLoadingState extends MovieState{}
class GetTvRelatedSuccessState extends MovieState{}
class GetTvRelatedErrorState extends MovieState{
  final String error;

  GetTvRelatedErrorState(this.error);
}

class GetTvLinksLoadingState extends MovieState{}
class GetTvLinksSuccessState extends MovieState{}
class GetTvLinksErrorState extends MovieState{
  final String error;

  GetTvLinksErrorState(this.error);
}

class GetTvSeasonEpisodesLoadingState extends MovieState{}
class GetTvSeasonEpisodesSuccessState extends MovieState{}
class GetTvSeasonEpisodesErrorState extends MovieState{
  final String error;

  GetTvSeasonEpisodesErrorState(this.error);
}

class GetTrendingMoviesLoadingState extends MovieState{}
class GetTrendingMoviesSuccessState extends MovieState{}
class GetTrendingMoviesErrorState extends MovieState{
  final String error;

  GetTrendingMoviesErrorState(this.error);
}

class GetTopMoviesLoadingState extends MovieState{}
class GetTopMoviesSuccessState extends MovieState{}
class GetTopMoviesErrorState extends MovieState{
  final String error;

  GetTopMoviesErrorState(this.error);
}

class GetPopularMoviesLoadingState extends MovieState{}
class GetPopularMoviesSuccessState extends MovieState{}
class GetPopularMoviesErrorState extends MovieState{
  final String error;

  GetPopularMoviesErrorState(this.error);
}


class GetMovieCastLoadingState extends MovieState{}
class GetMovieCastSuccessState extends MovieState{}
class GetMovieCastErrorState extends MovieState{
  final String error;

  GetMovieCastErrorState(this.error);
}


class GetRelatedMoviesLoadingState extends MovieState{}
class GetRelatedMoviesSuccessState extends MovieState{}
class GetRelatedMoviesErrorState extends MovieState{
  final String error;

  GetRelatedMoviesErrorState(this.error);
}

class GetMovieLinksLoadingState extends MovieState{}
class GetMovieLinksSuccessState extends MovieState{}
class GetMovieLinksErrorState extends MovieState{
  final String error;

  GetMovieLinksErrorState(this.error);
}