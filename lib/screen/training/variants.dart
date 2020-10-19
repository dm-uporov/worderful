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
import 'package:words_remember/utils/words.dart';

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
                    textAlign: TextAlign.center,
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
    currentWord = words
        .getRandomNWords(
          random: random,
          filter: exceptFilterFunction([currentWord]),
        )
        .first;
  }

  void initVariants() {
    variants = randomThreeWordsAndRightOne();
  }

  List<Word> randomThreeWordsAndRightOne() {
    final currentWordSource = currentWord.source;
    final currentWordLength = currentWordSource.length;

    final variants = words.getRandomNWords(
      random: random,
      count: 3,
      filter: exceptFilterFunction([currentWord]),
      funnelOfCriteria: [
        wordLengthCriterion(
          lengthFrom: currentWordLength - 3,
          lengthTo: currentWordLength + 3,
        ),
        wordStartsWithCriterion(currentWordSource.substring(0, 1)),
        wordLengthCriterion(
          lengthFrom: currentWordLength - 2,
          lengthTo: currentWordLength + 2,
        ),
        wordStartsWithCriterion(currentWordSource.substring(0, 2)),
        wordLengthCriterion(
          lengthFrom: currentWordLength - 1,
          lengthTo: currentWordLength + 1,
        ),
        wordStartsWithCriterion(currentWordSource.substring(0, 3)),
        wordEndsWithCriterion(currentWordSource.substring(0, 1)),
        wordEndsWithCriterion(currentWordSource.substring(0, 2)),
        wordStartsWithCriterion(currentWordSource.substring(0, 4)),
        wordEndsWithCriterion(currentWordSource.substring(0, 3)),
      ],
    );
    variants.add(currentWord);
    variants.shuffle();
    return variants;
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
