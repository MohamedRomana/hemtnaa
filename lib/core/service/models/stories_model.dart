class StoriesModel {
  final String name;
  final String video;

  StoriesModel({required this.name, required this.video});

  factory StoriesModel.fromJson(Map<String, dynamic> json) {
    return StoriesModel(name: json['name'], video: json['video']);
  }
}
