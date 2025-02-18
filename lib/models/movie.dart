class MovieModel {
  int id;
  String title;
  double? voteAverage;
  String posterPath;
  MovieModel({
    required this.id,
    required this.title,
    this.voteAverage,
    required this.posterPath,
  });
}
