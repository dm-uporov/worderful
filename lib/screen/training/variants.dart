import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:words_remember/business/WordsRepository.dart';
import 'package:words_remember/model/Word.dart';
import 'package:words_remember/resources/colors.dart';
import 'package:words_remember/utils/BrightIcon.dart';
import 'package:words_remember/utils/container/NeumorphicContainer.dart';
import 'dart:math';

import 'package:words_remember/utils/container/NeumorphicSelectableContainer.dart';

class VariantsTrainingScreen extends StatefulWidget {
  @override
  _VariantsTrainingScreenState createState() => _VariantsTrainingScreenState();
}

class _VariantsTrainingScreenState extends State<VariantsTrainingScreen> {
  List<Word> words;
  Random random;
  Word currentWord;
  List<Word> variants;

  final TextEditingController _controller = TextEditingController();

  Word chosenVariant;
  bool isReverse = false;

  @override
  void initState() {
    super.initState();
    words = WordsRepository.getWords();
    random = Random.secure();
    initRandomWord();
    initVariants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cycleRedMain,
        title: Text('Выбери вариант', style: TextStyle(color: solidColor)),
        iconTheme: IconThemeData(color: solidColor),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: backgroundGradientDecoration,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              isReverse ? currentWord.translate : currentWord.source,
              style: TextStyle(fontSize: 22.0, color: solidColor),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      createVariantWidget(variants[0]),
                      Padding(padding: EdgeInsets.only(left: 8)),
                      createVariantWidget(variants[1])
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 8)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      createVariantWidget(variants[2]),
                      Padding(padding: EdgeInsets.only(left: 8)),
                      createVariantWidget(variants[3])
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget createVariantWidget(Word word) {
    Color color;
    if (chosenVariant == null) {
      color = solidColor;
    } else if (word == currentWord) {
      color = Colors.lightGreen;
    } else if (word == chosenVariant) {
      color = Colors.red;
    } else {
      color = solidColor;
    }
    return NeumorphicSelectableContainer(
      selected: chosenVariant != null &&
          (word == chosenVariant || word == currentWord),
      childBuilder: (pressProgress) {
        return Padding(
          padding: EdgeInsets.all(32.0),
          child: Text(
            isReverse ? word.source : word.translate,
            style: TextStyle(color: color),
          ),
        );
      },
      style: NeumorphicStyle(
        radius: 16,
        elevation: .15,
      ),
      onSelected: () {
        if (chosenVariant == null) {
          onAnswerRequested(word);
        } else {
          onNextClicked();
        }
      },
    );
  }

  void initRandomWord() {
    currentWord = getRandomWord(except: [currentWord]);
  }

  void initVariants() {
    variants = randomThreeWordsAndRightOne();
  }

  Word getRandomWord({List<Word> except = const []}) {
    final length = words.length;

    if (length <= except.length) throw Exception('Have not enough words');

    if (length == 1) return words.first;

    final lastWords =
        words.where((element) => !except.contains(element)).toList();

    lastWords.shuffle();

    if (lastWords.length == 1) return lastWords.first;

    // check on word length
    if (currentWord != null) {
      final currentWordLength = currentWord.source.length;
      for (int i = 0; i < lastWords.length; i++) {
        final candidate = lastWords[i];
        final candidateLength = candidate.source.length;
        if (currentWordLength - 1 <= candidateLength &&
            candidateLength <= currentWordLength + 1) {
          return candidate;
        }
      }
    }

    return lastWords[random.nextInt(words.length)];
  }

  List<Word> randomThreeWordsAndRightOne() {
    final words = [currentWord];
    for (int i = 0; i < 3; i++) {
      words.add(getRandomWord(except: words));
    }
    words.shuffle();
    return words;
  }

  void onAnswerRequested(Word chosen) {
    setState(() {
      chosenVariant = chosen;
    });
  }

  void onNextClicked() {
    setState(() {
      isReverse = random.nextBool();
      chosenVariant = null;
      initRandomWord();
      initVariants();
      _controller.clear();
    });
  }

  Offset getPositionByKey(GlobalKey key) {
    final RenderBox renderBox = key.currentContext.findRenderObject();
    return renderBox.localToGlobal(Offset(renderBox.size.width / 2, -68));
  }
}
