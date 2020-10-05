import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:words_remember/business/WordsRepository.dart';
import 'package:words_remember/model/Word.dart';
import 'package:words_remember/resources/colors.dart';
import 'package:words_remember/utils/BrightIcon.dart';
import 'package:words_remember/utils/container/NeumorphicClickableContainer.dart';
import 'package:words_remember/utils/container/NeumorphicContainer.dart';
import 'dart:math';

class ReadingTrainingScreen extends StatefulWidget {
  @override
  _ReadingTrainingScreenState createState() => _ReadingTrainingScreenState();
}

class _ReadingTrainingScreenState extends State<ReadingTrainingScreen> {
  List<Word> words;
  Random random;
  Word currentWord;

  int _lastWordIndex;

  final TextEditingController _controller = TextEditingController();

  String _hint = '';

  bool _isAnswerHidden = true;
  bool _isReverse = false;

  final GlobalKey buttonKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    words = WordsRepository.getWords();
    random = Random.secure();
    _initRandomWord();
  }

  void _initRandomWord() {
    switch (words.length) {
      case 0:
        // TODO check state when no words
        throw Exception('no words');
        break;
      case 1:
        currentWord = words.first;
        break;
      default:
        int wordIndex = random.nextInt(words.length);
        while (wordIndex == _lastWordIndex) {
          wordIndex = random.nextInt(words.length);
        }
        _lastWordIndex = wordIndex;
        currentWord = words[wordIndex];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cycleRedMain,
        title: Text('Проверь себя'),
      ),
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(decoration: backgroundGradientDecoration),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _isReverse ? currentWord.translate : currentWord.source,
                style: TextStyle(fontSize: 22.0, color: solidColor),
              ),
              Padding(padding: EdgeInsets.only(top: 48)),
              Text(
                _hint,
                style: TextStyle(fontSize: 22.0, color: lighten(solidColor)),
              ),
            ],
          ),
          Positioned(
            bottom: 32,
            child: NeumorphicClickableContainer(
              key: buttonKey,
              childBuilder: (pressProgress) {
                return Padding(
                  padding: EdgeInsets.all(32.0),
                  child: BrightIcon(
                    icon: _isAnswerHidden
                        ? Icons.remove_red_eye_outlined
                        : Icons.keyboard_arrow_right_outlined,
                    solidColor: colorByProgress(progress: pressProgress),
                    brightnessColor: cycleBlueAccent.withOpacity(pressProgress),
                  ),
                );
              },
              style: NeumorphicStyle(radius: 64),
              onTap: () {
                setState(() {
                  if (_isAnswerHidden) {
                    _onAnswerRequested();
                  } else {
                    _onNextClicked();
                  }
                });
              },
            ),
          ),
        ],
      ),
      // ),
    );
  }

  void _onAnswerRequested() {
    _isAnswerHidden = false;
    _hint = _isReverse ? currentWord.source : currentWord.translate;
  }

  void _onNextClicked() {
    _isReverse = random.nextBool();
    _isAnswerHidden = true;
    _hint = '';
    _initRandomWord();
    _controller.clear();
  }

  Offset getPositionByKey(GlobalKey key) {
    final RenderBox renderBox = key.currentContext.findRenderObject();
    return renderBox.localToGlobal(Offset(renderBox.size.width / 2, -68));
  }
}
