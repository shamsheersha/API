import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix_api/common/utils.dart';
import 'package:netflix_api/models/movie_details.dart';
import 'package:netflix_api/models/popular_movie_search.dart';
import 'package:netflix_api/services/api_services.dart';

class MovieDetailScreen extends StatefulWidget {
  final int movieId;
  const MovieDetailScreen({super.key, required this.movieId});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  ApiServices apiServices = ApiServices();
  late Future<MovieDetailsModel> movieDetail;
  late Future<MovieRecommendationsModel> movieRecommendations;

  @override
  void initState() {
    super.initState();
    fetchInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder<MovieDetailsModel>(
          future: movieDetail,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final movie = snapshot.data!;
              String genreText =
                  movie.genres.map((genre) => genre.name).join(', ');
              return Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height *
                            0.50, 
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage("$imageUrl${movie.posterPath}"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: SafeArea(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        movie.title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Text(
                            movie.releaseDate.year.toString(),
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(width: 30),
                          Text(
                            genreText,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 17),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        movie.overview,
                        maxLines: 6,
                        overflow: TextOverflow.ellipsis,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  FutureBuilder<MovieRecommendationsModel>(
                    future: movieRecommendations,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final movieRe = snapshot.data!;
                        return movieRe.results.isEmpty
                            ? const SizedBox()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('More like this'),
                                  const SizedBox(height: 20),
                                  GridView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: movieRe.results.length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 15,
                                      crossAxisSpacing: 5,
                                      childAspectRatio: 1.2 / 2,
                                    ),
                                    itemBuilder: (context, index) {
                                      final recommendation =
                                          movieRe.results[index];
                                      return InkWell(
                                        onTap: () {},
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MovieDetailScreen(
                                                            movieId: movieRe
                                                                .results[index]
                                                                .id)));
                                          },
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                '$imageUrl${recommendation.posterPath}',
                                            placeholder: (context, url) =>
                                                Image.asset(
                                                    'assets/netflix.png'),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Image.asset(
                                                        'assets/netflix.png'),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              );
                      }
                      return const Text('Something went wrong');
                    },
                  ),
                ],
              );
            } else {
              return const Text('Error');
            }
          },
        ),
      ),
    );
  }

  void fetchInitialData() {
    movieDetail = apiServices.getMovieDetails(widget.movieId);
    movieRecommendations = apiServices.getMovieRecommandations(widget.movieId);
    setState(() {});
  }
}
