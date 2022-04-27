import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:top_flex/data/models/movies_model.dart';
import 'package:top_flex/data/models/tv_details_model.dart';
import 'package:top_flex/data/models/tv_seasons_model.dart';
import 'package:top_flex/data/models/tv_shows_model.dart';
import 'package:top_flex/shared/constants/strings.dart';

import '../models/cast_model.dart';

class DioHelper {
  static late Dio dio;
  static init() {
    BaseOptions options = BaseOptions(
      baseUrl: mainUrl,
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000,
      receiveDataWhenStatusError: true,
    );
    dio = Dio(options);
  }

  static Future<List<dynamic>> getData(
      String path,
      {required Map<String, dynamic> query}) async {
    try {
      Response response =
      await dio.get(path, queryParameters: query);
      return response.data["results"];
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  static Future<dynamic> getPaginationData(
      String path,
      {required Map<String, dynamic> query}) async {
    try {
      Response response =
      await dio.get(path, queryParameters: query);
      return MoviesModel.fromJson(response.data);
    } catch (e) {
      print(e);

      return MoviesModel.fromError();
    }
  }

  static Future<CastModel> getMovieCastData(
      String path,
      {required Map<String, dynamic> query}) async {
    try {
      Response response =
      await dio.get(path, queryParameters: query);
      print(response.data);
      print("success");
      return CastModel.fromJson(response.data);
    } catch (e) {
      print(e);
      print("fuck");
      return CastModel.fromError();
    }
  }

  static Future<dynamic> getTvPaginationData(
      String path,
      {required Map<String, dynamic> query}) async {
    try {
      Response response =
      await dio.get(path, queryParameters: query);
      return TvShowsModel.fromJson(response.data);
    } catch (e) {
      return MoviesModel.fromError();
    }
  }

  static Future<dynamic> getTvDetailsData(
      String path,
      {required Map<String, dynamic> query}) async {
    try {
      Response response =
      await dio.get(path, queryParameters: query);
      return TvDetailsModel.fromJson(response.data);
    } catch (e) {
      print(e);
      return TvDetailsModel.fromError();
    }
  }

  static Future<dynamic> getTvEpisodesData(
      String path,
      {required Map<String, dynamic> query}) async {
    try {
      Response response =
      await dio.get(path, queryParameters: query);
      return TvSeasonsModel.fromJson(response.data);
    } catch (e) {
      print(e);
      return TvSeasonsModel.fromError();
    }
  }

  static Future<List<dynamic>> getGenresData(
      String path,
      {required Map<String, dynamic> query}) async {
    try {
      Response response =
      await dio.get(path, queryParameters: query);
      return response.data["genres"];
    } catch (e) {
      return [];
    }
  }
}