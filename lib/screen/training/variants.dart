import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:words_remember/business/WordsRepository.dart';
import 'package:words_remember/model/Word.dart';
import 'package:words_remember/resources/colors.dart';
import 'package:words_remember/utils/BrightIcon.dart';
import 'package:words_remember/utils/container/NeumorphicClickableContainer.dart';
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
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cycleRedMain,
        title: Text('Выбери вариант', style: TextStyle(color: solidColor)),
        iconTheme: IconThemeData(color: solidColor),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        decoration: backgroundGradientDecoration,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    isReverse ? currentWord.translate : currentWord.source,
                    style: TextStyle(
                      fontSize: 24.0,
                      color: solidColor,
                    ),
                  ),
                ),
              ),
              Column(
                children:
                    variants.map((e) => createVariantWidget(size, e)).toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 24, bottom: 32),
                    child: NeumorphicClickableContainer(
                      style: NeumorphicStyle(
                          radius: 64, blurRadius: 3, elevation: 0.1),
                      onTap: onNextClicked,
                      childBuilder: (pressProgress) {
                        return Padding(
                          padding: EdgeInsets.all(32),
                          child: BrightIcon(
                            icon: Icons.double_arrow_rounded,
                            solidColor:
                                colorByProgress(progress: pressProgress),
                            brightnessColor:
                                cycleBlueAccent.withOpacity(pressProgress),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget createVariantWidget(Size size, Word word) {
    Color color;
    bool hasShadow;
    if (chosenVariant == null) {
      color = solidColor;
      hasShadow = false;
    } else if (word == currentWord) {
      color = cycleBlueAccent;
      hasShadow = true;
    } else if (word == chosenVariant) {
      color = cycleRedAccent;
      hasShadow = true;
    } else {
      color = solidColor;
      hasShadow = false;
    }
    return Padding(
      padding: EdgeInsets.only(top: 16.0),
      child: NeumorphicSelectableContainer(
        maxUnpressedState: chosenVariant == null ? 0.0 : 0.5,
        selected: chosenVariant != null &&
            (word == chosenVariant || word == currentWord),
        childBuilder: (pressProgress) {
          return Container(
            width: size.width,
            padding: EdgeInsets.all(24.0),
            child: Text(
              isReverse ? word.source : word.translate,
              style: TextStyle(
                color: color,
                fontSize: 16,
                shadows:
                    hasShadow ? [Shadow(color: color, blurRadius: 5)] : null,
              ),
            ),
          );
        },
        style: NeumorphicStyle(
          radius: 16,
          elevation: .15,
        ),
        onSelected:
            chosenVariant == null ? () => onAnswerRequested(word) : null,
      ),
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
