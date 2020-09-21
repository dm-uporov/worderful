import 'package:flutter/material.dart';
import 'package:words_remember/business/WordsRepository.dart';
import 'package:words_remember/model/Word.dart';
import 'package:words_remember/utils/NeumorphicClickableContainer.dart';
import 'dart:math';

import 'package:words_remember/utils/NeumorphicRipplesObservableBoard.dart';

class WritingTrainingScreen extends StatefulWidget {
  @override
  _WritingTrainingScreenState createState() => _WritingTrainingScreenState();
}

class _WritingTrainingScreenState extends State<WritingTrainingScreen> {
  List<Word> words;
  Random random;
  Word currentWord;

  int _lastWordIndex;

  String _userInput;
  final TextEditingController _controller = TextEditingController();

  String _hint = '';

  bool _writingIsEnabled = true;

  TouchPoint point;
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
        backgroundColor: Colors.grey.shade600,
        title: Text('Тренировка | Написание'),
      ),
      body: Stack(
        children: [
          NeumorphicRipplesObservableBoard(
            point: point,
            color: Colors.grey.shade400,
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 16.0, right: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${currentWord.source}',
                  style: TextStyle(fontSize: 22.0),
                ),
                Padding(padding: EdgeInsets.only(top: 16.0)),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Перевод',
                  ),
                  onChanged: _onWordChanged,
                  enabled: _writingIsEnabled,
                  controller: _controller,
                ),
                Padding(padding: EdgeInsets.only(top: 16.0)),
                Text(_hint),
                Padding(padding: EdgeInsets.only(top: 16.0)),
                NeumorphicClickableContainer(
                  key: buttonKey,
                  child: Icon(
                    Icons.done,
                    color: Colors.grey.shade500,
                  ),
                  radius: 100,
                  onTapDown: (point) {
                    setState(() {
                      this.point = TouchPoint(
                        getPositionByKey(buttonKey),
                        DateTime.now().millisecondsSinceEpoch,
                      );
                      if (_writingIsEnabled) {
                        _onAnswerAccepted();
                      } else {
                        _onNextClicked();
                      }
                    });
                  },
                ),
                // RaisedButton(
                //   child: Text(_writingIsEnabled ? 'Проверить' : 'Дальше'),
                //   onPressed: () {
                //     if (_writingIsEnabled) {
                //       _onAnswerAccepted();
                //     } else {
                //       _onNextClicked();
                //     }
                //   },
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onWordChanged(String newWord) {
    _userInput = newWord;
  }

  void _onAnswerAccepted() {
    setState(() {
      FocusScope.of(context).unfocus();
      _writingIsEnabled = false;
      final bool answerIsRight = currentWord.translate == _userInput;
      if (answerIsRight) {
        _hint = 'Всё верно, погнали дальше!';
      } else {
        _hint = 'Тупица! Правильный ответ: ${currentWord.translate}';
      }
    });
  }

  void _onNextClicked() {
    setState(() {
      _writingIsEnabled = true;
      _hint = '';
      _initRandomWord();
      _userInput = null;
      _controller.clear();
    });
  }

  Offset getPositionByKey(GlobalKey key) {
    final RenderBox renderBox = key.currentContext.findRenderObject();
    return renderBox.localToGlobal(Offset(renderBox.size.width / 2, -68));
  }
}
