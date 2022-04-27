import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:top_flex/business_logic/cubit/movies_filter_cubit/movies_filter_states.dart';
import 'package:top_flex/data/models/movie_result_model.dart';
import 'package:top_flex/data/models/movies_model.dart';
import 'package:top_flex/data/repository/movie_repository.dart';

class MoviesFilterCubit extends Cubit<MoviesFilterStates>{
  MoviesFilterCubit(this._repository) : super(MoviesFilterInitialState());
  final MovieRepository _repository;

  static MoviesFilterCubit get(BuildContext context) => BlocProvider.of(context);
  List<MoviesResults> filteredMovies = [];
  static const pageSize = 20;
  int p = 1;
   PagingController<int, MoviesResults> pagingController =
  PagingController(firstPageKey: 1);

  Future<void> getFilteredMovies(int genreId,int page) async{
    emit(GetFilteredMoviesLoadingState());
    _repository.getFilteredMoviesByGenres(genreId, page).then((value) {
      filteredMovies = value.results!;
      //filteredMovies.addAll(value.results!.map((e) => MoviesResults.fromJson(e.toJson())).toList());
      final isLastPage = page == (value.totalResults! > 500? 500:value.totalResults);
      if (isLastPage) {
        pagingController.appendLastPage(filteredMovies);
      } else {
        p = ++page;
        pagingController.appendPage(filteredMovies, p);
      }
      emit(GetFilteredMoviesSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(GetFilteredMoviesErrorState(error.toString()));
    });
  }
}