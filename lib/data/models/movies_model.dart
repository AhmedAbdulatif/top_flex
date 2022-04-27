
import 'movie_result_model.dart';


class MoviesModel {
  Dates? dates;
  int? page;
  List<MoviesResults>? results;
  int? totalPages;
  int? totalResults;

  MoviesModel(
      {this.dates,
      this.page,
      this.results,
      this.totalPages,
      this.totalResults});

  MoviesModel.fromJson(Map<String, dynamic> json) {
    dates = json['dates'] != null ? Dates.fromJson(json['dates']) : null;
    page = json['page'];
    if (json['results'] != null) {
      results = <MoviesResults>[];
      json['results'].forEach((v) {
        results!.add(MoviesResults.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  MoviesModel.fromError() {
    dates = null;
    page = 0;
    results = [];
    totalPages = 0;
    totalResults = 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (dates != null) {
      data['dates'] = dates!.toJson();
    }
    data['page'] = page;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = totalPages;
    data['total_results'] = totalResults;
    return data;
  }
}

class Dates {
  String? maximum;
  String? minimum;

  Dates({this.maximum, this.minimum});

  Dates.fromJson(Map<String, dynamic> json) {
    maximum = json['maximum'];
    minimum = json['minimum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['maximum'] = maximum;
    data['minimum'] = minimum;
    return data;
  }
}


