import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_flex/data/models/movie_result_model.dart';
import 'package:top_flex/data/models/tv_details_model.dart';
import 'package:top_flex/data/models/tv_seasons_model.dart';
import 'package:top_flex/data/models/tv_shows_model.dart';
import 'package:top_flex/data/repository/movie_repository.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import '../../../data/models/cast_model.dart';
import '../../../data/models/trailer_model.dart';
import 'movies_state.dart';


class MoviesCubit extends Cubit<MovieState> {
  final MovieRepository repository;


  MoviesCubit(this.repository) : super(GetMoviesInitialState());

  static MoviesCubit get(BuildContext context) => BlocProvider.of(context);

  List<Results> trendingTvShows = [];
  List<Results> popularTvShows = [];
  List<Results> tvAirToday = [];
  List<Results> topTvShows = [];
  List<Results> relatedTvShows = [];

  List<MoviesResults> trendingMovies = [];
  List<MoviesResults> topMovies = [];
  List<MoviesResults> popularMovies = [];
  List<MoviesResults> upcomingMovies = [];
  List<MoviesResults> relatedMovies = [];

  List<TrailerResults> movieLinks = [];
  List<TrailerResults> tvLinks = [];

  TvDetailsModel? tvDetailsModel;
  TvSeasonsModel? tvSeasonsModel;
  CastModel? castModel;

  Future<void> getTrendingTvShows() async {
    emit(GetTvTrendingLoadingState());
    repository.getTrendingTvShows().then((value) {
      trendingTvShows = value;
      emit(GetTvTrendingSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetTvTrendingErrorState(error));
    });
  }

  Future<void> getPopularTvShows() async {
    emit(GetTvPopularLoadingState());
    repository.getPopularTvShows().then((value) {
      popularTvShows = value;
      emit(GetTvPopularSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetTvPopularErrorState(error));
    });
  }

  Future<void> getTvAirTodayShows() async {
    emit(GetTvAirTodayLoadingState());
    repository.getTvAirTodayShows().then((value) {
      tvAirToday = value;
      emit(GetTvAirTodaySuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetTvAirTodayErrorState(error));
    });
  }

  Future<void> getTopTvShows() async {
    emit(GetTopTvShowsLoadingState());
    repository.getTopTvShows().then((value) {
      topTvShows = value;
      print(topTvShows.length);
      emit(GetTopTvShowsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetTopTvShowsErrorState(error));
    });
  }

  Future<void> getTrendingMovies() async {
    emit(GetTrendingMoviesLoadingState());
    repository.getTrendingMovies().then((value) {
      trendingMovies = value;
      emit(GetTrendingMoviesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetTrendingMoviesErrorState(error));
    });
  }

  Future<void> getTopMovies() async {
    emit(GetTopMoviesLoadingState());
    repository.getTopMovies().then((value) {
      topMovies = value;
      emit(GetTopMoviesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetTopMoviesErrorState(error));
    });
  }

  Future<void> getPopularMovies() async {
    emit(GetPopularMoviesLoadingState());
    repository.getPopularMovies().then((value) {
      popularMovies = value;
      emit(GetPopularMoviesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetPopularMoviesErrorState(error));
    });
  }

  Future<void> getUpcomingMovies() async {
    emit(GetPopularMoviesLoadingState());
    repository.getUpcomingMovies().then((value) {
      upcomingMovies = value;
      emit(GetPopularMoviesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetPopularMoviesErrorState(error));
    });
  }

  Future<void> getMovieCast(dynamic movieId) async {
    emit(GetMovieCastLoadingState());
    repository.getMovieCast(movieId).then((value) {
      emit(GetMovieCastSuccessState());
      castModel = value;
    }).catchError((error) {
      print(error);
      emit(GetMovieCastErrorState(error));
    });
  }

  Future<void> getRelatedMovie(int movieId) async {
    emit(GetRelatedMoviesLoadingState());
    repository.getRelatedMovies(movieId).then((value) {
      emit(GetRelatedMoviesSuccessState());
      relatedMovies = value;
    }).catchError((error) {
      print(error);
      emit(GetRelatedMoviesErrorState(error));
    });
  }

  Future<void> getMovieLinks(dynamic movieId) async {
    emit(GetMovieLinksLoadingState());
    repository.getTrailerLink(movieId).then((value) {
      emit(GetMovieLinksSuccessState());
      movieLinks = value;
    }).catchError((error) {
      print(error);
      emit(GetMovieLinksErrorState(error));
    });
  }

  Future<void> getTvDetails(int tvId) async {
    emit(GetTopTvDetailsLoadingState());
    repository.getTvShowDetails(tvId).then((value) {
      emit(GetTopTvDetailsSuccessState());
      tvDetailsModel = value;
    }).catchError((error) {
      print("fuck get tv details cubit");
      emit(GetTopTvDetailsErrorState(error));
    });
  }

  Future<void> getRelatedTvShows(int movieId) async {
    emit(GetTvLinksLoadingState());
    repository.getRelatedTvShows(movieId).then((value) {
      emit(GetTvLinksSuccessState());
      relatedTvShows = value;
    }).catchError((error) {
      print(error);
      emit(GetTvLinksErrorState(error));
    });
  }

  Future<void> getTvLinks(int tvId) async {
    emit(GetTvRelatedLoadingState());
    repository.getTvTrailerLink(tvId).then((value) {
      emit(GetTvRelatedSuccessState());
      tvLinks = value;
    }).catchError((error) {
      print(error);
      emit(GetTvRelatedErrorState(error));
    });
  }

  Future<void> getTvSeasonEpisodes(int tvId,int season) async {
    emit(GetTvSeasonEpisodesLoadingState());
    repository.getTvSeasonEpisodes(tvId,season).then((value) {
      emit(GetTvSeasonEpisodesSuccessState());
      tvSeasonsModel = value;
      print("cubit "+ tvSeasonsModel!.episodes![0].id.toString());
    }).catchError((error) {
      print("fuck get tv season episodes cubit");
      emit(GetTvSeasonEpisodesErrorState(error));
    });
  }

  launchURL(String key) async {
    if (Platform.isIOS) {
      if (await canLaunch(
          'https://www.youtube.com/watch?v=$key')) {
        await launch(
            'https://www.youtube.com/watch?v=$key',
            forceSafariVC: false);
      } else {
        if (await canLaunch(
            'https://www.youtube.com/watch?v=$key')) {
          await launch(
              'https://www.youtube.com/watch?v=$key');
        } else {
          throw 'Could not launch https://www.youtube.com/watch?v=$key';
        }
      }
    } else {
      final url = 'https://www.youtube.com/watch?v=$key';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }
  shareApp(String showTitle){
    Share.share('Watch "$showTitle" free now on TOP FLEX https://top-flex.com');
  }
}