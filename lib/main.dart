import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:words_remember/business/WordsRepository.dart';
import 'package:words_remember/resources/colors.dart';
import 'package:words_remember/screen/home/home.dart';
import 'package:words_remember/screen/loading.dart';
import 'package:words_remember/screen/training/reading.dart';
import 'package:words_remember/screen/training/variants.dart';

import 'model/Word.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: cycleBlueDark,
    systemNavigationBarIconBrightness: Brightness.light,
    statusBarColor: cycleRedMain,
    statusBarIconBrightness: Brightness.light,
  ));

  runApp(App());
}

class App extends StatelessWidget {

  Future<void> _initialization() async {
    await Hive.initFlutter();
    final wordAdapter = WordAdapter();
    if (!Hive.isAdapterRegistered(wordAdapter.typeId)) {
      Hive.registerAdapter(wordAdapter);
    }
    await Hive.openBox<Word>(WordsRepository.REPO_NAME);
    await Firebase.initializeApp();
    await WordsRepository.preinitWords();

    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser == null) {
      await auth.signInAnonymously();
    } else {
      print('user id is: ${auth.currentUser.uid}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return LoadingScreen();
        }

        return MaterialApp(
          title: 'Flutter Demo',
          initialRoute: '/',
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/':
                return MaterialPageRoute(builder: (context) => HomeScreen());
              case '/training/writing':
                return PageRouteBuilder(
                  pageBuilder: (_, __, ___) => ReadingTrainingScreen(),
                  transitionsBuilder: (_, anim, __, child) {
                    return FadeTransition(opacity: anim, child: child);
                  },
                );
              case '/training/variants':
                return PageRouteBuilder(
                  pageBuilder: (_, __, ___) => VariantsTrainingScreen(),
                  transitionsBuilder: (_, anim, __, child) {
                    return FadeTransition(opacity: anim, child: child);
                  },
                );
              default:
                throw Exception('There is no screen matched to passed route `${settings.name}`');
            }
          },
        );
      },
    );
  }
}
