import 'package:flutter/material.dart';
import 'package:flutter_quiz/controller/quiz_controller.dart';
import 'package:flutter_quiz/views/history/view.dart';
import 'package:flutter_quiz/views/quiz/view.dart';
import 'package:get/get.dart';

/// [ScoreView] is the view that displays the score of the player at the end
class ScoreView extends StatelessWidget {
  const ScoreView({super.key});

  @override
  Widget build(BuildContext context) {
    QuizController quizController = Get.put(QuizController());

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              const Text(
                'Total Score:',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Card(
                color: Colors.deepPurpleAccent,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 75, vertical: 8),
                      child: Text(
                        '${quizController.numOfCorrectAns}',
                        style: const TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      height: 5,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 75, vertical: 8),
                      child: Text(
                        '${quizController.questions.length}',
                        style: const TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 3),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ElevatedButton.icon(
                  onPressed: () {
                    Get.delete<QuizController>().then(
                      (_) => Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => const QuizView()), (Route route) => false),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: OutlinedButton.icon(
                  onPressed: () =>
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HistoryView())),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.deepPurpleAccent),
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: const Icon(Icons.history),
                  label: const Text('View History'),
                ),
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
