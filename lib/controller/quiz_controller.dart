import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quiz/models/history_model.dart';
import 'package:flutter_quiz/models/question_model.dart';
import 'package:flutter_quiz/quiz_data.dart';
import 'package:flutter_quiz/views/score/view.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// State Management for the Quiz App
class QuizController extends GetxController with GetSingleTickerProviderStateMixin {
  // Animation for the timer
  late AnimationController _animationController;
  late Animation _animation;
  Animation get animation => _animation;

  // Page Controller for the PageView
  late PageController _pageController;
  PageController get pageController => _pageController;

  // List of questions
  final List<QuestionModel> _questions = quizData
      .map(
        (question) => QuestionModel(
            id: question['id'],
            question: question['question'],
            options: question['options'],
            answer: question['answer_index']),
      )
      .toList();

  List<QuestionModel> get questions => _questions;

  bool _isAnswered = false;
  bool get isAnswered => _isAnswered;

  int _correctAns = 0;
  int get correctAns => _correctAns;

  int? _selectedAns;
  int get selectedAns => _selectedAns!;

  final RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => _questionNumber;

  int _numOfCorrectAns = 0;
  int get numOfCorrectAns => _numOfCorrectAns;

  @override
  void onInit() {
    _animationController = AnimationController(duration: const Duration(seconds: 10), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        update();
      });

    _animationController.forward().whenComplete(nextQuestion);
    _pageController = PageController();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    _animationController.dispose();
    _pageController.dispose();
  }

  // Checking the answer
  void checkAns(QuestionModel question, int selectedIndex) {
    _isAnswered = true;
    _correctAns = question.answer!;
    _selectedAns = selectedIndex;

    if (_correctAns == _selectedAns) {
      _numOfCorrectAns++;
    } else if (_selectedAns == null || _correctAns != _selectedAns) {
      _numOfCorrectAns != 0 ? _numOfCorrectAns-- : _numOfCorrectAns = 0;
    }

    _animationController.stop();
    update();

    // Once user select an ans after 1s it will go to the next question
    Future.delayed(const Duration(seconds: 1), () {
      nextQuestion();
    });
  }

  // Move to the next question
  void nextQuestion() {
    if (_questionNumber.value != _questions.length) {
      _isAnswered = false;

      if (_selectedAns == null) {
        _numOfCorrectAns != 0 ? _numOfCorrectAns-- : _numOfCorrectAns = 0;
      }

      _pageController.nextPage(duration: const Duration(milliseconds: 250), curve: Curves.ease);

      // Reset the counter
      _animationController.reset();

      _selectedAns = null;

      // Then start it again
      // Once timer is finish go to the next question
      _animationController.forward().whenComplete(nextQuestion);
    } else {
      if (_selectedAns == null) {
        _numOfCorrectAns != 0 ? _numOfCorrectAns-- : _numOfCorrectAns = 0;
      }
      storeScore();
      Get.offAll(const ScoreView());
    }
  }

  // Storing the score in local storage
  void storeScore() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final HistoryModel history = HistoryModel(date: DateTime.now().toString(), score: _numOfCorrectAns);

    final oldScore = prefs.getStringList('score');

    if (oldScore != null) {
      final List<HistoryModel> newList = oldScore.map((item) => HistoryModel.fromMap(json.decode(item))).toList();

      newList.add(history);
      List<String> historyList = newList.map((item) => jsonEncode(item.toMap())).toList();
      prefs.setStringList('score', historyList);
    } else {
      final List<HistoryModel> newList = [history];

      List<String> newScoreList = newList.map((item) => jsonEncode(item.toMap())).toList();

      prefs.setStringList('score', newScoreList);
    }
  }

  // Updating the question number
  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }
}
