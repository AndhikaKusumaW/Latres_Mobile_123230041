class Show {
  final int id;
  final String name;
  final String imageUrl;
  final double rating;
  final List<String> genres;
  final String summary;

  Show({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.genres,
    required this.summary,
  });

  factory Show.fromJson(Map<String, dynamic> json) {
    return Show(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
      imageUrl: json['image']?['medium'] ?? 'https://via.placeholder.com/150',
      rating: (json['rating']?['average'] ?? 0.0).toDouble(),
      genres: List<String>.from(json['genres'] ?? []),
      summary: (json['summary'] ?? '').replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ''),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'imageUrl': imageUrl,
    'rating': rating,
    'genres': genres,
    'summary': summary,
  };
}