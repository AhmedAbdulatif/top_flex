import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_flex/business_logic/cubit/app_cubit/app_states.dart';
import 'package:top_flex/business_logic/cubit/genres_cubit/genres_cubit.dart';
import 'package:top_flex/business_logic/cubit/movies_cubit/movies_cubit.dart';
import 'package:top_flex/data/repository/movie_repository.dart';
import 'package:top_flex/modules/home_screen.dart';
import 'package:top_flex/modules/movies_screen.dart';
import 'package:top_flex/modules/search_screen.dart';
import 'package:top_flex/modules/settings_screen.dart';
import 'package:top_flex/modules/tv_shows_screen.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialState());

  static AppCubit get(BuildContext context)=> BlocProvider.of(context);

  var index = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const MoviesScreen(),
    const TvShowsScreen(),
    SearchScreen(),
    const SettingsScreen(),
  ];

  void changeBottomNavigationState(int i,BuildContext context){
    index = i;
    var movieCubit = MoviesCubit.get(context);
    var genresCubit = GenresCubit.get(context);
    if(index == 1){
      if(movieCubit.popularMovies.isEmpty && movieCubit.upcomingMovies.isEmpty){
        movieCubit.getPopularMovies();
        movieCubit.getUpcomingMovies();
      }
    }
    if(index == 2){
      if(movieCubit.popularTvShows.isEmpty && movieCubit.tvAirToday.isEmpty){
        movieCubit.getPopularTvShows();
        movieCubit.getTvAirTodayShows();
      }
      if(genresCubit.tvGenres.isEmpty){
        genresCubit.getGenres(2);
      }
    }

    emit(BottomNavigationChangeState());
  }

}