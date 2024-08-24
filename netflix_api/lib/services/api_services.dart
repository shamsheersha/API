import 'dart:convert';
import 'dart:developer';

import 'package:netflix_api/common/utils.dart';
import 'package:netflix_api/models/movie_details.dart';
import 'package:netflix_api/models/popular_movie_search.dart';
import 'package:netflix_api/models/search_movie_model.dart';
import 'package:netflix_api/models/tv_series_model.dart';
import 'package:netflix_api/models/upcoming_model.dart';
import 'package:http/http.dart' as http;

const baseUrl = "https://api.themoviedb.org/3/";
var key = "?api_key=$apiKey";
late String endPoint;

class ApiServices {
  Future<UpcomingMovieModel> getUpcomingMovies() async {
    endPoint = "movie/upcoming";
    final url = "$baseUrl$endPoint$key";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      log('Success');

      return UpcomingMovieModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load upcoming movies");
  }

  Future<UpcomingMovieModel> getNowPlayingMovies() async {
    endPoint = "movie/now_playing";
    final url = "$baseUrl$endPoint$key";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      log('Success');

      return UpcomingMovieModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load now playing movies");
  }

  Future<TvSeriesModel> getTopRatedSeries() async {
    endPoint = "tv/top_rated";
    final url = "$baseUrl$endPoint$key";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      log('Success');

      return TvSeriesModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load top related movies");
  }

  Future<SearchMovieModel> getMovie(String searchText) async {
    endPoint = "search/movie?query=$searchText";
    final url = "$baseUrl$endPoint";
    final response = await http.get(Uri.parse(url), headers: {
      'Authorization':
          "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyZjJlYjY5YjFjN2NlMmY5ODY5MjAxMWQ0NGE5YzlhMyIsIm5iZiI6MTcyNDIyMzY4Mi44Njg3MTIsInN1YiI6IjY2YzU4OTJlNzlmYTE2YTJiY2QxYWZjZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Z36HBIn0pJWnZTeV6RAkvxRofSPnXCxa-j4OOxY09Jc"
    });
    if (response.statusCode == 200) {
      log("success4");
      return SearchMovieModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load searched movies");
  }

  Future<MovieRecommendationsModel> popularMovieSearch() async {
    endPoint = "movie/popular";
    final url = "$baseUrl$endPoint$key";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log("success5");
      return MovieRecommendationsModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load popular movies search");
  }

  Future<MovieDetailsModel> getMovieDetails(int movieId) async {
    endPoint = "movie/$movieId";
    final url = "$baseUrl$endPoint$key";
    final response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      
      log("success6");
      
      return MovieDetailsModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load movie details");
  }

  Future<MovieRecommendationsModel> getMovieRecommandations(int movieId) async {
    endPoint = "movie/$movieId/recommendations";
    final url = "$baseUrl$endPoint$key";
    final response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      
      log("success7");
      
      return MovieRecommendationsModel.fromJson(jsonDecode(response.body));
      
    }
    throw Exception("Failed to load more like this");
  }
}
