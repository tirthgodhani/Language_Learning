import 'package:flutter/material.dart';
import 'dart:math';
import 'theme/page_theme_mixin.dart';

class WordGridGame extends StatefulWidget {
  const WordGridGame({super.key});

  @override
  State<WordGridGame> createState() => _WordGridGameState();
}

class _WordGridGameState extends State<WordGridGame>
    with SingleTickerProviderStateMixin, PageThemeMixin {
  int gridSize = 4; // Changed from final to allow modification
  static const List<int> availableGridSizes = [4, 6, 8, 10];
  List<String> letters = [];
  String selectedWord = '';
  List<bool> selectedTiles = [];
  int attempts = 6;
  bool showHint = false;
  bool gameOver = false;
  bool hasWon = false;
  late String targetWord; // Add this line
  late AnimationController _cowController;
  late Animation<double> _cowAnimation;
  String currentDifficulty = 'easy'; // Add this line
  final Map<String, int> difficultyGridSize = {
    'easy': 4,
    'medium': 6,
    'hard': 8,
  };

  List<String> hints = [
    // Add this hints list
    "Words can be horizontal, vertical, or diagonal!",
    "Try looking in different directions!",
    "Follow the letters in a line!",
    "The word might be straight or slanted!",
  ];

  // Word pools categorized by difficulty
  final Map<String, List<String>> wordsByDifficulty = {
    'easy': [
      'CAT',
      'DOG',
      'COW',
      'PEN',
      'BOX',
      'SUN',
      'TEA',
      'BED',
      'HAT',
      'BAG',
      'RUN',
      'SIT',
      'EAT',
      'SEE',
      'ONE',
      'TWO',
      'RED',
      'BIG',
      'SKY',
      'DAY',
    ],
    'medium': [
      'MOTHER',
      'FATHER',
      'SISTER',
      'HOUSE',
      'WATER',
      'CLOTH',
      'TOOTH',
      'MONTH',
      'FLOWER',
      'FRUIT',
      'HAPPY',
      'SMILE',
      'BREAD',
      'SWEET',
      'LIGHT',
      'COLOR',
      'MONEY',
      'PAPER',
      'TABLE',
      'CHAIR',
    ],
    'hard': [
      'FESTIVAL',
      'MARRIAGE',
      'BLESSING',
      'TEACHER',
      'STUDENT',
      'HOLIDAY',
      'MORNING',
      'EVENING',
      'RESPECT',
      'TEMPLE',
      'VILLAGE',
      'COUNTRY',
      'CULTURE',
      'VICTORY',
      'FREEDOM',
      'FAMILY',
      'FRIEND',
      'HEALTH',
      'WEALTH',
      'FUTURE',
    ],
  };

  // Word mappings for Hindi and Gujarati
  final Map<String, Map<String, String>> wordHints = {
    // Easy words
    'CAT': {'hindi': 'बिल्ली', 'gujarati': 'બિલાડી'},
    'DOG': {'hindi': 'कुत्ता', 'gujarati': 'કૂતરો'},
    'COW': {'hindi': 'गाय', 'gujarati': 'ગાય'},
    'PEN': {'hindi': 'कलम', 'gujarati': 'પેન'},
    'BOX': {'hindi': 'डिब्बा', 'gujarati': 'બોક્સ'},
    'SUN': {'hindi': 'सूरज', 'gujarati': 'સૂર્ય'},
    'TEA': {'hindi': 'चाय', 'gujarati': 'ચા'},
    'BED': {'hindi': 'बिस्तर', 'gujarati': 'પલંગ'},
    'HAT': {'hindi': 'टोपी', 'gujarati': 'ટોપી'},
    'BAG': {'hindi': 'बैग', 'gujarati': 'બેગ'},

    // Medium words
    'MOTHER': {'hindi': 'माँ', 'gujarati': 'માં'},
    'FATHER': {'hindi': 'पिता', 'gujarati': 'પિતા'},
    'SISTER': {'hindi': 'बहन', 'gujarati': 'બહેન'},
    'HOUSE': {'hindi': 'घर', 'gujarati': 'ઘર'},
    'WATER': {'hindi': 'पानी', 'gujarati': 'પાણી'},
    'CLOTH': {'hindi': 'कपड़ा', 'gujarati': 'કપડું'},
    'TOOTH': {'hindi': 'दांत', 'gujarati': 'દાંત'},
    'MONTH': {'hindi': 'महीना', 'gujarati': 'મહિનો'},
    'FLOWER': {'hindi': 'फूल', 'gujarati': 'ફૂલ'},
    'FRUIT': {'hindi': 'फल', 'gujarati': 'ફળ'},

    // Hard words
    'FESTIVAL': {'hindi': 'त्योहार', 'gujarati': 'તહેવાર'},
    'MARRIAGE': {'hindi': 'शादी', 'gujarati': 'લગ્ન'},
    'BLESSING': {'hindi': 'आशीर्वाद', 'gujarati': 'આશીર્વાદ'},
    'TEACHER': {'hindi': 'शिक्षक', 'gujarati': 'શિક્ષક'},
    'STUDENT': {'hindi': 'विद्यार्थी', 'gujarati': 'વિદ્યાર્થી'},
    'HOLIDAY': {'hindi': 'छुट्टी', 'gujarati': 'રજા'},
    'MORNING': {'hindi': 'सुबह', 'gujarati': 'સવાર'},
    'EVENING': {'hindi': 'शाम', 'gujarati': 'સાંજ'},
    'RESPECT': {'hindi': 'सम्मान', 'gujarati': 'માન'},
    'TEMPLE': {'hindi': 'मंदिर', 'gujarati': 'મંદિર'},
  };

  @override
  void initState() {
    super.initState();
    _initializeGame();
    _setupAnimations();
  }

  void _initializeGame() {
    // Update grid size based on difficulty
    gridSize = difficultyGridSize[currentDifficulty]!;

    // Filter words based on current difficulty
    List<String> availableWords =
        wordsByDifficulty[currentDifficulty]!.where((word) {
          bool hasTranslation = wordHints.containsKey(word);
          bool fitsGrid = word.length <= gridSize * 2;
          bool appropriateLength =
              currentDifficulty == 'hard'
                  ? word.length >= 6
                  : // For hard mode, only use longer words
                  word.length >= 3; // For easy/medium, use shorter words
          return hasTranslation && fitsGrid && appropriateLength;
        }).toList();

    if (availableWords.isEmpty) {
      // If no words available, fallback to appropriate difficulty
      availableWords =
          wordsByDifficulty[currentDifficulty == 'hard' ? 'medium' : 'easy']!;
    }

    targetWord = availableWords[Random().nextInt(availableWords.length)];
    letters = _generateGrid(targetWord);
    selectedTiles = List.generate(gridSize * gridSize, (index) => false);
    attempts = gridSize <= 6 ? 6 : 8; // More attempts for larger grids
    selectedWord = '';
    gameOver = false;
    hasWon = false;
  }

  void _setupAnimations() {
    _cowController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _cowAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _cowController, curve: Curves.easeInOut),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _cowController.reverse();
      }
    });
  }

  List<String> _generateGrid(String word) {
    List<String> grid = List.filled(gridSize * gridSize, '');
    List<int> positions = [];

    // Choose random direction: 0=horizontal, 1=vertical, 2=diagonal
    int direction = Random().nextInt(3);

    // Calculate starting position based on word length and direction
    int startPos;
    do {
      switch (direction) {
        case 0: // Horizontal
          startPos =
              Random().nextInt(gridSize) * gridSize +
              Random().nextInt(gridSize - word.length + 1);
          break;
        case 1: // Vertical
          startPos =
              Random().nextInt(gridSize - word.length + 1) * gridSize +
              Random().nextInt(gridSize);
          break;
        case 2: // Diagonal
          startPos =
              Random().nextInt(gridSize - word.length + 1) * gridSize +
              Random().nextInt(gridSize - word.length + 1);
          break;
        default:
          startPos = 0;
      }
    } while (positions.contains(startPos));

    // Place word letters in chosen direction
    for (int i = 0; i < word.length; i++) {
      int pos;
      switch (direction) {
        case 0: // Horizontal
          pos = startPos + i;
          break;
        case 1: // Vertical
          pos = startPos + (i * gridSize);
          break;
        case 2: // Diagonal
          pos = startPos + (i * gridSize) + i;
          break;
        default:
          pos = startPos + i;
      }
      positions.add(pos);
      grid[pos] = word[i];
    }

    // Fill remaining spots with random letters
    for (int i = 0; i < grid.length; i++) {
      if (grid[i].isEmpty) {
        grid[i] = String.fromCharCode(65 + Random().nextInt(26));
      }
    }

    return grid;
  }

  void _handleTileTap(int index) {
    if (gameOver) return;

    setState(() {
      if (selectedTiles[index]) {
        selectedTiles[index] = false;
        selectedWord = selectedWord.replaceFirst(letters[index], '');
      } else {
        selectedTiles[index] = true;
        selectedWord += letters[index];

        if (selectedWord.length == targetWord.length) {
          _checkWord();
        }
      }
    });
  }

  void _checkWord() {
    if (selectedWord == targetWord) {
      setState(() {
        hasWon = true;
        gameOver = true;
        _showGameOverDialog('Congratulations! You found the word!');
      });
    } else {
      setState(() {
        attempts--;
        selectedWord = '';
        selectedTiles = List.generate(gridSize * gridSize, (index) => false);

        if (attempts <= 0) {
          gameOver = true;
          _showGameOverDialog('Game Over! The word was $targetWord');
        }
      });
    }
  }

  void _showHintDialog() {
    setState(() {
      showHint = true;
      _cowController.forward();
    });

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() => showHint = false);
      }
    });
  }

  String _getTranslatedHint() {
    final hindi = wordHints[targetWord]?['hindi'] ?? targetWord;
    final gujarati = wordHints[targetWord]?['gujarati'] ?? targetWord;
    return 'Find the English word for:\nहिंदी: $hindi\nગુજરાતી: $gujarati';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Theme(
      data: getTheme(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Word Grid Game'),
          backgroundColor: isDark ? Colors.grey[850] : Colors.blue,
          foregroundColor: Colors.white,
          actions: [
            PopupMenuButton<String>(
              icon: const Icon(Icons.track_changes),
              tooltip: 'Select Difficulty',
              onSelected: (difficulty) {
                setState(() {
                  currentDifficulty = difficulty;
                  _initializeGame();
                });
              },
              itemBuilder:
                  (context) => [
                    const PopupMenuItem(
                      value: 'easy',
                      child: Text('Easy (4x4)'),
                    ),
                    const PopupMenuItem(
                      value: 'medium',
                      child: Text('Medium (6x6)'),
                    ),
                    const PopupMenuItem(
                      value: 'hard',
                      child: Text('Hard (8x8)'),
                    ),
                  ],
            ),
          ],
        ),
        body: Container(
          decoration: getPageDecoration(context),
          child: buildThemedCard(
            context,
            Column(
              children: [
                // Translated hint container
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color:
                        isDark
                            ? Colors.grey[800]
                            : Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isDark ? Colors.grey[600]! : Colors.blue.shade300,
                      width: 2,
                    ),
                  ),
                  child: Text(
                    _getTranslatedHint(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      height: 1.5,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                ),

                // Attempts and difficulty info
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Attempts: $attempts',
                            style: TextStyle(
                              fontSize: 20,
                              color: isDark ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Difficulty: ${currentDifficulty.toUpperCase()}',
                            style: TextStyle(
                              fontSize: 16,
                              color: isDark ? Colors.grey[300] : Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.lightbulb_outline),
                        color: isDark ? Colors.yellow[600] : Colors.amber[700],
                        onPressed: _showHintDialog,
                      ),
                    ],
                  ),
                ),

                // Hint container
                if (showHint)
                  ScaleTransition(
                    scale: _cowAnimation,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.grey[800] : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color:
                              isDark ? Colors.grey[600]! : Colors.transparent,
                        ),
                      ),
                      child: Row(
                        children: [
                          const Text('🐮', style: TextStyle(fontSize: 32)),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              hints[Random().nextInt(hints.length)],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                // Grid tiles
                Expanded(
                  child: SingleChildScrollView(
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(16),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: gridSize,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: letters.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => _handleTileTap(index),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              color:
                                  selectedTiles[index]
                                      ? (isDark
                                          ? Colors.green[700]
                                          : Colors.green.withOpacity(0.7))
                                      : (isDark
                                          ? Colors.grey[800]
                                          : Colors.white.withOpacity(0.9)),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color:
                                    isDark
                                        ? Colors.grey[700]!
                                        : Colors.transparent,
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(
                                    isDark ? 0.3 : 0.2,
                                  ),
                                  blurRadius: isDark ? 2 : 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                letters[index],
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      selectedTiles[index]
                                          ? Colors.white
                                          : (isDark
                                              ? Colors.white
                                              : Colors.blue.shade900),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Selected word container
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color:
                        isDark
                            ? Colors.grey[800]
                            : Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isDark ? Colors.grey[600]! : Colors.transparent,
                    ),
                  ),
                  child: Text(
                    selectedWord.isEmpty
                        ? 'Select letters to form a word'
                        : selectedWord,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showGameOverDialog(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            title: Text(hasWon ? '🎉 Victory!' : '😔 Game Over'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() => _initializeGame());
                },
                child: const Text('Play Again'),
              ),
            ],
          ),
    );
  }

  @override
  void dispose() {
    _cowController.dispose();
    super.dispose();
  }
}
