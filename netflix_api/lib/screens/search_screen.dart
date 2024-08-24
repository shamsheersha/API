import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_api/common/utils.dart';
import 'package:netflix_api/models/popular_movie_search.dart';
import 'package:netflix_api/models/search_movie_model.dart';
import 'package:netflix_api/screens/movie_detailed_screen.dart';
import 'package:netflix_api/services/api_services.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  ApiServices apiServices = ApiServices();
  late Future<MovieRecommendationsModel> popularMovies;

  SearchMovieModel? searchMovieModel;

  @override
  void initState() {
    super.initState();
    popularMovies = apiServices.popularMovieSearch();
  }

  void search(String query) async {
    await apiServices.getMovie(query).then((results) {
      setState(() {
        searchMovieModel = results;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                CupertinoSearchTextField(
                  padding: const EdgeInsets.all(15),
                  controller: searchController,
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Icon(
                      Icons.search,
                      color: Colors.grey,
                      size: 20,
                    ),
                  ),
                  suffixIcon: const Icon(
                    Icons.cancel,
                    color: Colors.grey,
                    size: 20,
                  ),
                  style: const TextStyle(color: Colors.white),
                  backgroundColor: Colors.grey.withOpacity(0.3),
                  onChanged: (value) async {
                    if (value.isEmpty) {
                    } else {
                      search(searchController.text);
                    }
                  },
                ),
                searchController.text.isEmpty
                    ? FutureBuilder(
                        future: popularMovies,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var data = snapshot.data?.results;

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Text(
                                    "Top Searches",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                ListView.builder(
                                    padding: const EdgeInsets.all(10),
                                    scrollDirection: Axis.vertical,
                                    itemCount: data!.length,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MovieDetailScreen(
                                                        movieId: data[index].id,
                                                      )));
                                        },
                                        child: Container(
                                          height: 130,
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Row(
                                            children: [
                                              CachedNetworkImage(
                                                imageUrl:
                                                    "$imageUrl${data[index].posterPath}",
                                                placeholder: (context, url) =>
                                                    Image.asset(
                                                        'assets/netflix.png'),
                                                errorWidget: (context, url,
                                                        error) =>
                                                    Image.asset(
                                                        'assets/netflix.png'),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              SizedBox(
                                                  width: 260,
                                                  child: Text(
                                                    data[index].title,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ))
                                            ],
                                          ),
                                        ),
                                      );
                                    })
                              ],
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      )
                    : searchMovieModel == null
                        ? const SizedBox.shrink()
                        : GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: searchMovieModel?.results.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 15,
                                    crossAxisSpacing: 5,
                                    childAspectRatio: 1.2 / 2),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MovieDetailScreen(
                                          movieId: searchMovieModel!
                                              .results[index].id),
                                    ),
                                  );
                                },
                                child: Column(
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl:
                                          '$imageUrl${searchMovieModel!.results[index].backdropPath}',
                                      height: 170,
                                      placeholder: (context, url) =>
                                          Image.asset('assets/netflix.png'),
                                      errorWidget: (context, url, error) =>
                                          Image.asset('assets/netflix.png'),
                                    ),
                                    SizedBox(
                                        width: 100,
                                        child: Text(
                                            maxLines: 2,
                                            style:
                                                const TextStyle(fontSize: 14),
                                            overflow: TextOverflow.ellipsis,
                                            searchMovieModel!
                                                .results[index].originalTitle))
                                  ],
                                ),
                              );
                            },
                          )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
