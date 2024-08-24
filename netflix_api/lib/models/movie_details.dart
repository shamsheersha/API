class Genre {
  int id;
  String name;

  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class MovieDetailsModel {
  bool adult;
  String backdropPath;
  int budget;
  String homepage;
  int id;
  String imdbId;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  DateTime releaseDate;
  int revenue;
  int runtime;
  String status;
  String tagline;
  String title;
  bool video;
  double voteAverage;
  int voteCount;
  List<Genre> genres;  // Add this line

  MovieDetailsModel({
    required this.adult,
    required this.backdropPath,
    required this.budget,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    required this.genres,  // Add this line
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) => MovieDetailsModel(
    adult: json["adult"],
    backdropPath: json["backdrop_path"] ?? '',
    budget: json["budget"],
    homepage: json["homepage"] ?? '',
    id: json["id"],
    imdbId: json["imdb_id"] ?? '',
    originalLanguage: json["original_language"],
    originalTitle: json["original_title"],
    overview: json["overview"] ?? '',
    popularity: json["popularity"]?.toDouble(),
    posterPath: json["poster_path"] ?? '',
    releaseDate: DateTime.parse(json["release_date"]),
    revenue: json["revenue"],
    runtime: json["runtime"] ?? 0,
    status: json["status"] ?? '',
    tagline: json["tagline"] ?? '',
    title: json["title"],
    video: json["video"],
    voteAverage: json["vote_average"]?.toDouble(),
    voteCount: json["vote_count"],
    genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),  // Add this line
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "budget": budget,
    "homepage": homepage,
    "id": id,
    "imdb_id": imdbId,
    "original_language": originalLanguage,
    "original_title": originalTitle,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "release_date": "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
    "revenue": revenue,
    "runtime": runtime,
    "status": status,
    "tagline": tagline,
    "title": title,
    "video": video,
    "vote_average": voteAverage,
    "vote_count": voteCount,
    "genres": List<dynamic>.from(genres.map((x) => x.toJson())),  // Add this line
  };
}
