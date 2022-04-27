import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_flex/business_logic/cubit/movies_filter_cubit/movies_filter_cubit.dart';
import 'package:top_flex/business_logic/cubit/movies_filter_cubit/movies_filter_states.dart';
import 'package:top_flex/business_logic/cubit/tv_filter_cubit/tv_filter_cubit.dart';
import 'package:top_flex/business_logic/cubit/tv_filter_cubit/tv_filter_states.dart';
import 'package:top_flex/data/models/movie_result_model.dart';
import 'package:top_flex/data/models/movies_model.dart';
import 'package:top_flex/data/models/tv_shows_model.dart';
import 'package:top_flex/shared/components/components.dart';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class GenresFilterScreen extends StatefulWidget {
  const GenresFilterScreen({Key? key, required this.title, required this.id,required this.fromMovies})
      : super(key: key);
  final String title;
  final int id;
  final bool fromMovies;

  @override
  State<GenresFilterScreen> createState() => _GenresFilterScreenState();
}

class _GenresFilterScreenState extends State<GenresFilterScreen> {

  late MoviesFilterCubit moviesCubit;
  late TvFilterCubit tvCubit;

  @override
  void initState() {
    moviesCubit = MoviesFilterCubit.get(context);
    tvCubit = TvFilterCubit.get(context);
    if(widget.fromMovies){
      moviesCubit.pagingController.addPageRequestListener((pageKey) {
        moviesCubit.getFilteredMovies(widget.id, moviesCubit.p);
      });
    }
    else{
      tvCubit.pagingController.addPageRequestListener((pageKey) {
        tvCubit.getFilteredTvShows(widget.id, moviesCubit.p);
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        if(widget.fromMovies){
          moviesCubit.filteredMovies = [];
          moviesCubit.p = 1;
          moviesCubit.pagingController = PagingController(firstPageKey: 1);
        }
        else{
          tvCubit.filteredTvShows = [];
          tvCubit.p = 1;
          tvCubit.pagingController = PagingController(firstPageKey: 1);
        }

        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
        ),
        body: widget.fromMovies? BlocBuilder<MoviesFilterCubit,MoviesFilterStates>(
          builder: (ctx,state){
            return PagedGridView<int, MoviesResults>(
              pagingController: moviesCubit.pagingController,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,childAspectRatio: 2/3),
              builderDelegate:  PagedChildBuilderDelegate<MoviesResults>(itemBuilder: (context,item, index) => buildFilteredMoviesItem(item,index)),
            );
          },
        ): BlocBuilder<TvFilterCubit,TvFilterStates>(
          builder: (ctx,state){
            return PagedGridView<int, Results>(
              pagingController: tvCubit.pagingController,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,childAspectRatio: 2/3),
              builderDelegate:  PagedChildBuilderDelegate<Results>(itemBuilder: (context,item, index) => buildFilteredTvShowsItem(item,index)),
            );
          },
        ),
      ),
    );
  }
}
