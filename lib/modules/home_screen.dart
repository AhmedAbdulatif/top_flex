import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:top_flex/business_logic/cubit/movies_cubit/movies_cubit.dart';
import 'package:top_flex/business_logic/cubit/movies_cubit/movies_state.dart';
import 'package:top_flex/data/models/movie_result_model.dart';
import 'package:top_flex/data/models/movies_model.dart';
import 'package:top_flex/data/repository/movie_repository.dart';
import 'package:top_flex/modules/movie_details_screen.dart';
import 'package:top_flex/modules/my_video_player.dart';
import 'package:top_flex/shared/components/components.dart';
import 'package:top_flex/shared/constants/strings.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = -1;
  late List<MoviesResults> trendingMovies;
  late MoviesResults movie;
  late bool isInMyList;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        BlocBuilder<MoviesCubit, MovieState>(
          builder: (ctx, state) {
            var cubit = MoviesCubit.get(ctx);
            if (cubit.trendingMovies.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (index == -1) {
                trendingMovies = cubit.trendingMovies;
                index = Random().nextInt(trendingMovies.length);
                movie = Hive.box("list").get(trendingMovies[index].id) ??trendingMovies[index];
                isInMyList = movie.isInMyList!;
              }
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Image.network(
                    imageFirstPath + trendingMovies[index].posterPath!,
                    height: MediaQuery.of(context).size.height * 0.6,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                  Container(
                    width: double.infinity,
                    height: 70,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black54,
                          Colors.black
                        ],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        myTextButton(
                          icon: isInMyList? Icons.check:Icons.add,
                          label: 'My List',
                          onPressed: () {
                            setState(() {
                              var myListBox = Hive.box("list");
                              isInMyList = !isInMyList;
                              myListBox.put(trendingMovies[index].id, movie.copyWith(isInMyList: isInMyList));
                              print((myListBox.get(trendingMovies[index].id) as MoviesResults).isInMyList);
                            });
                          },
                        ),
                        myTextIconButton(
                            label: "PLAY",
                            icon: Icons.play_arrow,
                            onPressed: () {
                            }),
                        myTextButton(
                          icon: Icons.info_outline,
                          label: 'Info',
                          onPressed: () {
                            cubit.getMovieCast(trendingMovies[index].id);
                            cubit.getRelatedMovie(trendingMovies[index].id);
                            cubit.getMovieLinks(trendingMovies[index].id);
                            navigateTo(
                                context,
                                MovieDetailsScreen(
                                  movie: trendingMovies[index],
                                ));
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "TV Shows Trending Today",
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
                    return buildTvShowItemTest(
                        cubit.trendingTvShows, index, context);
                  });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Movies Trending Today",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        SizedBox(
          height: 170,
          child: BlocBuilder<MoviesCubit, MovieState>(
            builder: (c, state) {
              var cubit = MoviesCubit.get(c);
              if (state is GetTrendingMoviesLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                  itemCount: cubit.trendingMovies.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return buildMoviesItemTest(cubit.trendingMovies, index, c);
                  });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Popular Networks",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        SizedBox(
          height: 140,
          child: ListView.builder(
              itemCount: 8,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return buildPopularNetworksTest(
                  images: [
                    "assets/images/netflix.png",
                    "assets/images/appletv.png",
                    "assets/images/primevideo.png",
                    "assets/images/hulu.png",
                    "assets/images/disney.png",
                    "assets/images/hbo.png",
                    "assets/images/amc.png",
                    "assets/images/paramount.jpg",
                  ],
                  labels: [
                    "Netflix",
                    "Apple TV+",
                    "Amazon",
                    "Hulu",
                    "Disney+",
                    "HBO",
                    "AMC",
                    "Paramount+",
                  ],
                  index: index,
                );
              }),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Popular Companies",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        SizedBox(
          height: 140,
          child: ListView.builder(
              itemCount: 7,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return buildPopularNetworksTest(
                  images: [
                    "assets/images/marvel.png",
                    "assets/images/pixar.png",
                    "assets/images/warner.png",
                    "assets/images/waltd.png",
                    "assets/images/lucasfilm.png",
                    "assets/images/dc.png",
                    "assets/images/paramount.png",
                  ],
                  labels: [
                    "Marvel Studios",
                    "Pixar",
                    "Warner Bros Pictures",
                    "Walt Disney Pictures",
                    "Lucasfilm Ltd",
                    "DC Entertainment",
                    "Paramount+",
                  ],
                  index: index,
                );
              }),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Top Movies Last Week",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        SizedBox(
          height: 170,
          child: BlocBuilder<MoviesCubit, MovieState>(
            builder: (c, state) {
              var cubit = MoviesCubit.get(c);
              if (state is GetTopMoviesLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                  itemCount: cubit.topMovies.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return buildMoviesItemTest(cubit.topMovies, index, c);
                  });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Top TV Shows Last Week",
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
                    return buildTvShowItemTest(
                        cubit.topTvShows, index, context);
                  });
            },
          ),
        ),
      ],
    );
  }
}
