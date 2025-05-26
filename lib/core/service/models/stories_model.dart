class StoriesModel {
  final String name;
  final String video;
  final String thumbnail;

  StoriesModel({
    required this.name,
    required this.video,
    required this.thumbnail,
  });

  factory StoriesModel.fromJson(Map<String, dynamic> json) {
    return StoriesModel(
      name: json['name'],
      video: json['video'],
      thumbnail: json['thumbnail'],
    );
  }
}
