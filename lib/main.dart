import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:quiz_application/data/data_file.dart';
import 'package:quiz_application/firebase_options.dart';
import 'package:quiz_application/views/login_page.dart';
import 'package:quiz_application/views/navbar_category_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return NavbarCategoryPage(initialIndex: 0,);
            } else {
              return LoginPage();
            }
          }
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        },
      ),
    );
  }
}

// class UploadDataInFirebase extends StatelessWidget {
//   const UploadDataInFirebase({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: ElevatedButton(
//             onPressed: () {
//               uploadQuestionsToFirebase();
//             },
//             child: Text('Upload data'),
//           ),
//         ),
//       ),
//     );
//   }
// }
