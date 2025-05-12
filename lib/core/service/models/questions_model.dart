class QuestionsModel {
  final String quistion;
  final List<String> answers;
  final String correctAnswer;
  final String? image;

  QuestionsModel({
    required this.quistion,
    required this.answers,
    required this.correctAnswer,
    this.image,
  });
  factory QuestionsModel.fromJson(Map<String, dynamic> json) {
    return QuestionsModel(
      quistion: json['question'],
      answers: List<String>.from(json['answers']),
      correctAnswer: json['correct_answer'],
      image: json['image'],
    );
  }
}
