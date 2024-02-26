class Cast {
  final String name;
  final String character;
  final String avatarUrl;

  Cast({
    required this.name,
    required this.character,
    required this.avatarUrl,
  });

  factory Cast.fromJson(Map<String, dynamic> json) {
    return Cast(
        name: json['title'] as String,
        avatarUrl: json['profile_path'] as String,
        character: json['character'] as String);
  }
}
