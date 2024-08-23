import 'package:flutter/material.dart';
import 'package:netflix_api/common/utils.dart';
import 'package:netflix_api/models/movie_details.dart';
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

  @override
  void initState() {
    super.initState();
    fetchInitialData();
  }

  @override
  Widget build(BuildContext context) {
    print('dsfdssssssssssssss');
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(future: movieDetail,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            final movie = snapshot.data;
            return Column(
            children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("$imageUrl${movie!.backdropPath}"),
                    ),
                  ),
                ),
              ],
            )
          ]);
          }else{
            return const SizedBox();
          }
          
        },
          
        ),
      ),
    );
  }

  fetchInitialData() {
    movieDetail = apiServices.getMovieDetails(widget.movieId);
    setState(() {});
  }
}
