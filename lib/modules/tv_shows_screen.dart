import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_flex/business_logic/cubit/movies_cubit/movies_cubit.dart';
import 'package:top_flex/business_logic/cubit/movies_cubit/movies_state.dart';
import 'package:top_flex/shared/components/components.dart';

import 'genres_screen.dart';

class TvShowsScreen extends StatelessWidget {
  const TvShowsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TV Shows"),
        actions: [
          TextButton(onPressed: (){
            navigateTo(context, const GenresScreen(index: 2,));
          }, child: const Text("Genres")),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "TV On The Air",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          SizedBox(
            height: 170,
            child: BlocBuilder<MoviesCubit, MovieState>(
              builder: (c, state) {
                var cubit = MoviesCubit.get(c);
                if (state is GetTvTrendingLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                    itemCount: cubit.trendingTvShows.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return buildTvShowItemTest(cubit.trendingTvShows, index,context);
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
            child: BlocBuilder<MoviesCubit, MovieState>(
              builder: (c, state) {
                var cubit = MoviesCubit.get(c);
                if (state is GetTvPopularLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                    itemCount: cubit.popularTvShows.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return buildTvShowItemTest(cubit.popularTvShows, index,context);
                    });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "TV Airing Today",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          SizedBox(
            height: 170,
            child: BlocBuilder<MoviesCubit, MovieState>(
              builder: (c, state) {
                var cubit = MoviesCubit.get(c);
                if (state is GetTvAirTodayLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                    itemCount: cubit.tvAirToday.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return buildTvShowItemTest(cubit.tvAirToday, index,context);
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
            child: BlocBuilder<MoviesCubit, MovieState>(
              builder: (c, state) {
                var cubit = MoviesCubit.get(c);
                if (state is GetTopTvShowsLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                    itemCount: cubit.topTvShows.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return buildTvShowItemTest(cubit.topTvShows, index,context);
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}
