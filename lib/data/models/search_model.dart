class SearchModel {
  int? page;
  List<SearchResults>? results;
  int? totalPages;
  int? totalResults;

  SearchModel({this.page, this.results, this.totalPages, this.totalResults});

  SearchModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      results = <SearchResults>[];
      json['results'].forEach((v) {
        results!.add(SearchResults.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = totalPages;
    data['total_results'] = totalResults;
    return data;
  }
}

class SearchResults {
  bool? adult;
  String? backdropPath;
  List<dynamic>? genreIds;
  dynamic id;
  String? mediaType;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  dynamic popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  dynamic voteAverage;
  dynamic voteCount;
  String? firstAirDate;
  String? name;
  List<dynamic>? originCountry;
  String? originalName;

  SearchResults(
      {this.adult,
        this.backdropPath,
        this.genreIds,
        this.id,
        this.mediaType,
        this.originalLanguage,
        this.originalTitle,
        this.overview,
        this.popularity,
        this.posterPath,
        this.releaseDate,
        this.title,
        this.video,
        this.voteAverage,
        this.voteCount,
        this.firstAirDate,
        this.name,
        this.originCountry,
        this.originalName});

  SearchResults.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    genreIds = json['genre_ids'].cast<int>();
    id = json['id'];
    mediaType = json['media_type'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
    video = json['video'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    firstAirDate = json['first_air_date'];
    name = json['name'];
    originCountry = json['origin_country'];
    originalName = json['original_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['adult'] = adult;
    data['backdrop_path'] = backdropPath;
    data['genre_ids'] = genreIds;
    data['id'] = id;
    data['media_type'] = mediaType;
    data['original_language'] = originalLanguage;
    data['original_title'] = originalTitle;
    data['overview'] = overview;
    data['popularity'] = popularity;
    data['poster_path'] = posterPath;
    data['release_date'] = releaseDate;
    data['title'] = title;
    data['video'] = video;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    data['first_air_date'] = firstAirDate;
    data['name'] = name;
    data['origin_country'] = originCountry;
    data['original_name'] = originalName;
    return data;
  }
}
