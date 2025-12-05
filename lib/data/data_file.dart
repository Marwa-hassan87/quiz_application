import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> uploadQuestionsToFirebase() async {
  for (final entry in data.entries) {
    await uploadQuestions(entry.key, entry.value);
  }
}

Future<void> uploadQuestions(String field, dynamic data) async {
  await FirebaseFirestore.instance
      .collection('QuestionsSet')
      .doc(field)
      .set(data);
}

final data = {
  "Flutter": {
    "title": "Flutter",
    "image_url": "images/flutter.jpg",
    "questions": {
      "0": {
        "correctOptionKey": "3",
        "options": {
          "1": "StatelessWidget",
          "2": "StatefulWidget",
          "3": "StaticWidget",
          "4": "InheritedWidget",
        },
        "questionText": "Which of the following is NOT a valid Flutter widget?",
      },
      "1": {
        "correctOptionKey": "2",
        "options": {
          "1": "hot reload",
          "2": "cold reload",
          "3": "hot restart",
          "4": "stateful rebuild",
        },
        "questionText": "Which feature does NOT exist in Flutter?",
      },
      "2": {
        "correctOptionKey": "4",
        "options": {
          "1": "MaterialApp",
          "2": "Scaffold",
          "3": "Container",
          "4": "Application",
        },
        "questionText": "Which is NOT a Flutter widget?",
      },
      "3": {
        "correctOptionKey": "1",
        "options": {
          "1": "pubspec.yaml",
          "2": "index.html",
          "3": "main.dart",
          "4": "build.gradle",
        },
        "questionText": "Which file defines Flutter dependencies?",
      },
      "4": {
        "correctOptionKey": "3",
        "options": {"1": "Row", "2": "Column", "3": "Table", "4": "Stack"},
        "questionText":
            "Which widget arranges children in a grid-like structure?",
      },
      "5": {
        "correctOptionKey": "2",
        "options": {
          "1": "setState()",
          "2": "updateUI()",
          "3": "build()",
          "4": "initState()",
        },
        "questionText":
            "Which method does NOT exist in StatefulWidget lifecycle?",
      },
      "6": {
        "correctOptionKey": "1",
        "options": {
          "1": "Navigator.push",
          "2": "Navigator.pop",
          "3": "Navigator.forward",
          "4": "Navigator.replace",
        },
        "questionText": "Which method is used to navigate to a new screen?",
      },
      "7": {
        "correctOptionKey": "4",
        "options": {
          "1": "Expanded",
          "2": "Flexible",
          "3": "SizedBox",
          "4": "Stretch",
        },
        "questionText": "Which is NOT a valid layout widget?",
      },
      "8": {
        "correctOptionKey": "2",
        "options": {"1": "Dart", "2": "Java", "3": "C++", "4": "Kotlin"},
        "questionText": "Which language is NOT used in Flutter development?",
      },
      "9": {
        "correctOptionKey": "3",
        "options": {"1": "State", "2": "Context", "3": "Thread", "4": "Widget"},
        "questionText": "Which is NOT a Flutter concept?",
      },
    },
  },

  "Dart": {
    "title": "Dart",
    "image_url": "images/dart.jpg",
    "questions": {
      "0": {
        "correctOptionKey": "4",
        "options": {"1": "int", "2": "double", "3": "String", "4": "decimal"},
        "questionText": "Which of the following is NOT a valid Dart data type?",
      },
      "1": {
        "correctOptionKey": "1",
        "options": {
          "1": "main()",
          "2": "start()",
          "3": "run()",
          "4": "execute()",
        },
        "questionText": "Which function is the entry point of a Dart program?",
      },
      "2": {
        "correctOptionKey": "2",
        "options": {"1": "==", "2": "===", "3": "!=", "4": "<="},
        "questionText": "Which operator checks both value and type?",
      },
      "3": {
        "correctOptionKey": "3",
        "options": {"1": "List", "2": "Map", "3": "Array", "4": "Set"},
        "questionText": "Which is NOT a Dart collection type?",
      },
      "4": {
        "correctOptionKey": "1",
        "options": {"1": "final", "2": "const", "3": "var", "4": "dynamic"},
        "questionText":
            "Which keyword declares a variable that can’t be reassigned?",
      },
      "5": {
        "correctOptionKey": "2",
        "options": {"1": "async", "2": "await", "3": "future", "4": "then"},
        "questionText":
            "Which keyword pauses execution until a Future completes?",
      },
      "6": {
        "correctOptionKey": "4",
        "options": {"1": "String", "2": "int", "3": "double", "4": "char"},
        "questionText": "Which type does NOT exist in Dart?",
      },
      "7": {
        "correctOptionKey": "3",
        "options": {"1": "is", "2": "as", "3": "instanceof", "4": "new"},
        "questionText": "Which operator is NOT in Dart?",
      },
      "8": {
        "correctOptionKey": "2",
        "options": {
          "1": "List.generate",
          "2": "List.create",
          "3": "List.filled",
          "4": "List.empty",
        },
        "questionText": "Which method does NOT exist for List?",
      },
      "9": {
        "correctOptionKey": "1",
        "options": {"1": "import", "2": "include", "3": "require", "4": "use"},
        "questionText": "Which keyword is used to bring libraries in Dart?",
      },
    },
  },

  "Math": {
    "title": "Mathematics",
    "image_url": "images/math.jpg",
    "questions": {
      "0": {
        "correctOptionKey": "2",
        "options": {"1": "2", "2": "4", "3": "6", "4": "8"},
        "questionText": "What is 2 + 2?",
      },
      "1": {
        "correctOptionKey": "4",
        "options": {"1": "2", "2": "3", "3": "4", "4": "5"},
        "questionText": "What is √25?",
      },
      "2": {
        "correctOptionKey": "1",
        "options": {"1": "16", "2": "18", "3": "20", "4": "22"},
        "questionText": "What is 4 × 4?",
      },
      "3": {
        "correctOptionKey": "3",
        "options": {"1": "9", "2": "10", "3": "11", "4": "12"},
        "questionText": "What is 5 + 6?",
      },
      "4": {
        "correctOptionKey": "2",
        "options": {"1": "8", "2": "9", "3": "10", "4": "11"},
        "questionText": "What is 3²?",
      },
      "5": {
        "correctOptionKey": "1",
        "options": {"1": "7", "2": "8", "3": "9", "4": "10"},
        "questionText": "What is 14 ÷ 2?",
      },
      "6": {
        "correctOptionKey": "4",
        "options": {"1": "20", "2": "21", "3": "22", "4": "23"},
        "questionText": "What is 46 - 23?",
      },
      "7": {
        "correctOptionKey": "3",
        "options": {"1": "90°", "2": "120°", "3": "180°", "4": "270°"},
        "questionText": "What is a straight angle?",
      },
      "8": {
        "correctOptionKey": "2",
        "options": {"1": "Triangle", "2": "Square", "3": "Circle", "4": "Line"},
        "questionText": "Which shape has 4 equal sides?",
      },
      "9": {
        "correctOptionKey": "1",
        "options": {"1": "π", "2": "e", "3": "i", "4": "√"},
        "questionText": "Which symbol represents pi?",
      },
    },
  },

  "Science": {
    "title": "Science",
    "image_url": "images/science.jpg",
    "questions": {
      "0": {
        "correctOptionKey": "1",
        "options": {"1": "H2O", "2": "CO2", "3": "O2", "4": "NaCl"},
        "questionText": "What is the chemical formula of water?",
      },
      "1": {
        "correctOptionKey": "3",
        "options": {"1": "Mars", "2": "Venus", "3": "Jupiter", "4": "Mercury"},
        "questionText": "Which planet is the largest in our solar system?",
      },
      "2": {
        "correctOptionKey": "2",
        "options": {"1": "Skin", "2": "Liver", "3": "Heart", "4": "Brain"},
        "questionText": "Which organ detoxifies chemicals in the body?",
      },
      "3": {
        "correctOptionKey": "4",
        "options": {"1": "Solid", "2": "Liquid", "3": "Gas", "4": "Plasma"},
        "questionText": "Which is the fourth state of matter?",
      },
      "4": {
        "correctOptionKey": "1",
        "options": {
          "1": "Photosynthesis",
          "2": "Respiration",
          "3": "Fermentation",
          "4": "Digestion",
        },
        "questionText": "Which process produces oxygen in plants?",
      },
      "5": {
        "correctOptionKey": "3",
        "options": {"1": "Atom", "2": "Molecule", "3": "Cell", "4": "Tissue"},
        "questionText": "What is the basic unit of life?",
      },
      "6": {
        "correctOptionKey": "2",
        "options": {
          "1": "Newton",
          "2": "Einstein",
          "3": "Galileo",
          "4": "Tesla",
        },
        "questionText": "Who proposed the theory of relativity?",
      },
      "7": {
        "correctOptionKey": "4",
        "options": {"1": "Iron", "2": "Gold", "3": "Silver", "4": "Mercury"},
        "questionText": "Which element is liquid at room temperature?",
      },
      "8": {
        "correctOptionKey": "1",
        "options": {"1": "DNA", "2": "RNA", "3": "Protein", "4": "Enzyme"},
        "questionText": "Which molecule carries genetic information?",
      },
      "9": {
        "correctOptionKey": "2",
        "options": {"1": "Sun", "2": "Moon", "3": "Earth", "4": "Mars"},
        "questionText": "Which celestial body affects tides on Earth?",
      },
    },
  },
  "History": {
    "title": "History",
    "image_url": "images/history.jpg",
    "questions": {
      "0": {
        "correctOptionKey": "2",
        "options": {"1": "1940", "2": "1939", "3": "1941", "4": "1945"},
        "questionText": "In which year did World War II begin?",
      },
      "1": {
        "correctOptionKey": "4",
        "options": {
          "1": "Napoleon",
          "2": "Caesar",
          "3": "Alexander",
          "4": "Genghis Khan",
        },
        "questionText": "Who founded the Mongol Empire?",
      },
      "2": {
        "correctOptionKey": "1",
        "options": {
          "1": "Pyramids",
          "2": "Colosseum",
          "3": "Great Wall",
          "4": "Stonehenge",
        },
        "questionText": "Which ancient wonder is located in Egypt?",
      },
      "3": {
        "correctOptionKey": "3",
        "options": {"1": "USA", "2": "France", "3": "UK", "4": "Germany"},
        "questionText":
            "Which country was led by Winston Churchill during WWII?",
      },
      "4": {
        "correctOptionKey": "2",
        "options": {"1": "1490", "2": "1492", "3": "1500", "4": "1510"},
        "questionText": "In which year did Columbus discover America?",
      },
      "5": {
        "correctOptionKey": "1",
        "options": {
          "1": "Cold War",
          "2": "World War I",
          "3": "World War II",
          "4": "French Revolution",
        },
        "questionText": "Which conflict was between USA and USSR?",
      },
      "6": {
        "correctOptionKey": "3",
        "options": {"1": "Rome", "2": "Athens", "3": "Sparta", "4": "Babylon"},
        "questionText":
            "Which city-state was famous for warriors in ancient Greece?",
      },
      "7": {
        "correctOptionKey": "4",
        "options": {
          "1": "Napoleon",
          "2": "Hitler",
          "3": "Stalin",
          "4": "Mussolini",
        },
        "questionText": "Who was the fascist leader of Italy?",
      },
      "8": {
        "correctOptionKey": "2",
        "options": {
          "1": "China",
          "2": "Mesopotamia",
          "3": "India",
          "4": "Egypt",
        },
        "questionText":
            "Which civilization is known as the cradle of civilization?",
      },
      "9": {
        "correctOptionKey": "1",
        "options": {
          "1": "Berlin Wall",
          "2": "Great Wall",
          "3": "Iron Curtain",
          "4": "Wall Street",
        },
        "questionText": "Which wall symbolized division during the Cold War?",
      },
    },
  },
  "English": {
    "title": "English",
    "image_url": "images/english.jpg",
    "questions": {
      "0": {
        "correctOptionKey": "3",
        "options": {"1": "Noun", "2": "Verb", "3": "Color", "4": "Adjective"},
        "questionText": "Which of the following is NOT a part of speech?",
      },
      "1": {
        "correctOptionKey": "2",
        "options": {
          "1": "He go",
          "2": "He goes",
          "3": "He going",
          "4": "He gone",
        },
        "questionText": "Which sentence is grammatically correct?",
      },
      "2": {
        "correctOptionKey": "1",
        "options": {"1": "Quickly", "2": "Fast", "3": "Run", "4": "Slow"},
        "questionText": "Which is an adverb?",
      },
      "3": {
        "correctOptionKey": "4",
        "options": {"1": "Past", "2": "Present", "3": "Future", "4": "Color"},
        "questionText": "Which is NOT a tense in English grammar?",
      },
      "4": {
        "correctOptionKey": "2",
        "options": {"1": "Book", "2": "Books", "3": "Bookes", "4": "Bookz"},
        "questionText": "Which is the correct plural of 'Book'?",
      },
      "5": {
        "correctOptionKey": "3",
        "options": {"1": "Is", "2": "Are", "3": "Am", "4": "Be"},
        "questionText": "Which verb is used with 'I'?",
      },
      "6": {
        "correctOptionKey": "1",
        "options": {"1": "Beautiful", "2": "Run", "3": "Quickly", "4": "Play"},
        "questionText": "Which is an adjective?",
      },
      "7": {
        "correctOptionKey": "4",
        "options": {"1": "It", "2": "He", "3": "She", "4": "Car"},
        "questionText": "Which is NOT a pronoun?",
      },
      "8": {
        "correctOptionKey": "2",
        "options": {"1": "Go", "2": "Went", "3": "Going", "4": "Gone"},
        "questionText": "Which is the past tense of 'Go'?",
      },
      "9": {
        "correctOptionKey": "1",
        "options": {"1": "And", "2": "Or", "3": "But", "4": "Because"},
        "questionText": "Which is a conjunction?",
      },
    },
  },
};
