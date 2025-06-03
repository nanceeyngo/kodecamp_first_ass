class Quote {
  final int id;
  final String text;
  final String author;
  bool isFavorite;

  Quote({
    required this.id,
    required this.text,
    required this.author,
    this.isFavorite = false,
  });
}