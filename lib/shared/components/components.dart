import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:top_flex/business_logic/cubit/movies_cubit/movies_cubit.dart';
import 'package:top_flex/business_logic/cubit/movies_filter_cubit/movies_filter_cubit.dart';
import 'package:top_flex/business_logic/cubit/tv_filter_cubit/tv_filter_cubit.dart';
import 'package:top_flex/data/models/genres_model.dart';
import 'package:top_flex/data/models/movie_result_model.dart';
import 'package:top_flex/data/models/movies_model.dart';
import 'package:top_flex/data/models/search_model.dart';
import 'package:top_flex/data/models/tv_shows_model.dart';
import 'package:top_flex/modules/genres_filter_screen.dart';
import 'package:top_flex/modules/movie_details_screen.dart';
import 'package:top_flex/modules/tv_details_screen.dart';
import 'package:top_flex/shared/constants/my_colors.dart';
import 'package:top_flex/shared/constants/strings.dart';

import '../../data/models/cast_model.dart';
import '../../data/models/tv_seasons_model.dart';

Widget myButton({required String label, required VoidCallback onPressed}) =>
    InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: MyColors.primary,
          borderRadius: BorderRadius.circular(
            5,
          ),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 30,
        ),
        child: Text(label),
      ),
    );

Widget myTextIconButton(
        {required String label,
        required IconData icon,
        required VoidCallback onPressed}) =>
    InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: MyColors.primary,
          borderRadius: BorderRadius.circular(
            5,
          ),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 20,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(label),
          ],
        ),
      ),
    );

Widget myBigTextIconButton(
        {required String label,
        required IconData icon,
        required VoidCallback onPressed}) =>
    InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: MyColors.primary,
            borderRadius: BorderRadius.circular(
              20,
            ),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 20,
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(label),
              ],
            ),
          ),
        ),
      ),
    );

Widget myTextButton(
        {required IconData icon,
        required String label,
        required VoidCallback onPressed}) =>
    InkWell(
      onTap: onPressed,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white.withOpacity(0.9),
            ),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndKillTo(context, widget) => Navigator.pushReplacement(
    context, MaterialPageRoute(builder: (context) => widget));

/*
Widget buildTvShowItem(TvModel model,int index) => Container(
  margin: const EdgeInsets.all(5),
  width: 110,
  height: 100,
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10,),
  ),
  child: ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(model.results[index].posterPath)),
);*/

Widget buildTvShowItemTest(
        List<Results> model, int index, BuildContext context) =>
    InkWell(
      onTap: () {
        var cubit = MoviesCubit.get(context);
        cubit.tvDetailsModel = null;
        cubit.getTvDetails(model[index].id);
        cubit.getRelatedTvShows(model[index].id);
        cubit.getTvLinks(model[index].id);
        cubit.getTvSeasonEpisodes(model[index].id, 1);
        navigateTo(
            context,
            TvDetailsScreen(
              tvId: model[index].id,
            ));
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        width: 110,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: imageFirstPath + model[index].posterPath!,
              fit: BoxFit.fill,
            )),
      ),
    );

Widget buildMoviesItemTest(
        List<MoviesResults> model, int index, BuildContext context) =>
    InkWell(
      onTap: () {
        var cubit = MoviesCubit.get(context);
        cubit.getMovieCast(model[index].id);
        cubit.getRelatedMovie(model[index].id);
        cubit.getMovieLinks(model[index].id);
        navigateTo(context, MovieDetailsScreen(movie: model[index]));
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        width: 110,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: imageFirstPath + model[index].posterPath!,
              fit: BoxFit.fill,
            )),
      ),
    );

Widget buildRelatedMoviesItem(
        List<MoviesResults> model, int index, BuildContext context) =>
    InkWell(
      onTap: () {
        var cubit = MoviesCubit.get(context);
        cubit.getMovieLinks(model[index].id);
        cubit.getMovieCast(model[index].id).then(
            (value) => cubit.getRelatedMovie(model[index].id).then((value) {
                  navigateTo(context, MovieDetailsScreen(movie: model[index]));
                }));
        // cubit.getRelatedMovie(model[index].id);
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10, right: 10),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              width: 110,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  10,
                ),
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: imageFirstPath + model[index].posterPath!,
                    fit: BoxFit.fill,
                  )),
            ),
            Container(
              width: 30,
              height: 20,
              margin: const EdgeInsets.only(top: 5, right: 5),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  double.parse(model[index].voteAverage.toString())
                      .toStringAsFixed(1),
                  style: const TextStyle(
                    fontSize: 11,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget buildFilteredMoviesItem(MoviesResults model, int index) => Container(
      margin: const EdgeInsets.all(5),
      width: 130,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: imageFirstPath + model.posterPath!,
            fit: BoxFit.fill,
          )),
    );

Widget buildFilteredTvShowsItem(Results model, int index) => Container(
      margin: const EdgeInsets.all(5),
      width: 130,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: imageFirstPath + model.posterPath!,
            fit: BoxFit.fill,
          )),
    );

