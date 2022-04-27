import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:top_flex/business_logic/cubit/movies_cubit/movies_cubit.dart';
import 'package:top_flex/business_logic/cubit/movies_cubit/movies_state.dart';
import 'package:top_flex/data/models/cast_model.dart';
import 'package:top_flex/data/models/movie_result_model.dart';
import 'package:top_flex/data/models/movies_model.dart';
import 'package:top_flex/data/models/search_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/models/trailer_model.dart';
import '../shared/components/components.dart';
import '../shared/constants/strings.dart';

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({Key? key, this.movie, this.movieSearch})
      : super(key: key);
  final MoviesResults? movie;
  final SearchResults? movieSearch;

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late bool isInMyList;
  late Box myBox = Hive.box("list");
  @override
  void initState() {
    super.initState();

    if (myBox.get(widget.movie!.id) == null) {
      isInMyList = widget.movie!.isInMyList!;
    } else {
      isInMyList = (Hive.box("list").get(widget.movie!.id) as MoviesResults).isInMyList!;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: ListView(
        children: [
          Stack(
            children: <Widget>[
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CachedNetworkImage(
                    imageUrl: widget.movie != null
                        ? (imageFirstPath + widget.movie!.backdropPath!)
                        : (imageFirstPath + widget.movieSearch!.backdropPath!),
                    width: double.infinity,
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height * 0.4,
                  ),
                  Container(
                    width: double.infinity,
                    height: 100,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black87,
                          Colors.black
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.movie != null
                                ? widget.movie!.originalTitle!
                                : widget.movieSearch!.originalTitle!,
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                height: 1),
                          ),
                          Row(
                            children: [
                              const Text("☆"),
                              Text(double.parse(widget.movie != null
                                      ? widget.movie!.voteAverage.toString()
                                      : widget.movieSearch!.voteAverage
                                          .toString())
                                  .toStringAsFixed(1)),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(DateFormat('MMMM dd, yyyy').format(
                                  DateTime.parse(widget.movie != null
                                      ? widget.movie!.releaseDate!
                                      : widget.movieSearch!.releaseDate!)))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                // --> App Bar
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  ),
                ),
              ),
              // ------ Other Widgets ------
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          myBigTextIconButton(
              icon: Icons.play_arrow, label: "PLAY", onPressed: () {}),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              widget.movie != null
                  ? widget.movie!.overview!
                  : widget.movieSearch!.overview!,
              style:
                  TextStyle(height: 1.2, color: Colors.white.withOpacity(0.9)),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BlocBuilder<MoviesCubit, MovieState>(
                builder: (ctx, state) {
                  var cubit = MoviesCubit.get(ctx);
                  return myTextButton(
                    label: "Trailer",
                    icon: Icons.ondemand_video,
                    onPressed: () {
                      TrailerResults trailer = cubit.movieLinks
                          .firstWhere((element) => element.type == "Trailer");
                      cubit.launchURL(trailer.key!);
                      //print(trailer.key);
                    },
                  );
                },
              ),
              myTextButton(
                  label: "My List",
                  icon: isInMyList ? Icons.check : Icons.add,
                  onPressed: () {
                    setState(() {
                      isInMyList = !isInMyList;
                      myBox.put(widget.movie!.id, widget.movie!.copyWith(isInMyList: isInMyList));

                    });
                  }),
              BlocBuilder<MoviesCubit, MovieState>(
                builder: (ctx, state) {
                  var cubit = MoviesCubit.get(ctx);
                  return myTextButton(
                      label: "Share",
                      icon: Icons.ios_share,
                      onPressed: () {
                        cubit.shareApp(widget.movie != null
                            ? widget.movie!.originalTitle!
                            : widget.movieSearch!.originalTitle!);
                      });
                },
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "CAST",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white.withOpacity(
                  0.9,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: BlocBuilder<MoviesCubit, MovieState>(
                builder: (ctx, state) {
                  var cubit = MoviesCubit.get(ctx);
                  if (cubit.castModel == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (c, index) {
                      return buildCastItem(cubit.castModel!, index);
                    },
                    itemCount: cubit.castModel!.cast!.length,
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "RELATED",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white.withOpacity(
                  0.9,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: BlocBuilder<MoviesCubit, MovieState>(
                builder: (ctx, state) {
                  var cubit = MoviesCubit.get(ctx);
                  if (cubit.castModel == null && cubit.relatedMovies.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (c, index) {
                      return buildRelatedMoviesItem(
                          cubit.relatedMovies, index, c);
                    },
                    itemCount: cubit.relatedMovies.length,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

}
