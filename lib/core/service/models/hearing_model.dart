class HearingModel {
  final String quistion;
  final String quistionText;
  final List<String> answers;
  final String correctAnswer;
  final String? image;

  HearingModel({
    required this.quistionText,
    required this.quistion,
    required this.answers,
    required this.correctAnswer,
    this.image,
  });
  factory HearingModel.fromJson(Map<String, dynamic> json) {
    return HearingModel(
      quistion: json['question'],
      answers: List<String>.from(json['answers']),
      correctAnswer: json['correct_answer'],
      image: json['image'],
      quistionText: json['question_text'],
    );
  }
}
