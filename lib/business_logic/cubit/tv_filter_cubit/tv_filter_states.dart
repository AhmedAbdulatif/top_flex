abstract class TvFilterStates{}

class TvFilterInitialState extends TvFilterStates{}

class GetFilteredTvLoadingState extends TvFilterStates{}
class GetFilteredTvSuccessState extends TvFilterStates{}
class GetFilteredTvErrorState extends TvFilterStates{
  final String error;

  GetFilteredTvErrorState(this.error);
}