Widget buildRelatedTvShowsItem(
        List<Results> model, int index, BuildContext context) =>
    InkWell(
      onTap: () {
        var cubit = MoviesCubit.get(context);
        cubit.getTvDetails(model[index].id);
        cubit.getRelatedTvShows(model[index].id);
        cubit.getTvLinks(model[index].id);
        cubit.getTvSeasonEpisodes(model[index].id, 1);
        navigateTo(context, TvDetailsScreen(tvId: model[index].id));

        // cubit.getRelatedMovie(model[index].id);
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10, right: 10),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              width: 110,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(
                  10,
                ),
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: imageFirstPath + model[index].posterPath!,
                    fit: BoxFit.fill,
                  )),
            ),
            Container(
              width: 30,
              height: 20,
              margin: const EdgeInsets.only(top: 5, right: 5),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  double.parse(model[index].voteAverage.toString())
                      .toStringAsFixed(1),
                  style: const TextStyle(
                    fontSize: 11,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget buildSearchedItem(
        SearchResults model, int index, BuildContext context) =>
    InkWell(
      onTap: () {
        if (model.mediaType == "movie") {
          var cubit = MoviesCubit.get(context);
          cubit
              .getMovieCast(model.id)
              .then((value) => cubit.getRelatedMovie(model.id).then((value) {
                    cubit.getMovieLinks(model.id);
                    navigateTo(
                        context,
                        MovieDetailsScreen(
                          movieSearch: model,
                        ));
                  }));
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(5),
            width: 110,
            height: 145,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: model.posterPath != null
                    ? CachedNetworkImage(
                        imageUrl: imageFirstPath + model.posterPath!,
                        fit: BoxFit.fill,
                      )
                    : Image.asset(
                        "assets/images/no.png",
                      )),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            model.originalTitle ?? model.name ?? "No Title",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );

Widget buildPopularNetworksTest(
        {required List<String> images,
        required List<String> labels,
        required int index}) =>
    Column(
      children: [
        Container(
          margin: const EdgeInsets.all(5),
          width: 140,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                images[index],
                fit: BoxFit.contain,
              )),
        ),
        Text(
          labels[index],
          style: const TextStyle(
              color: Colors.white70, fontWeight: FontWeight.bold),
        ),
      ],
    );

Widget buildGenresItem(
        List<Genres> model, BuildContext context, int index, int i) =>
    InkWell(
      onTap: () {
        print(i);
        if (i == 1) {
          var cubit = MoviesFilterCubit.get(context);
          cubit.getFilteredMovies(model[index].id!, 1);
          navigateTo(
              context,
              GenresFilterScreen(
                title: model[index].name!,
                id: model[index].id!,
                fromMovies: true,
              ));
        }
        if (i == 2) {
          var cubit = TvFilterCubit.get(context);
          cubit.getFilteredTvShows(model[index].id!, 1);
          navigateTo(
              context,
              GenresFilterScreen(
                title: model[index].name!,
                id: model[index].id!,
                fromMovies: false,
              ));
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Text(model[index].name!),
      ),
    );

Widget buildCastItem(CastModel model, int index) => Padding(
      padding: const EdgeInsets.only(right: 8),
      child: CircleAvatar(
        radius: 40,
        foregroundImage: NetworkImage(model.cast![index].profilePath != null
            ? imageFirstPath + model.cast![index].profilePath!
            : "https://st.depositphotos.com/1779253/5140/v/950/depositphotos_51405259-stock-illustration-male-avatar-profile-picture-use.jpg"),
      ),
    );

Widget buildTvSeasonEpisode(
    TvSeasonsModel tvSeasonsModel, int index, BuildContext context) =>
    Container(
      color: Colors.black,
      height: 120,
      child: Row(
        children: [
          Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CachedNetworkImage(
                    imageUrl: tvSeasonsModel.episodes![index].stillPath != null
                        ? imageFirstPath +
                        tvSeasonsModel.episodes![index].stillPath!
                        : "https://st4.depositphotos.com/14953852/24787/v/600/depositphotos_247872612-stock-illustration-no-image-available-icon-vector.jpg",
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  const Icon(
                    Icons.play_arrow,
                    size: 50,
                    color: Colors.white,
                  ),
                ],
              )),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 3,
                ),
                Text(
                  tvSeasonsModel.episodes![index].name! +
                      "-S${tvSeasonsModel.seasonNumber},E${tvSeasonsModel.episodes![index].episodeNumber}",
                  maxLines: 2,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                      height: 1),
                ),
                Text(
                  DateFormat('MMMM dd, yyyy').format(
                      DateTime.parse(tvSeasonsModel.episodes![index].airDate!)),
                  style: const TextStyle(
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  tvSeasonsModel.episodes![index].overview!,
                  maxLines: 2,
                  style: const TextStyle(
                      color: Colors.white70,
                      overflow: TextOverflow.ellipsis,
                      height: 1),
                )
              ],
            ),
          ),
        ],
      ),
    );
