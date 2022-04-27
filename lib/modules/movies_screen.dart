import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_flex/business_logic/cubit/movies_cubit/movies_cubit.dart';
import 'package:top_flex/business_logic/cubit/movies_cubit/movies_state.dart';
import 'package:top_flex/modules/genres_screen.dart';
import 'package:top_flex/shared/components/components.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movies"),
        actions: [
          TextButton(onPressed: (){
            navigateTo(context, const GenresScreen(index: 1));
          }, child: const Text("Genres"),),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Now Playing",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          SizedBox(
            height: 170,
            child: BlocBuilder<MoviesCubit,MovieState>(
              builder: (c,state){
                var cubit = MoviesCubit.get(c);
                return ListView.builder(
                    itemCount: cubit.trendingMovies.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return buildMoviesItemTest(cubit.trendingMovies, index,c);
                    });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Popular",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          SizedBox(
            height: 170,
            child: BlocBuilder<MoviesCubit,MovieState>(
              builder: (c,state){
                if(state is GetPopularMoviesLoadingState){
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var cubit = MoviesCubit.get(c);
                return ListView.builder(
                    itemCount: cubit.popularMovies.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return buildMoviesItemTest(cubit.popularMovies, index,c);
                    });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Upcoming",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          SizedBox(
            height: 170,
            child: BlocBuilder<MoviesCubit,MovieState>(
              builder: (c,state){
                var cubit = MoviesCubit.get(c);
                return ListView.builder(
                    itemCount: cubit.upcomingMovies.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return buildMoviesItemTest(cubit.upcomingMovies, index,c);
                    });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Top Rated",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          SizedBox(
            height: 170,
            child: BlocBuilder<MoviesCubit,MovieState>(
              builder: (c,state){
                var cubit = MoviesCubit.get(c);
                return ListView.builder(
                    itemCount: cubit.topMovies.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return buildMoviesItemTest(cubit.topMovies, index,c);
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}
