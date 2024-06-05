import 'package:flutter/material.dart';

class Question {
  String question;
  List<String> choices;
  String correctAnswer;
  String explanation;

  Question({
    required this.question,
    required this.choices,
    required this.correctAnswer,
    required this.explanation,
  });
}

class QuizModel extends ChangeNotifier {
  Map<String, List<Question>> questionsByCategory = {
    'General Knowledge': [
      Question(
        question: 'What is the capital of France?',
        choices: ['Paris', 'London', 'Rome', 'Berlin'],
        correctAnswer: 'Paris',
        explanation: 'Paris is the capital city of France.',
      ),
      Question(
        question: 'Who wrote "Hamlet"?',
        choices: ['Charles Dickens', 'Jane Austen', 'William Shakespeare', 'Mark Twain'],
        correctAnswer: 'William Shakespeare',
        explanation: 'William Shakespeare wrote the tragedy "Hamlet".',
      ),
    ],
    'Science': [
      Question(
        question: 'What is the chemical symbol for water?',
        choices: ['O2', 'H2O', 'CO2', 'HO'],
        correctAnswer: 'H2O',
        explanation: 'The chemical symbol for water is H2O.',
      ),
      Question(
        question: 'What planet is known as the Red Planet?',
        choices: ['Earth', 'Mars', 'Jupiter', 'Saturn'],
        correctAnswer: 'Mars',
        explanation: 'Mars is known as the Red Planet due to its reddish appearance.',
      ),
    ],
    'Math': [
      Question(
        question: 'What is the value of Pi?',
        choices: ['2.14', '3.14', '4.14', '5.14'],
        correctAnswer: '3.14',
        explanation: 'Pi is approximately equal to 3.14.',
      ),
      Question(
        question: 'What is 5 + 7?',
        choices: ['10', '11', '12', '13'],
        correctAnswer: '12',
        explanation: '5 + 7 equals 12.',
      ),
    ],
  };

  void addQuestion(String category, String question, List<String> choices, String correctAnswer, String explanation) {
    questionsByCategory[category]!.add(Question(
      question: question,
      choices: choices,
      correctAnswer: correctAnswer,
      explanation: explanation,
    ));
    notifyListeners();
  }

  bool checkAnswer(int index, String answer, String category) {
    return questionsByCategory[category]![index].correctAnswer.toLowerCase() == answer.toLowerCase();
  }
}
