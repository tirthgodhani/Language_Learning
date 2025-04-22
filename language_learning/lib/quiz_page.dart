import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestion = 0;
  int score = 0;

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'What is "Hello" in Hindi?',
      'options': ['Namaste', 'Alvida', 'Dhanyavaad', 'Shubh Raatri'],
      'correct': 0,
    },
    {
      'question': 'What is "Thank you" in Gujarati?',
      'options': ['Namaste', 'Aavjo', 'Aabhaar', 'Kem Cho'],
      'correct': 2,
    },
    {
      'question': 'How do you say "Good Morning" in Hindi?',
      'options': ['Shubh Ratri', 'Shubh Prabhat', 'Namaste', 'Dhanyavaad'],
      'correct': 1,
    },
    {
      'question': 'What is "Water" in Gujarati?',
      'options': ['Paani', 'Jal', 'Pani', 'Paṇī'],
      'correct': 2,
    },
    {
      'question': 'How do you say "Sorry" in Hindi?',
      'options': ['Maaf Kijiye', 'Dhanyavaad', 'Namaste', 'Alvida'],
      'correct': 0,
    },
    {
      'question': 'What is "Please" in Gujarati?',
      'options': ['Maaf Karo', 'Dhanyavaad', 'Krupa Kari', 'Aavjo'],
      'correct': 2,
    },
    {
      'question': 'How do you say "Goodbye" in Hindi?',
      'options': ['Namaste', 'Alvida', 'Shubh Ratri', 'Dhanyavaad'],
      'correct': 1,
    },
    {
      'question': 'What is "Food" in Gujarati?',
      'options': ['Khana', 'Bhojan', 'Khorak', 'Aahaar'],
      'correct': 2,
    },
    {
      'question': 'How do you say "Yes" in Hindi?',
      'options': ['Nahi', 'Haan', 'Theek Hai', 'Accha'],
      'correct': 1,
    },
    {
      'question': 'What is "No" in Gujarati?',
      'options': ['Na', 'Nahi', 'Naa', 'No'],
      'correct': 0,
    },
    {
      'question': 'How do you say "Welcome" in Hindi?',
      'options': ['Dhanyavaad', 'Namaste', 'Swagat Hai', 'Alvida'],
      'correct': 2,
    },
    {
      'question': 'What is "Friend" in Gujarati?',
      'options': ['Dost', 'Mitra', 'Bhai', 'Bhen'],
      'correct': 1,
    },
    {
      'question': 'How do you say "Good Night" in Hindi?',
      'options': ['Namaste', 'Alvida', 'Shubh Din', 'Shubh Ratri'],
      'correct': 3,
    },
    {
      'question': 'What is "Love" in Gujarati?',
      'options': ['Pyaar', 'Prem', 'Ishq', 'Mohabbat'],
      'correct': 1,
    },
    {
      'question': 'How do you say "Happy" in Hindi?',
      'options': ['Dukhi', 'Khush', 'Udaas', 'Gussa'],
      'correct': 1,
    },
    {
      'question': 'What is "Come" in Gujarati?',
      'options': ['Jao', 'Aavo', 'Chalo', 'Ubho'],
      'correct': 1,
    },
    {
      'question': 'How do you say "Go" in Hindi?',
      'options': ['Aao', 'Jao', 'Ruko', 'Chalo'],
      'correct': 1,
    },
    {
      'question': 'What is "Family" in Gujarati?',
      'options': ['Ghar', 'Parivar', 'Kutumb', 'Saath'],
      'correct': 2,
    },
    {
      'question': 'How do you say "House" in Hindi?',
      'options': ['Ghar', 'Makaan', 'Bhavan', 'All of these'],
      'correct': 3,
    },
    {
      'question': 'What is "Time" in Gujarati?',
      'options': ['Vakt', 'Samay', 'Ghadi', 'All of these'],
      'correct': 0,
    },
    {
      'question': 'What is the word for "Mother" in Gujarati?',
      'options': ['Maa', 'Pita', 'Ben', 'Bhai'],
      'correct': 0,
    },
    {
      'question': 'Which number is "પાંચ" in Gujarati?',
      'options': ['Three', 'Four', 'Five', 'Six'],
      'correct': 2,
    },
    {
      'question': 'What is "शुभ प्रभात" in Hindi?',
      'options': ['Good Night', 'Good Morning', 'Good Afternoon', 'Hello'],
      'correct': 1,
    },
    {
      'question': 'Translate "કેમ છો" from Gujarati to English',
      'options': ['Good Morning', 'Thank You', 'How are you?', 'Goodbye'],
      'correct': 2,
    },
    {
      'question': 'What is "Dinner" in Hindi?',
      'options': ['सुबह का खाना', 'दोपहर का खाना', 'रात का खाना', 'नाश्ता'],
      'correct': 2,
    },
    {
      'question': 'Which is the correct translation for "School" in Gujarati?',
      'options': ['શાળા', 'ઘર', 'બગીચો', 'દુકાન'],
      'correct': 0,
    },
    {
      'question': 'What does "મારું નામ" mean in English?',
      'options': ['Your name', 'My name', 'His name', 'Her name'],
      'correct': 1,
    },
    {
      'question': 'Translate "बाज़ार" from Hindi to English',
      'options': ['School', 'Home', 'Market', 'Hospital'],
      'correct': 2,
    },
  ];

  void checkAnswer(int selectedOption) {
    if (selectedOption == questions[currentQuestion]['correct']) {
      score++;
    }

    if (currentQuestion < questions.length - 1) {
      setState(() {
        currentQuestion++;
      });
    } else {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: const Text('Quiz Complete!'),
              content: Text('Your score: $score/${questions.length}'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      currentQuestion = 0;
                      score = 0;
                    });
                  },
                  child: const Text('Try Again'),
                ),
              ],
            ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.lightBlue.shade50],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    questions[currentQuestion]['question'],
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ...List.generate(
                4,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                    onPressed: () => checkAnswer(index),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue,
                      padding: const EdgeInsets.all(16),
                    ),
                    child: Text(questions[currentQuestion]['options'][index]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
