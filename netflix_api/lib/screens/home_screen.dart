import 'package:flutter/material.dart';
import 'package:netflix_api/common/utils.dart';
import 'package:netflix_api/models/tv_series_model.dart';
import 'package:netflix_api/models/upcoming_model.dart';
import 'package:netflix_api/services/api_services.dart';
import 'package:netflix_api/widgets/custom_carousel.dart';
import 'package:netflix_api/widgets/movie_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<UpcomingMovieModel> upcomingFuture;
  late Future<UpcomingMovieModel> nowPlayingFuture;
  late Future<TvSeriesModel> topRatedSeries;

  ApiServices apiServices = ApiServices();
  @override
  void initState() {
    upcomingFuture = apiServices.getUpcomingMovies();
    nowPlayingFuture = apiServices.getNowPlayingMovies();
    topRatedSeries = apiServices.getTopRatedSeries();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Image.asset(
            'assets/logo.png',
            height: 50,
            width: 120,
          ),
          backgroundColor: kBackgroundColor,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: InkWell(
                onTap: () {},
                child: const Icon(
                  Icons.search,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Container(
                color: Colors.blue,
                height: 27,
                width: 27,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(future: topRatedSeries, builder: (context, snapshot) {
                if(snapshot.hasData){
                  return CustomCarouselSlider(data: snapshot.data!);
                }else{
                  return const SizedBox.shrink();
                }
                
              },),
              SizedBox(
                height: 240,
                child: MovieCardWidget(
                    future: nowPlayingFuture, headLineText: 'Now Playing '),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 240,
                child: MovieCardWidget(
                    future: upcomingFuture, headLineText: 'Upcoming Movies'),
              ),
            ],
          ),
        ));
  }
}
