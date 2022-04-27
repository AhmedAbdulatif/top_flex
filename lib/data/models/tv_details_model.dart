class TvDetailsModel {
  bool? adult;
  String? backdropPath;
  List<CreatedBy>? createdBy;
  List<dynamic>? episodeRunTime;
  String? firstAirDate;
  List<TvDetailsGenres>? genres;
  String? homepage;
  dynamic id;
  bool? inProduction;
  List<String>? languages;
  String? lastAirDate;
  LastEpisodeToAir? lastEpisodeToAir;
  String? name;
  NextEpisodeToAir? nextEpisodeToAir;
  List<TvDetailsNetworks>? networks;
  dynamic numberOfEpisodes;
  dynamic numberOfSeasons;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalName;
  String? overview;
  dynamic popularity;
  String? posterPath;
  List<ProductionCountries>? productionCountries;
  List<Seasons>? seasons;
  List<SpokenLanguages>? spokenLanguages;
  String? status;
  String? tagline;
  String? type;
  dynamic voteAverage;
  dynamic voteCount;

  TvDetailsModel(
      {this.adult,
        this.backdropPath,
        this.createdBy,
        this.episodeRunTime,
        this.firstAirDate,
        this.genres,
        this.homepage,
        this.id,
        this.inProduction,
        this.languages,
        this.lastAirDate,
        this.lastEpisodeToAir,
        this.name,
        this.nextEpisodeToAir,
        this.networks,
        this.numberOfEpisodes,
        this.numberOfSeasons,
        this.originCountry,
        this.originalLanguage,
        this.originalName,
        this.overview,
        this.popularity,
        this.posterPath,
        this.productionCountries,
        this.seasons,
        this.spokenLanguages,
        this.status,
        this.tagline,
        this.type,
        this.voteAverage,
        this.voteCount});

  TvDetailsModel.fromError(){
    id = 0;
  }

  TvDetailsModel.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    if (json['created_by'] != null) {
      createdBy = <CreatedBy>[];
      json['created_by'].forEach((v) {
        createdBy!.add(CreatedBy.fromJson(v));
      });
    }
    episodeRunTime = json['episode_run_time'].cast<int>();
    firstAirDate = json['first_air_date'];
    if (json['genres'] != null) {
      genres = <TvDetailsGenres>[];
      json['genres'].forEach((v) {
        genres!.add(TvDetailsGenres.fromJson(v));
      });
    }
    homepage = json['homepage'];
    id = json['id'];
    inProduction = json['in_production'];
    languages = json['languages'].cast<String>();
    lastAirDate = json['last_air_date'];
    lastEpisodeToAir = json['last_episode_to_air'] != null
        ? LastEpisodeToAir.fromJson(json['last_episode_to_air'])
        : null;
    name = json['name'];
    nextEpisodeToAir = json['next_episode_to_air'] != null
        ? NextEpisodeToAir.fromJson(json['next_episode_to_air'])
        : null;
    if (json['networks'] != null) {
      networks = <TvDetailsNetworks>[];
      json['networks'].forEach((v) {
        networks!.add(TvDetailsNetworks.fromJson(v));
      });
    }
    numberOfEpisodes = json['number_of_episodes'];
    numberOfSeasons = json['number_of_seasons'];
    originCountry = json['origin_country'].cast<String>();
    originalLanguage = json['original_language'];
    originalName = json['original_name'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];

    if (json['production_countries'] != null) {
      productionCountries = <ProductionCountries>[];
      json['production_countries'].forEach((v) {
        productionCountries!.add(ProductionCountries.fromJson(v));
      });
    }
    if (json['seasons'] != null) {
      seasons = <Seasons>[];
      json['seasons'].forEach((v) {
        seasons!.add(Seasons.fromJson(v));
      });
    }
    if (json['spoken_languages'] != null) {
      spokenLanguages = <SpokenLanguages>[];
      json['spoken_languages'].forEach((v) {
        spokenLanguages!.add(SpokenLanguages.fromJson(v));
      });
    }
    status = json['status'];
    tagline = json['tagline'];
    type = json['type'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['adult'] = adult;
    data['backdrop_path'] = backdropPath;
    if (createdBy != null) {
      data['created_by'] = createdBy!.map((v) => v.toJson()).toList();
    }
    data['episode_run_time'] = episodeRunTime;
    data['first_air_date'] = firstAirDate;
    if (genres != null) {
      data['genres'] = genres!.map((v) => v.toJson()).toList();
    }
    data['homepage'] = homepage;
    data['id'] = id;
    data['in_production'] = inProduction;
    data['languages'] = languages;
    data['last_air_date'] = lastAirDate;
    if (lastEpisodeToAir != null) {
      data['last_episode_to_air'] = lastEpisodeToAir!.toJson();
    }
    data['name'] = name;
    if (nextEpisodeToAir != null) {
      data['next_episode_to_air'] = nextEpisodeToAir!.toJson();
    }
    if (networks != null) {
      data['networks'] = networks!.map((v) => v.toJson()).toList();
    }
    data['number_of_episodes'] = numberOfEpisodes;
    data['number_of_seasons'] = numberOfSeasons;
    data['origin_country'] = originCountry;
    data['original_language'] = originalLanguage;
    data['original_name'] = originalName;
    data['overview'] = overview;
    data['popularity'] = popularity;
    data['poster_path'] = posterPath;

    if (productionCountries != null) {
      data['production_countries'] =
          productionCountries!.map((v) => v.toJson()).toList();
    }
    if (seasons != null) {
      data['seasons'] = seasons!.map((v) => v.toJson()).toList();
    }
    if (spokenLanguages != null) {
      data['spoken_languages'] =
          spokenLanguages!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['tagline'] = tagline;
    data['type'] = type;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    return data;
  }
}

class CreatedBy {
  dynamic id;
  String? creditId;
  String? name;
  dynamic gender;
  String? profilePath;

  CreatedBy({this.id, this.creditId, this.name, this.gender, this.profilePath});

  CreatedBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    creditId = json['credit_id'];
    name = json['name'];
    gender = json['gender'];
    profilePath = json['profile_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['credit_id'] = creditId;
    data['name'] = name;
    data['gender'] = gender;
    data['profile_path'] = profilePath;
    return data;
  }
}

class TvDetailsGenres {
  dynamic id;
  String? name;

  TvDetailsGenres({this.id, this.name});

  TvDetailsGenres.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class LastEpisodeToAir {
  String? airDate;
  dynamic episodeNumber;
  dynamic id;
  String? name;
  String? overview;
  String? productionCode;
  dynamic seasonNumber;
  String? stillPath;
  dynamic voteAverage;
  dynamic voteCount;

  LastEpisodeToAir(
      {this.airDate,
        this.episodeNumber,
        this.id,
        this.name,
        this.overview,
        this.productionCode,
        this.seasonNumber,
        this.stillPath,
        this.voteAverage,
        this.voteCount});

  LastEpisodeToAir.fromJson(Map<String, dynamic> json) {
    airDate = json['air_date'];
    episodeNumber = json['episode_number'];
    id = json['id'];
    name = json['name'];
    overview = json['overview'];
    productionCode = json['production_code'];
    seasonNumber = json['season_number'];
    stillPath = json['still_path'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['air_date'] = airDate;
    data['episode_number'] = episodeNumber;
    data['id'] = id;
    data['name'] = name;
    data['overview'] = overview;
    data['production_code'] = productionCode;
    data['season_number'] = seasonNumber;
    data['still_path'] = stillPath;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    return data;
  }
}

class NextEpisodeToAir {
  String? airDate;
  dynamic episodeNumber;
  dynamic id;
  String? name;
  String? overview;
  String? productionCode;
  dynamic seasonNumber;
  dynamic stillPath;
  dynamic voteAverage;
  dynamic voteCount;

  NextEpisodeToAir(
      {this.airDate,
        this.episodeNumber,
        this.id,
        this.name,
        this.overview,
        this.productionCode,
        this.seasonNumber,
        this.stillPath,
        this.voteAverage,
        this.voteCount});

  NextEpisodeToAir.fromJson(Map<String, dynamic> json) {
    airDate = json['air_date'];
    episodeNumber = json['episode_number'];
    id = json['id'];
    name = json['name'];
    overview = json['overview'];
    productionCode = json['production_code'];
    seasonNumber = json['season_number'];
    stillPath = json['still_path'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['air_date'] = airDate;
    data['episode_number'] = episodeNumber;
    data['id'] = id;
    data['name'] = name;
    data['overview'] = overview;
    data['production_code'] = productionCode;
    data['season_number'] = seasonNumber;
    data['still_path'] = stillPath;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    return data;
  }
}

class TvDetailsNetworks {
  String? name;
  dynamic id;
  String? logoPath;
  String? originCountry;

  TvDetailsNetworks({this.name, this.id, this.logoPath, this.originCountry});

  TvDetailsNetworks.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    logoPath = json['logo_path'];
    originCountry = json['origin_country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['logo_path'] = logoPath;
    data['origin_country'] = originCountry;
    return data;
  }
}

class ProductionCountries {
  String? iso31661;
  String? name;

  ProductionCountries({this.iso31661, this.name});

  ProductionCountries.fromJson(Map<String, dynamic> json) {
    iso31661 = json['iso_3166_1'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['iso_3166_1'] = iso31661;
    data['name'] = name;
    return data;
  }
}

class Seasons {
  String? airDate;
  dynamic episodeCount;
  dynamic id;
  String? name;
  String? overview;
  String? posterPath;
  dynamic seasonNumber;

  Seasons(
      {this.airDate,
        this.episodeCount,
        this.id,
        this.name,
        this.overview,
        this.posterPath,
        this.seasonNumber});

  Seasons.fromJson(Map<String, dynamic> json) {
    airDate = json['air_date'];
    episodeCount = json['episode_count'];
    id = json['id'];
    name = json['name'];
    overview = json['overview'];
    posterPath = json['poster_path'];
    seasonNumber = json['season_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['air_date'] = airDate;
    data['episode_count'] = episodeCount;
    data['id'] = id;
    data['name'] = name;
    data['overview'] = overview;
    data['poster_path'] = posterPath;
    data['season_number'] = seasonNumber;
    return data;
  }
}

class SpokenLanguages {
  String? englishName;
  String? iso6391;
  String? name;

  SpokenLanguages({this.englishName, this.iso6391, this.name});

  SpokenLanguages.fromJson(Map<String, dynamic> json) {
    englishName = json['english_name'];
    iso6391 = json['iso_639_1'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['english_name'] = englishName;
    data['iso_639_1'] = iso6391;
    data['name'] = name;
    return data;
  }
}
