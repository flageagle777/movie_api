import 'package:movie_api/models/movie.dart';


class MovieController {
  final List<MovieModel> movie = [
    MovieModel(
      id: 1,
      title: "Superman Come back",
      voteAverage: 4.0,
      posterPath: "assets/img1.jpg",
    ),
    MovieModel(
      id: 2,
      title: "Batman loose again",
      voteAverage: 5.0,
      posterPath: "assets/img2.jpg",
    ),
  ];
}
