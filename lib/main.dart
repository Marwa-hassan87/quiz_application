import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_application/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:quiz_application/features/auth/presentation/screens/login_screen.dart';
import 'package:quiz_application/firebase_options.dart';
import 'package:quiz_application/injection_container.dart' as di;
import 'package:quiz_application/views/navbar_category_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => di.sl<AuthBloc>(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return NavbarCategoryPage(initialIndex: 0);
              } else {
                return LoginScreen();
              }
            }
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          },
        ),
      ),
    );
  }
}
