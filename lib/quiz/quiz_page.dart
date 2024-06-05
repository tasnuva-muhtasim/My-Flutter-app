import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'quiz_model.dart';
import 'timer.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();
  final TextEditingController _explanationController = TextEditingController();

  bool _isQuizActive = false;
  int _currentQuestionIndex = 0;
  int _score = 0;
  int _remainingTime = 60;
  String _selectedCategory = 'General Knowledge';
  List<String> _choices = [''];

  @override
  void initState() {
    super.initState();
  }

  void _addQuestion() {
    if (_questionController.text.isNotEmpty &&
        _answerController.text.isNotEmpty &&
        _choices.every((choice) => choice.isNotEmpty) &&
        _explanationController.text.isNotEmpty) {
      setState(() {
        Provider.of<QuizModel>(context, listen: false).addQuestion(
          _selectedCategory,
          _questionController.text,
          _choices,
          _answerController.text,
          _explanationController.text,
        );
        _questionController.clear();
        _answerController.clear();
        _explanationController.clear();
        _choices = [''];
      });
    }
  }

  void _startQuiz() {
    setState(() {
      _isQuizActive = true;
      _currentQuestionIndex = 0;
      _score = 0;
      _remainingTime = 60;
    });
    TimerWidget.startTimer(context, _endQuiz, _updateRemainingTime);
  }

  void _endQuiz() {
    setState(() {
      _isQuizActive = false;
    });
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Quiz Finished'),
        content: Text('Your score is $_score/${Provider.of<QuizModel>(context, listen: false).questionsByCategory[_selectedCategory]!.length}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _answerQuestion(String answer) {
    final quizModel = Provider.of<QuizModel>(context, listen: false);
    if (quizModel.checkAnswer(_currentQuestionIndex, answer, _selectedCategory)) {
      _score++;
    }
    setState(() {
      if (_currentQuestionIndex < quizModel.questionsByCategory[_selectedCategory]!.length - 1) {
        _currentQuestionIndex++;
      } else {
        _endQuiz();
      }
    });
  }

  void _updateRemainingTime(int remainingTime) {
    setState(() {
      _remainingTime = remainingTime;
    });
  }

  void _addChoice() {
    setState(() {
      _choices.add('');
    });
  }

  void _updateChoice(int index, String value) {
    setState(() {
      _choices[index] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final quizModel = Provider.of<QuizModel>(context);
    final questions = quizModel.questionsByCategory[_selectedCategory]!;

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isQuizActive
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Time remaining: $_remainingTime seconds', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 20),
                  Text(
                    questions[_currentQuestionIndex].question,
                    style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  ...questions[_currentQuestionIndex].choices.map((choice) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: ElevatedButton(
                        onPressed: () => _answerQuestion(choice),
                        child: Text(choice),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        ),
                      ),
                    );
                  }).toList(),
                ],
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButton<String>(
                      value: _selectedCategory,
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value!;
                        });
                      },
                      items: quizModel.questionsByCategory.keys.map((String category) {
                        return DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                      isExpanded: true,
                      dropdownColor: Colors.blue[50],
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _questionController,
                      decoration: InputDecoration(
                        labelText: 'Question',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    ..._choices.asMap().entries.map((entry) {
                      int index = entry.key;
                      String choice = entry.value;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: TextEditingController(text: choice),
                                onChanged: (value) => _updateChoice(index, value),
                                decoration: InputDecoration(
                                  labelText: 'Choice ${index + 1}',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            if (index == _choices.length - 1)
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: _addChoice,
                              ),
                          ],
                        ),
                      );
                    }).toList(),
                    SizedBox(height: 10),
                    TextField(
                      controller: _answerController,
                      decoration: InputDecoration(
                        labelText: 'Correct Answer',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _explanationController,
                      decoration: InputDecoration(
                        labelText: 'Explanation',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: _addQuestion,
                        child: Text('Add Question'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: _startQuiz,
                        child: Text('Start Quiz'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text('Questions:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 200, // Set a fixed height for the list
                      child: ListView.builder(
                        itemCount: questions.length,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            child: ListTile(
                              title: Text(questions[index].question),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
