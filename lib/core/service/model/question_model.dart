class QuestionsModel {
  late final String title;
  late final String desc;

  QuestionsModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    desc = json['desc'];
  }
}
