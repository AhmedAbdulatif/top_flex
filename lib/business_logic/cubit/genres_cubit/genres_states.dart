abstract class GenresStates{}
class GenresInitialState extends GenresStates{}

class GetGenresLoadingState extends GenresStates{}
class GetGenresSuccessState extends GenresStates{}
class GetGenresErrorState extends GenresStates{
  final String error;

  GetGenresErrorState(this.error);
}