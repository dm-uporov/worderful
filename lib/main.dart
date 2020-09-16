import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:words_remember/business/WordsRepository.dart';
import 'package:words_remember/screen/home/home.dart';
import 'package:words_remember/screen/training/writing.dart';

import 'model/Word.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(WordAdapter());
  await Hive.openBox<Word>(WordsRepository.REPO_NAME);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      // routes: {
      //   '/': (context) => HomeScreen(),
      //   '/training/writing': (context) => WritingTrainingScreen(),
      // },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context) => HomeScreen());
          case '/training/writing':
            return PageRouteBuilder(
              pageBuilder: (_, __, ___) => WritingTrainingScreen(),
              transitionsBuilder: (_, anim, __, child) {
                return FadeTransition(opacity: anim, child: child);
              },
            );
          default:
            return null;
        }
      },
    );
  }
}