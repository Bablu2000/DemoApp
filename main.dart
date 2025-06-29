import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

// Home Page
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen.shade100,
      appBar: AppBar(
        title: Text('Welcome to Quiz App'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'কুইজ অ্যাপ',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QuizPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  backgroundColor: Colors.green,
                ),
                child: Text(
                  'Start Quiz',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Quiz Page
class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class Question {
  final String question;
  final List<String> options;
  final int correctIndex;

  Question({
    required this.question,
    required this.options,
    required this.correctIndex,
  });
}

class _QuizPageState extends State<QuizPage> {
  final List<Question> _questions = [
    Question(
      question: 'What is the capital of France?',
      options: ['Berlin', 'London', 'Paris', 'Rome'],
      correctIndex: 2,
    ),
    Question(
      question: 'Which planet is known as the Red Planet?',
      options: ['Earth', 'Mars', 'Jupiter', 'Venus'],
      correctIndex: 1,
    ),
    Question(
      question: 'Who wrote "Hamlet"?',
      options: ['Charles Dickens', 'William Shakespeare', 'Mark Twain', 'J.K. Rowling'],
      correctIndex: 1,
    ),
    Question(
      question: 'What is the largest ocean on Earth?',
      options: ['Atlantic', 'Indian', 'Arctic', 'Pacific'],
      correctIndex: 3,
    ),
    Question(
      question: 'What is the boiling point of water?',
      options: ['100°C', '50°C', '150°C', '200°C'],
      correctIndex: 0,
    ),
  ];

  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _quizFinished = false;

  void _answerQuestion(int selectedIndex) {
    if (!_quizFinished) {
      if (selectedIndex == _questions[_currentQuestionIndex].correctIndex) {
        _score++;
      }

      setState(() {
        _currentQuestionIndex++;
        if (_currentQuestionIndex >= _questions.length) {
          _quizFinished = true;
        }
      });
    }
  }

  void _restartQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _score = 0;
      _quizFinished = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: Text('Quiz Time!'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _quizFinished
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Your Score: $_score / ${_questions.length}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _restartQuiz,
                child: Text('Restart Quiz'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Back to Home'),
              ),
            ],
          ),
        )
            : Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Question ${_currentQuestionIndex + 1}/${_questions.length}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 16),
            Text(
              _questions[_currentQuestionIndex].question,
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 20),
            ..._questions[_currentQuestionIndex].options
                .asMap()
                .entries
                .map(
                  (entry) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: ElevatedButton(
                  onPressed: () => _answerQuestion(entry.key),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(16),
                  ),
                  child: Text(entry.value),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
