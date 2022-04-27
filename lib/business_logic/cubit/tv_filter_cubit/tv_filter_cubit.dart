import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:top_flex/business_logic/cubit/movies_filter_cubit/movies_filter_states.dart';
import 'package:top_flex/data/models/movies_model.dart';
import 'package:top_flex/data/models/tv_shows_model.dart';
import 'package:top_flex/data/repository/movie_repository.dart';

import 'tv_filter_states.dart';

class TvFilterCubit extends Cubit<TvFilterStates>{
  TvFilterCubit(this._repository) : super(TvFilterInitialState());
  final MovieRepository _repository;

  static TvFilterCubit get(BuildContext context) => BlocProvider.of(context);
  List<Results> filteredTvShows = [];
  static const pageSize = 20;
  int p = 1;
   PagingController<int, Results> pagingController =
  PagingController(firstPageKey: 1);

  Future<void> getFilteredTvShows(int genreId,int page) async{
    emit(GetFilteredTvLoadingState());
    _repository.getFilteredTvShowsByGenres(genreId, page).then((value) {
      filteredTvShows = value.results!;
      //filteredMovies.addAll(value.results!.map((e) => MoviesResults.fromJson(e.toJson())).toList());
      final isLastPage = page == (value.totalResults! > 500? 500:value.totalResults);
      if (isLastPage) {
        pagingController.appendLastPage(filteredTvShows);
      } else {
        p = ++page;
        pagingController.appendPage(filteredTvShows, p);
      }
      emit(GetFilteredTvSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(GetFilteredTvErrorState(error.toString()));
    });
  }
}