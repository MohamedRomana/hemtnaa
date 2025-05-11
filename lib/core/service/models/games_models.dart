class GamesModels {
  final String title;
  final String description;
  final String image;
  final String button;

  GamesModels({
    required this.title,
    required this.image,
    required this.description,
    required this.button,
  
  });
  factory GamesModels.fromJson(Map<String, dynamic> json) => GamesModels(
    title: json["title"],
    image: json["image"],
    description: json["description"],
    button: json["button"],

  );
}


