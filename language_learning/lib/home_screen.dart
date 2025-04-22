import 'package:flutter/material.dart';
import '../models/language.dart';
import 'language_detail_page.dart';
import 'quiz_page.dart';
import 'translator_page.dart';
import 'lessons_page.dart'; // Add this import
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  Future<void> _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      // Navigate to login screen and remove all previous routes
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Logout failed: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  final List<Language> languages = [
    Language(
      name: 'Gujarati',
      imageUrl: Icons.language,
      chapters: [
        Chapter(
          title: 'Basics',
          description: 'Learn basic Gujarati alphabets',
          content: ChapterContent(
            title: 'ગુજરાતી મૂળાક્ષરો (Gujarati Alphabets)',
            items: [
              ContentItem(
                character: 'અ',
                pronunciation: 'a',
                example: 'અનાર (Pomegranate)',
                usageTips: [
                  'Start from the top curve',
                  'Practice the connecting line',
                ],
                writingOrder: 'Start from top, curve down and right',
              ),
              ContentItem(
                character: 'આ',
                pronunciation: 'aa',
                example: 'આંબો (Mango)',
              ),
              ContentItem(
                character: 'ઇ',
                pronunciation: 'i',
                example: 'ઇયળ (Caterpillar)',
              ),
              ContentItem(
                character: 'ઈ',
                pronunciation: 'ee',
                example: 'ઈંડું (Egg)',
              ),
              ContentItem(
                character: 'ઉ',
                pronunciation: 'u',
                example: 'ઉંદર (Mouse)',
              ),
              ContentItem(
                character: 'ઊ',
                pronunciation: 'oo',
                example: 'ઊન (Wool)',
              ),
              ContentItem(
                character: 'એ',
                pronunciation: 'e',
                example: 'એલચી (Cardamom)',
              ),
              ContentItem(
                character: 'ઐ',
                pronunciation: 'ai',
                example: 'ઐરાવત (Airavata)',
              ),
              ContentItem(
                character: 'ઓ',
                pronunciation: 'o',
                example: 'ઓછું (Less)',
              ),
              ContentItem(
                character: 'ઔ',
                pronunciation: 'au',
                example: 'ઔષધ (Medicine)',
              ),
            ],
          ),
        ),
        Chapter(
          title: 'Numbers',
          description: 'Learn numbers in Gujarati',
          content: ChapterContent(
            title: 'ગુજરાતી અંકો (Gujarati Numbers)',
            items: [
              ContentItem(
                character: '૧',
                pronunciation: 'Ek',
                example: 'One - પહેલું',
              ),
              ContentItem(
                character: '૨',
                pronunciation: 'Be',
                example: 'Two - બીજું',
              ),
              ContentItem(
                character: '૩',
                pronunciation: 'Tran',
                example: 'Three - ત્રીજું',
              ),
              ContentItem(
                character: '૪',
                pronunciation: 'Char',
                example: 'Four - ચોથું',
              ),
              ContentItem(
                character: '૫',
                pronunciation: 'Panch',
                example: 'Five - પાંચમું',
              ),
              ContentItem(
                character: '૬',
                pronunciation: 'Chha',
                example: 'Six - છઠ્ઠું',
              ),
              ContentItem(
                character: '૭',
                pronunciation: 'Saat',
                example: 'Seven - સાતમું',
              ),
              ContentItem(
                character: '૮',
                pronunciation: 'Aath',
                example: 'Eight - આઠમું',
              ),
              ContentItem(
                character: '૯',
                pronunciation: 'Nav',
                example: 'Nine - નવમું',
              ),
              ContentItem(
                character: '૧૦',
                pronunciation: 'Das',
                example: 'Ten - દસમું',
              ),
            ],
          ),
        ),
        Chapter(
          title: 'Greetings',
          description: 'Common greetings and phrases',
          content: ChapterContent(
            title: 'ગુજરાતી અભિવાદન (Gujarati Greetings)',
            items: [
              ContentItem(
                character: 'નમસ્તે',
                pronunciation: 'Namaste',
                example: 'Hello (Formal)',
              ),
              ContentItem(
                character: 'કેમ છો?',
                pronunciation: 'Kem Chho?',
                example: 'How are you?',
              ),
              ContentItem(
                character: 'સારું છું',
                pronunciation: 'Saru Chhu',
                example: 'I am fine',
              ),
              ContentItem(
                character: 'આવજો',
                pronunciation: 'Aavjo',
                example: 'Goodbye',
              ),
              ContentItem(
                character: 'શુભ સવાર',
                pronunciation: 'Shubh Savar',
                example: 'Good Morning',
              ),
              ContentItem(
                character: 'શુભ રાત્રી',
                pronunciation: 'Shubh Ratri',
                example: 'Good Night',
              ),
              ContentItem(
                character: 'આભાર',
                pronunciation: 'Aabhar',
                example: 'Thank you',
              ),
              ContentItem(
                character: 'માફ કરજો',
                pronunciation: 'Maaf Karjo',
                example: 'Sorry',
              ),
            ],
          ),
        ),
        Chapter(
          title: 'Common Phrases',
          description: 'Essential everyday phrases',
          content: ChapterContent(
            title: 'રોજિંદા વાક્યો (Daily Phrases)',
            items: [
              ContentItem(
                character: 'તમારું નામ શું છે?',
                pronunciation: 'Tamaru naam shu chhe?',
                example: 'What is your name?',
              ),
              ContentItem(
                character: 'મારું નામ ... છે',
                pronunciation: 'Maru naam ... chhe',
                example: 'My name is ...',
              ),
              ContentItem(
                character: 'મને સમજાતું નથી',
                pronunciation: 'Mane samjatu nathi',
                example: 'I don\'t understand',
              ),
              ContentItem(
                character: 'ધીમે બોલો',
                pronunciation: 'Dhime bolo',
                example: 'Please speak slowly',
              ),
            ],
          ),
        ),
        Chapter(
          title: 'Food & Drinks',
          description: 'Learn food and drink related words',
          content: ChapterContent(
            title: 'ખોરાક અને પીણાં (Food & Drinks)',
            items: [
              ContentItem(
                character: 'પાણી',
                pronunciation: 'Paani',
                example: 'Water',
              ),
              ContentItem(
                character: 'ચા',
                pronunciation: 'Chaa',
                example: 'Tea',
              ),
              ContentItem(
                character: 'રોટલી',
                pronunciation: 'Rotli',
                example: 'Flatbread',
              ),
              ContentItem(
                character: 'શાક',
                pronunciation: 'Shaak',
                example: 'Vegetable curry',
              ),
              ContentItem(
                character: 'દાળ',
                pronunciation: 'Daal',
                example: 'Lentils',
              ),
              ContentItem(
                character: 'ભાત',
                pronunciation: 'Bhaat',
                example: 'Rice',
              ),
            ],
          ),
        ),
        Chapter(
          title: 'Family Members',
          description: 'Learn family relation terms',
          content: ChapterContent(
            title: 'કુટુંબના સભ્યો (Family Members)',
            items: [
              ContentItem(
                character: 'માતા',
                pronunciation: 'Mata',
                example: 'Mother',
              ),
              ContentItem(
                character: 'પિતા',
                pronunciation: 'Pita',
                example: 'Father',
              ),
              ContentItem(
                character: 'ભાઈ',
                pronunciation: 'Bhai',
                example: 'Brother',
              ),
              ContentItem(
                character: 'બહેન',
                pronunciation: 'Bahen',
                example: 'Sister',
              ),
              ContentItem(
                character: 'દાદા',
                pronunciation: 'Dada',
                example: 'Grandfather',
              ),
              ContentItem(
                character: 'દાદી',
                pronunciation: 'Dadi',
                example: 'Grandmother',
              ),
            ],
          ),
        ),
        Chapter(
          title: 'Colors',
          description: 'Learn color names',
          content: ChapterContent(
            title: 'રંગો (Colors)',
            items: [
              ContentItem(
                character: 'લાલ',
                pronunciation: 'Lal',
                example: 'Red',
              ),
              ContentItem(
                character: 'પીળો',
                pronunciation: 'Pilo',
                example: 'Yellow',
              ),
              ContentItem(
                character: 'વાદળી',
                pronunciation: 'Vadli',
                example: 'Blue',
              ),
              ContentItem(
                character: 'લીલો',
                pronunciation: 'Lilo',
                example: 'Green',
              ),
            ],
          ),
        ),
        Chapter(
          title: 'Days & Months',
          description: 'Learn days and months',
          content: ChapterContent(
            title: 'વાર અને મહિના (Days & Months)',
            items: [
              // Days
              ContentItem(
                character: 'સોમવાર',
                pronunciation: 'Somvar',
                example: 'Monday',
              ),
              ContentItem(
                character: 'મંગળવાર',
                pronunciation: 'Mangalvar',
                example: 'Tuesday',
              ),
              ContentItem(
                character: 'બુધવાર',
                pronunciation: 'Budhvar',
                example: 'Wednesday',
              ),
              ContentItem(
                character: 'ગુરુવાર',
                pronunciation: 'Guruvar',
                example: 'Thursday',
              ),
              ContentItem(
                character: 'શુક્રવાર',
                pronunciation: 'Shukravar',
                example: 'Friday',
              ),
              ContentItem(
                character: 'શનિવાર',
                pronunciation: 'Shanivar',
                example: 'Saturday',
              ),
              ContentItem(
                character: 'રવિવાર',
                pronunciation: 'Ravivar',
                example: 'Sunday',
              ),
              // Months
              ContentItem(
                character: 'જાન્યુઆરી',
                pronunciation: 'January',
                example: 'First month',
              ),
              ContentItem(
                character: 'ફેબ્રુઆરી',
                pronunciation: 'February',
                example: 'Second month',
              ),
              ContentItem(
                character: 'માર્ચ',
                pronunciation: 'March',
                example: 'Third month',
              ),
              ContentItem(
                character: 'એપ્રિલ',
                pronunciation: 'April',
                example: 'Fourth month',
              ),
              ContentItem(
                character: 'મે',
                pronunciation: 'May',
                example: 'Fifth month',
              ),
              ContentItem(
                character: 'જૂન',
                pronunciation: 'June',
                example: 'Sixth month',
              ),
              ContentItem(
                character: 'જુલાઈ',
                pronunciation: 'July',
                example: 'Seventh month',
              ),
              ContentItem(
                character: 'ઓગસ્ટ',
                pronunciation: 'August',
                example: 'Eighth month',
              ),
              ContentItem(
                character: 'સપ્ટેમ્બર',
                pronunciation: 'September',
                example: 'Ninth month',
              ),
              ContentItem(
                character: 'ઓક્ટોબર',
                pronunciation: 'October',
                example: 'Tenth month',
              ),
              ContentItem(
                character: 'નવેમ્બર',
                pronunciation: 'November',
                example: 'Eleventh month',
              ),
              ContentItem(
                character: 'ડિસેમ્બર',
                pronunciation: 'December',
                example: 'Twelfth month',
              ),
            ],
          ),
        ),
      ],
    ),
    Language(
      name: 'Hindi',
      imageUrl: Icons.translate,
      chapters: [
        Chapter(
          title: 'Basics',
          description: 'Learn basic Hindi alphabets',
          content: ChapterContent(
            title: 'हिंदी वर्णमाला (Hindi Alphabets)',
            items: [
              ContentItem(
                character: 'अ',
                pronunciation: 'a',
                example: 'अनार (Pomegranate)',
              ),
              ContentItem(
                character: 'आ',
                pronunciation: 'aa',
                example: 'आम (Mango)',
              ),
              // Add more Hindi alphabets
            ],
          ),
        ),
        Chapter(
          title: 'Numbers',
          description: 'Learn numbers in Hindi',
          content: ChapterContent(
            title: 'हिंदी अंक (Hindi Numbers)',
            items: [
              ContentItem(character: '१', pronunciation: 'Ek', example: 'One'),
              ContentItem(character: '२', pronunciation: 'Do', example: 'Two'),
              // Add more numbers
            ],
          ),
        ),
        Chapter(
          title: 'Greetings',
          description: 'Common greetings',
          content: ChapterContent(
            title: 'हिंदी अभिवादन (Hindi Greetings)',
            items: [
              ContentItem(
                character: 'नमस्ते',
                pronunciation: 'Namaste',
                example: 'Hello',
              ),
              ContentItem(
                character: 'अलविदा',
                pronunciation: 'Alvida',
                example: 'Goodbye',
              ),
              // Add more greetings
            ],
          ),
        ),
        Chapter(
          title: 'Common Phrases',
          description: 'Essential everyday phrases',
          content: ChapterContent(
            title: 'दैनिक वाक्य (Daily Phrases)',
            items: [
              ContentItem(
                character: 'आपका नाम क्या है?',
                pronunciation: 'Aapka naam kya hai?',
                example: 'What is your name?',
              ),
              // ...more phrases...
            ],
          ),
        ),
        Chapter(
          title: 'Food & Drinks',
          description: 'Learn food and drink related words',
          content: ChapterContent(
            title: 'खाना और पीना (Food & Drinks)',
            items: [
              ContentItem(
                character: 'पानी',
                pronunciation: 'Paani',
                example: 'Water',
              ),
              // ...more food items...
            ],
          ),
        ),
        Chapter(
          title: 'Family Members',
          description: 'Learn family relation terms',
          content: ChapterContent(
            title: 'परिवार के सदस्य (Family Members)',
            items: [
              ContentItem(
                character: 'माता',
                pronunciation: 'Mata',
                example: 'Mother',
              ),
              // ...more family members...
            ],
          ),
        ),
        Chapter(
          title: 'Colors',
          description: 'Learn color names',
          content: ChapterContent(
            title: 'रंग (Colors)',
            items: [
              ContentItem(
                character: 'लाल',
                pronunciation: 'Laal',
                example: 'Red',
              ),
              // ...more colors...
            ],
          ),
        ),
        Chapter(
          title: 'Days & Months',
          description: 'Learn days and months',
          content: ChapterContent(
            title: 'दिन और महीने (Days & Months)',
            items: [
              // Days
              ContentItem(
                character: 'सोमवार',
                pronunciation: 'Somvaar',
                example: 'Monday',
              ),
              ContentItem(
                character: 'मंगलवार',
                pronunciation: 'Mangalvaar',
                example: 'Tuesday',
              ),
              ContentItem(
                character: 'बुधवार',
                pronunciation: 'Budhvaar',
                example: 'Wednesday',
              ),
              ContentItem(
                character: 'गुरुवार',
                pronunciation: 'Guruvaar',
                example: 'Thursday',
              ),
              ContentItem(
                character: 'शुक्रवार',
                pronunciation: 'Shukravaar',
                example: 'Friday',
              ),
              ContentItem(
                character: 'शनिवार',
                pronunciation: 'Shanivaar',
                example: 'Saturday',
              ),
              ContentItem(
                character: 'रविवार',
                pronunciation: 'Ravivaar',
                example: 'Sunday',
              ),
              // Months
              ContentItem(
                character: 'जनवरी',
                pronunciation: 'January',
                example: 'First month',
              ),
              ContentItem(
                character: 'फरवरी',
                pronunciation: 'February',
                example: 'Second month',
              ),
              ContentItem(
                character: 'मार्च',
                pronunciation: 'March',
                example: 'Third month',
              ),
              ContentItem(
                character: 'अप्रैल',
                pronunciation: 'April',
                example: 'Fourth month',
              ),
              ContentItem(
                character: 'मई',
                pronunciation: 'May',
                example: 'Fifth month',
              ),
              ContentItem(
                character: 'जून',
                pronunciation: 'June',
                example: 'Sixth month',
              ),
              ContentItem(
                character: 'जुलाई',
                pronunciation: 'July',
                example: 'Seventh month',
              ),
              ContentItem(
                character: 'अगस्त',
                pronunciation: 'August',
                example: 'Eighth month',
              ),
              ContentItem(
                character: 'सितंबर',
                pronunciation: 'September',
                example: 'Ninth month',
              ),
              ContentItem(
                character: 'अक्टूबर',
                pronunciation: 'October',
                example: 'Tenth month',
              ),
              ContentItem(
                character: 'नवंबर',
                pronunciation: 'November',
                example: 'Eleventh month',
              ),
              ContentItem(
                character: 'दिसंबर',
                pronunciation: 'December',
                example: 'Twelfth month',
              ),
            ],
          ),
        ),
      ],
    ),
    Language(
      name: 'English',
      imageUrl: Icons.abc,
      chapters: [
        Chapter(
          title: 'Basics',
          description: 'Learn basic English alphabets',
          content: ChapterContent(
            title: 'English Alphabets',
            items: [
              ContentItem(
                character: 'A',
                pronunciation: 'ay',
                example: 'Apple',
              ),
              ContentItem(
                character: 'B',
                pronunciation: 'bee',
                example: 'Ball',
              ),
              // Add more English alphabets
            ],
          ),
        ),
        Chapter(
          title: 'Numbers',
          description: 'Learn numbers in English',
          content: ChapterContent(
            title: 'English Numbers',
            items: [
              ContentItem(
                character: '1',
                pronunciation: 'One',
                example: 'First',
              ),
              ContentItem(
                character: '2',
                pronunciation: 'Two',
                example: 'Second',
              ),
              // Add more numbers
            ],
          ),
        ),
        Chapter(
          title: 'Greetings',
          description: 'Common greetings',
          content: ChapterContent(
            title: 'English Greetings',
            items: [
              ContentItem(
                character: 'Hello',
                pronunciation: 'heh-loh',
                example: 'Hi/Hey',
              ),
              ContentItem(
                character: 'Goodbye',
                pronunciation: 'good-bahy',
                example: 'Bye/See you',
              ),
              // Add more greetings
            ],
          ),
        ),
        Chapter(
          title: 'Common Phrases',
          description: 'Essential everyday phrases',
          content: ChapterContent(
            title: 'Daily Phrases',
            items: [
              ContentItem(
                character: 'What is your name?',
                pronunciation: 'what-iz-yor-naym',
                example: 'Asking someone\'s name',
              ),
              // ...more phrases...
            ],
          ),
        ),
        Chapter(
          title: 'Food & Drinks',
          description: 'Learn food and drink related words',
          content: ChapterContent(
            title: 'Food & Drinks',
            items: [
              ContentItem(
                character: 'Water',
                pronunciation: 'waw-ter',
                example: 'H2O / Drinking water',
              ),
              // ...more food items...
            ],
          ),
        ),
        Chapter(
          title: 'Family Members',
          description: 'Learn family relation terms',
          content: ChapterContent(
            title: 'Family Members',
            items: [
              ContentItem(
                character: 'Mother',
                pronunciation: 'muh-ther',
                example: 'Female parent',
              ),
              // ...more family members...
            ],
          ),
        ),
        Chapter(
          title: 'Colors',
          description: 'Learn color names',
          content: ChapterContent(
            title: 'Colors',
            items: [
              ContentItem(
                character: 'Red',
                pronunciation: 'red',
                example: 'Color of blood',
              ),
              // ...more colors...
            ],
          ),
        ),
        Chapter(
          title: 'Days & Months',
          description: 'Learn days and months',
          content: ChapterContent(
            title: 'Days & Months',
            items: [
              // Days
              ContentItem(
                character: 'Monday',
                pronunciation: 'muhn-dey',
                example: 'First day of the week',
              ),
              ContentItem(
                character: 'Tuesday',
                pronunciation: 'tooz-dey',
                example: 'Second day of the week',
              ),
              ContentItem(
                character: 'Wednesday',
                pronunciation: 'wenz-dey',
                example: 'Third day of the week',
              ),
              ContentItem(
                character: 'Thursday',
                pronunciation: 'thurz-dey',
                example: 'Fourth day of the week',
              ),
              ContentItem(
                character: 'Friday',
                pronunciation: 'fry-dey',
                example: 'Fifth day of the week',
              ),
              ContentItem(
                character: 'Saturday',
                pronunciation: 'sa-tur-dey',
                example: 'Sixth day of the week',
              ),
              ContentItem(
                character: 'Sunday',
                pronunciation: 'suhn-dey',
                example: 'Seventh day of the week',
              ),
              // Months
              ContentItem(
                character: 'January',
                pronunciation: 'jan-yoo-eh-ree',
                example: 'First month',
              ),
              ContentItem(
                character: 'February',
                pronunciation: 'feb-roo-eh-ree',
                example: 'Second month',
              ),
              ContentItem(
                character: 'March',
                pronunciation: 'maarch',
                example: 'Third month',
              ),
              ContentItem(
                character: 'April',
                pronunciation: 'ey-pruhl',
                example: 'Fourth month',
              ),
              ContentItem(
                character: 'May',
                pronunciation: 'mey',
                example: 'Fifth month',
              ),
              ContentItem(
                character: 'June',
                pronunciation: 'joon',
                example: 'Sixth month',
              ),
              ContentItem(
                character: 'July',
                pronunciation: 'juh-ly',
                example: 'Seventh month',
              ),
              ContentItem(
                character: 'August',
                pronunciation: 'aw-guhst',
                example: 'Eighth month',
              ),
              ContentItem(
                character: 'September',
                pronunciation: 'sep-tem-ber',
                example: 'Ninth month',
              ),
              ContentItem(
                character: 'October',
                pronunciation: 'ok-toh-ber',
                example: 'Tenth month',
              ),
              ContentItem(
                character: 'November',
                pronunciation: 'noh-vem-ber',
                example: 'Eleventh month',
              ),
              ContentItem(
                character: 'December',
                pronunciation: 'dee-sem-ber',
                example: 'Twelfth month',
              ),
            ],
          ),
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Language Learning'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade50, Colors.blue.shade50],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'Available Languages',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children:
                  languages
                      .map((lang) => LanguageCard(language: lang))
                      .toList(),
            ),
            const SizedBox(height: 32),
            Text(
              'Learning Tools',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                FeatureCard(
                  title: 'Quiz',
                  icon: Icons.quiz,
                  color: Colors.orange,
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const QuizPage(),
                        ),
                      ),
                ),
                FeatureCard(
                  title: 'Translator',
                  icon: Icons.translate,
                  color: Colors.green,
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TranslatorPage(),
                        ),
                      ),
                ),
                FeatureCard(
                  title: 'Flash Cards',
                  icon: Icons.flip,
                  color: Colors.indigo,
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => const FlashCardPage(
                                language: 'hindi',
                                category: 'basics',
                              ),
                        ),
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const FeatureCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: color),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LanguageCard extends StatelessWidget {
  final Language language;
  final Map<String, Color> languageColors = {
    'Gujarati': Colors.blue,
    'Hindi': Colors.blue,
    'English': Colors.blue,
  };

  LanguageCard({super.key, required this.language});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LanguageDetailPage(language: language),
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              language.imageUrl as IconData, // Cast to IconData
              size: 48,
              color: languageColors[language.name] ?? Colors.purple,
            ),
            const SizedBox(height: 8),
            Text(
              language.name,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: languageColors[language.name] ?? Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: LinearProgressIndicator(
                value: language.progress,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(
                  languageColors[language.name] ?? Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
