class OnBoardingModel {
  late final int id;
  late final String title;
  late final String desc;
  late final String image;

  OnBoardingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    desc = json['desc'];
    image = json['image'];
  }
}
