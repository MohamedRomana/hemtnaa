class CitiesModel {
  late final int id;
  late final String title;

  CitiesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }
}
