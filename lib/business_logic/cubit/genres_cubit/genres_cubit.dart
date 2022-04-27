import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_flex/business_logic/cubit/genres_cubit/genres_states.dart';
import 'package:top_flex/data/models/genres_model.dart';
import 'package:top_flex/data/repository/movie_repository.dart';

class GenresCubit extends Cubit<GenresStates>{
  GenresCubit(this.repository) : super(GenresInitialState());
  final MovieRepository repository;

  static GenresCubit get(BuildContext context) => BlocProvider.of(context);

  List<Genres> movieGenres = [];
  List<Genres> tvGenres = [];

  Future<void> getGenres(int index) async{
    emit(GetGenresLoadingState());
    repository.getGenres(index).then((value){
      if(index == 1){
        movieGenres = value;
      }
      else{
        tvGenres = value;
      }
      emit(GetGenresSuccessState());
    }).catchError((error){
      print(error);
      emit(GetGenresErrorState(error));
    });
  }

}