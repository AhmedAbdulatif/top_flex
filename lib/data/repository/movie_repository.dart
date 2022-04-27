
import 'package:top_flex/data/models/genres_model.dart';
import 'package:top_flex/data/models/movie_result_model.dart';
import 'package:top_flex/data/models/movies_model.dart';
import 'package:top_flex/data/models/search_model.dart';
import 'package:top_flex/data/models/trailer_model.dart';
import 'package:top_flex/data/models/tv_details_model.dart';
import 'package:top_flex/data/models/tv_seasons_model.dart';
import 'package:top_flex/data/models/tv_shows_model.dart';
import 'package:top_flex/shared/constants/strings.dart';
import 'package:top_flex/data/api/dio_helper.dart';

import '../models/cast_model.dart';

class MovieRepository {

   Future<List<Results>> getTrendingTvShows() async {
     try{
        final movies = await DioHelper.getData(trendingTvShows, query: {"api_key": apiKey});
        return movies.map((e) => Results.fromJson(e)).toList();
     }

     catch(e){
       return [];
     }
  }

   Future<List<Results>> getPopularTvShows() async {
     try{
       final movies = await DioHelper.getData(popularTvShows, query: {"api_key": apiKey});
       return movies.map((e) => Results.fromJson(e)).toList();
     }

     catch(e){
       return [];
     }
   }

   Future<List<Results>> getTvAirTodayShows() async {
     try{
       final movies = await DioHelper.getData(tvAirToday, query: {"api_key": apiKey});
       return movies.map((e) => Results.fromJson(e)).toList();
     }

     catch(e){
       return [];
     }
   }

   Future<List<Results>> getTopTvShows() async {
     try{
       final movies = await DioHelper.getData(topTvShowsLastWeek, query: {"api_key": apiKey});
       return movies.map((e) => Results.fromJson(e)).toList();
     }

     catch(e){
       print(e);
       return [];
     }
   }


   Future<List<MoviesResults>> getTrendingMovies() async {
     try{
       final movies = await DioHelper.getData(trendingMovies, query: {"api_key": apiKey});
       return movies.map((e) => MoviesResults.fromJson(e)).toList();
     }

     catch(e){
       return [];
     }
   }

   Future<List<MoviesResults>> getTopMovies() async {
     try{
       final movies = await DioHelper.getData(topMoviesLastWeek, query: {"api_key": apiKey});
       return movies.map((e) => MoviesResults.fromJson(e)).toList();
     }

     catch(e){
       return [];
     }
   }

   Future<List<MoviesResults>> getPopularMovies() async {
     try{
       final movies = await DioHelper.getData(popularMovies, query: {"api_key": apiKey});
       return movies.map((e) => MoviesResults.fromJson(e)).toList();
     }

     catch(e){
       return [];
     }
   }

   Future<List<MoviesResults>> getUpcomingMovies() async {
     try{
       final movies = await DioHelper.getData(upcomingMovies, query: {"api_key": apiKey});
       return movies.map((e) => MoviesResults.fromJson(e)).toList();
     }

     catch(e){
       return [];
     }
   }

   Future<List<MoviesResults>> getLatestMovies() async {
     try{
       final movies = await DioHelper.getData(latestMovies, query: {"api_key": apiKey});
       return movies.map((e) => MoviesResults.fromJson(e)).toList();
     }

     catch(e){;
       return [];
     }
   }
   
   Future<List<Genres>> getGenres(int index) async{
     final genres = await DioHelper.getGenresData(index == 1? movieGenres:tvGenres, query: {
       "api_key": apiKey,
       "language": "en",
     });
     return genres.map((genre) => Genres.fromJson(genre)).toList();
   }


   Future<MoviesModel> getFilteredMoviesByGenres(int genreId,int page) async{
     final MoviesModel model = await DioHelper.getPaginationData(movieGenresFilter, query: {
       "api_key": apiKey,
       "sort_by": "popularity.desc",
       "language": "en-US",
       "page": "$page",
       "with_genres": "$genreId",
     });
     return model;
   }

   Future<TvShowsModel> getFilteredTvShowsByGenres(int genreId,int page) async{
     final TvShowsModel model = await DioHelper.getTvPaginationData(tvGenresFilter, query: {
       "api_key": apiKey,
       "sort_by": "popularity.desc",
       "language": "en-US",
       "page": "$page",
       "with_genres": "$genreId",
     });
     return model;
   }

   Future<List<SearchResults>> getSearchResults(String keyword) async{
     final results = await DioHelper.getData(search, query: {
       "api_key": apiKey,
       "query": keyword,
     });
     return results.map((result) => SearchResults.fromJson(result)).toList();
   }

   Future<CastModel> getMovieCast(dynamic movieId) async{
     try{
       final model = await DioHelper.getMovieCastData("movie/$movieId/credits",query: {
         "api_key": apiKey,
       });
       return model;
     }
     catch(e){
       print(e.toString()+"fuckRepo");
       return CastModel.fromError();
     }

   }

   Future<List<MoviesResults>> getRelatedMovies(int movieId) async{
     final results = await DioHelper.getData("movie/$movieId/recommendations", query: {
       "api_key": apiKey,
     });
     return results.map((result) => MoviesResults.fromJson(result)).toList();
   }

   Future<List<TrailerResults>> getTrailerLink(int movieId) async{
     final results = await DioHelper.getData("movie/$movieId/videos", query: {
       "api_key": apiKey,
     });
     return results.map((result) => TrailerResults.fromJson(result)).toList();
   }

   Future<TvDetailsModel> getTvShowDetails(int tvId) async{
     try{
       final model = await DioHelper.getTvDetailsData("/tv/$tvId",query: {
         "api_key": apiKey,
       });
       return model;
     }
     catch(e){
       print(e.toString()+"fuckRepo");
       return TvDetailsModel.fromError();
     }

   }

   Future<List<Results>> getRelatedTvShows(int tvId) async{
     final results = await DioHelper.getData("tv/$tvId/recommendations", query: {
       "api_key": apiKey,
     });
     return results.map((result) => Results.fromJson(result)).toList();
   }

   Future<List<TrailerResults>> getTvTrailerLink(int tvId) async{
     final results = await DioHelper.getData("tv/$tvId/videos", query: {
       "api_key": apiKey,
     });
     return results.map((result) => TrailerResults.fromJson(result)).toList();
   }

   Future<TvSeasonsModel> getTvSeasonEpisodes(int tvId,int season) async{
     try{
       final model = await DioHelper.getTvEpisodesData("/tv/$tvId/season/$season",query: {
         "api_key": apiKey,
       });
       return model;
     }
     catch(e){
       print(e.toString()+"fuckRepo");
       return TvSeasonsModel.fromError();
     }

   }


}
