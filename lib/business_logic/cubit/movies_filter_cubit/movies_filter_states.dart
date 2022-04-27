abstract class MoviesFilterStates{}

class MoviesFilterInitialState extends MoviesFilterStates{}

class GetFilteredMoviesLoadingState extends MoviesFilterStates{}
class GetFilteredMoviesSuccessState extends MoviesFilterStates{}
class GetFilteredMoviesErrorState extends MoviesFilterStates{
  final String error;

  GetFilteredMoviesErrorState(this.error);
}