import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_flex/business_logic/cubit/search_cubit/search_states.dart';
import 'package:top_flex/data/models/search_model.dart';
import 'package:top_flex/data/repository/movie_repository.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit(this.repository) : super(SearchInitialState());
  final MovieRepository repository;

  static SearchCubit get(BuildContext context)=> BlocProvider.of(context);

  List<SearchResults> searchResults = [];

  Future<void> searchQuery(String keyword) async{
    emit(GetSearchResultsLoadingState());
    repository.getSearchResults(keyword).then((results) {
      emit(GetSearchResultsSuccessState());
      searchResults = results;
    }).catchError((error){
      print(error);
      emit(GetSearchResultsErrorState(error));
    });
  }

}