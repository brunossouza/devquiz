import 'dart:convert';

import 'package:devquiz/shared/models/question_model.dart';

enum Level { facil, medio, dificil, perito }

extension LevelStringExt on String {
  Level get levelParse => {
        "facil": Level.facil,
        "medio": Level.medio,
        "dificil": Level.dificil,
        "perito": Level.perito,
      }[this]!;
}

extension LevelExt on Level {
  String get stringParse => {
        Level.facil: "facil",
        Level.medio: "medio",
        Level.dificil: "dificil",
        Level.perito: "perito",
      }[this]!;
}

class QuizModel {
  final String title;
  final List<QuestionModel> questions;
  final String image;
  final Level level;
  final int questionAwnsered;

  QuizModel({
    required this.title,
    required this.questions,
    required this.image,
    required this.level,
    this.questionAwnsered = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'questions': questions.map((x) => x.toMap()).toList(),
      'image': image,
      'level': level.stringParse,
      'questionAwnsered': questionAwnsered,
    };
  }

  factory QuizModel.fromMap(Map<String, dynamic> map) {
    return QuizModel(
      title: map['title'],
      questions: List<QuestionModel>.from(
          map['questions']?.map((x) => QuestionModel.fromMap(x))),
      image: map['image'],
      level: map['level'].toString().levelParse,
      questionAwnsered: map['questionAwnsered'],
    );
  }

  String toJson() => json.encode(toMap());

  factory QuizModel.fromJson(String source) =>
      QuizModel.fromMap(json.decode(source));
}
