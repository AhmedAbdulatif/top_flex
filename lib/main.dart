import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:top_flex/business_logic/cubit/app_cubit/app_cubit.dart';
import 'package:top_flex/business_logic/cubit/genres_cubit/genres_cubit.dart';
import 'package:top_flex/business_logic/cubit/movies_cubit/movies_cubit.dart';
import 'package:top_flex/business_logic/cubit/movies_filter_cubit/movies_filter_cubit.dart';
import 'package:top_flex/business_logic/cubit/search_cubit/search_cubit.dart';
import 'package:top_flex/data/repository/movie_repository.dart';
import 'package:top_flex/shared/constants/themes.dart';
import 'package:top_flex/data/api/dio_helper.dart';

import 'business_logic/cubit/tv_filter_cubit/tv_filter_cubit.dart';
import 'data/models/movie_result_model.dart';
import 'modules/splash_screen.dart';
import 'package:device_preview/device_preview.dart';

final MovieRepository movieRepository = MovieRepository();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  Directory appDocDir = await getApplicationDocumentsDirectory();

  await DioHelper.init();
  await Hive.initFlutter(appDocDir.path);
  Hive.registerAdapter(MoviesResultsAdapter());
  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>(create: (_) => AppCubit()),
        BlocProvider<GenresCubit>(
          create: (_) => GenresCubit(movieRepository)..getGenres(1),
        ),
        BlocProvider<MoviesCubit>(
          create: (_) => MoviesCubit(movieRepository)
            ..getTopTvShows()
            ..getTrendingTvShows()
            ..getTopMovies()
            ..getTrendingMovies(),
        ),
        BlocProvider<MoviesFilterCubit>(
            create: (_) => MoviesFilterCubit(movieRepository)),
        BlocProvider<TvFilterCubit>(
            create: (_) => TvFilterCubit(movieRepository)),
        BlocProvider<SearchCubit>(create: (_) => SearchCubit(movieRepository)),
      ],
      child: MaterialApp(
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        theme: darkTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
