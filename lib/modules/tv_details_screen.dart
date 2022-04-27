import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:top_flex/business_logic/cubit/movies_cubit/movies_cubit.dart';
import 'package:top_flex/business_logic/cubit/movies_cubit/movies_state.dart';
import 'package:top_flex/data/models/tv_seasons_model.dart';
import 'package:top_flex/shared/constants/my_colors.dart';

import '../data/models/trailer_model.dart';
import '../shared/components/components.dart';
import '../shared/constants/strings.dart';

class TvDetailsScreen extends StatefulWidget {
  const TvDetailsScreen({Key? key,required this.tvId}) : super(key: key);
  final int tvId;

  @override
  State<TvDetailsScreen> createState() => _TvDetailsScreenState();
}

class _TvDetailsScreenState extends State<TvDetailsScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  var seasonId = 1;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var cubit = MoviesCubit.get(context);
        cubit.tvDetailsModel = null;
        return true;
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          body: BlocBuilder<MoviesCubit, MovieState>(
            builder: (ctx, state) {
              var cubit = MoviesCubit.get(ctx);
              if (cubit.tvDetailsModel == null ||
                  cubit.tvSeasonsModel == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                print(cubit.tvDetailsModel!.id);
                print(cubit.tvDetailsModel!.originalName);
                print(cubit.tvDetailsModel!.originalName);
              }
              return ListView(
                children: [
                  Stack(
                    children: <Widget>[
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          CachedNetworkImage(
                            imageUrl: imageFirstPath +
                                (cubit.tvDetailsModel!.backdropPath == null
                                    ? cubit.tvDetailsModel!.posterPath!
                                    : cubit.tvDetailsModel!.posterPath!),
                            width: double.infinity,
                            fit: BoxFit.fill,
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
                                    cubit.tvDetailsModel!.originalName!,
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.9),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        height: 1),
                                  ),
                                  Row(
                                    children: [
                                      Text(cubit.tvDetailsModel!.numberOfSeasons
                                              .toString() +
                                          " Seasons"),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(cubit
                                              .tvDetailsModel!.numberOfEpisodes
                                              .toString() +
                                          " Episodes"),
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
                                cubit.tvDetailsModel = null;
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.arrow_back,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
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
                      cubit.tvDetailsModel!.overview!,
                      style: TextStyle(
                          height: 1.2, color: Colors.white.withOpacity(0.9)),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      myTextButton(
                        label: "Trailer",
                        icon: Icons.ondemand_video,
                        onPressed: () {
                          TrailerResults trailer = cubit.tvLinks.firstWhere(
                              (element) => element.type == "Trailer");
                          cubit.launchURL(trailer.key!);
                          //print(trailer.key);
                        },
                      ),
                      myTextButton(
                          label: "My List", icon: Icons.add, onPressed: () {}),
                      myTextButton(
                          label: "Share",
                          icon: Icons.ios_share,
                          onPressed: () {
                            cubit.shareApp(cubit.tvDetailsModel!.originalName!);
                          }),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: SizedBox(
                        height: 50,
                        child: AppBar(
                          backgroundColor: Colors.transparent,
                          bottom: TabBar(
                            controller: _tabController,
                            indicatorColor: MyColors.primary,
                            tabs: [
                              Tab(
                                  child: Text(
                                "EPISODES",
                                style: TextStyle(
                                    color: _tabController.index == 0
                                        ? MyColors.primary
                                        : Colors.white),
                              )),
                              Tab(
                                  child: Text(
                                "YOU MAY ALSO LIKE",
                                style: TextStyle(
                                    color: _tabController.index == 0
                                        ? Colors.white
                                        : MyColors.primary),
                              ))
                            ],
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 500,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        Container(
                          color: Colors.black,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              TextButton.icon(
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    backgroundColor: Colors.transparent,
                                    builder: (ctx) {
                                      return Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25.0),
                                            topRight: Radius.circular(25.0),
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ListView.separated(
                                                padding: EdgeInsets.zero,
                                                shrinkWrap: true,
                                                physics: const ClampingScrollPhysics(),
                                                separatorBuilder: (ctx, state) {
                                                  return Container(
                                                    color: Colors.black,
                                                    height: 1,
                                                    width: double.infinity,
                                                  );
                                                },
                                                itemCount: cubit.tvDetailsModel!
                                                    .numberOfSeasons!,
                                                itemBuilder: (ctx, index) {
                                                  return InkWell(
                                                    onTap: (){
                                                      setState(() {
                                                        seasonId = index++;
                                                      });
                                                      cubit.getTvSeasonEpisodes(widget.tvId, seasonId);
                                                      Navigator.pop(ctx);
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: index == 0
                                                            ? const BorderRadius
                                                                .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        25.0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        25.0),
                                                              )
                                                            : index ==
                                                                    cubit.tvDetailsModel!
                                                                            .numberOfSeasons -
                                                                        1
                                                                ? const BorderRadius
                                                                        .only(
                                                                    bottomLeft: Radius
                                                                        .circular(
                                                                            25),
                                                                    bottomRight: Radius
                                                                        .circular(
                                                                            25))
                                                                : BorderRadius
                                                                    .zero,
                                                      ),
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 50,
                                                          vertical: 5),
                                                      child: Center(
                                                        child: Text(
                                                          "Season ${++index}",
                                                          style: const TextStyle(
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                            Container(
                                              color: Colors.transparent,
                                              height: 10,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                  width: double.infinity,
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 10,
                                                      horizontal: 170),
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(25),
                                                      topRight:
                                                          Radius.circular(25),
                                                      bottomLeft:
                                                          Radius.circular(25),
                                                      bottomRight:
                                                          Radius.circular(25),
                                                    ),
                                                  ),
                                                  child: const Center(
                                                    child: Text(
                                                      "Close",
                                                      style: TextStyle(
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  )),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    isScrollControlled: true,
                                  );
                                },
                                icon: const Icon(
                                  Icons.arrow_drop_down_sharp,
                                  size: 35,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  "Season $seasonId",
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Expanded(
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  physics: ClampingScrollPhysics(),
                                  itemBuilder: (ctx, index) {
                                    return buildTvSeasonEpisode(
                                        cubit.tvSeasonsModel!, index, context);
                                  },
                                  separatorBuilder: (ctx, index) =>
                                      const SizedBox(
                                    height: 8,
                                  ),
                                  itemCount:
                                      cubit.tvSeasonsModel!.episodes!.length,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 500,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: GridView.builder(
                              shrinkWrap: true,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,childAspectRatio: 2/3),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (c, index) {
                                return buildRelatedTvShowsItem(
                                    cubit.relatedTvShows, index, c);
                              },
                              itemCount: cubit.relatedTvShows.length,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}


