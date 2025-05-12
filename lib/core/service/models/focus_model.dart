import 'package:flutter/material.dart';

class FocusModel {
  final Widget question;
  final List<FocusAnswer> answers;
  final int correctAnswerId;

  FocusModel({
    required this.question,
    required this.answers,
    required this.correctAnswerId,
  });
}

class FocusAnswer {
  final int id;
  final Widget widget;

  FocusAnswer({required this.id, required this.widget});
}
