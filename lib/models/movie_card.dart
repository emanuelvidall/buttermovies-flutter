class MovieCard {
  final String title;
  final String imgUrl;
  final double rating;
  final String releaseDate;

  MovieCard({
    required this.title,
    required this.imgUrl,
    required this.rating,
    required this.releaseDate,
  });

  factory MovieCard.fromJson(Map<String, dynamic> json) {
    return MovieCard(
        title: json['title'],
        imgUrl: json['imgUrl'],
        rating: json['rating'].toDouble(),
        releaseDate: json['releaseDate']);
  }
}
