class Movie {
  final String title;
  final String imgUrl;
  final String backdropUrl;
  final double rating;
  final String releaseDate;

  Movie({
    required this.title,
    required this.imgUrl,
    required this.backdropUrl,
    required this.rating,
    required this.releaseDate,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        title: json['title'],
        imgUrl: json['poster_path'],
        backdropUrl: json['backdrop_path'],
        rating: json['vote_average'].toDouble(),
        releaseDate: json['release_date']);
  }
}
