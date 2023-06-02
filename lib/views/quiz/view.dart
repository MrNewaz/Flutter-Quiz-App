import 'package:flutter/material.dart';
import 'package:flutter_quiz/controller/quiz_controller.dart';
import 'package:flutter_quiz/widgets/progress_bar.dart';
import 'package:flutter_quiz/widgets/question_card.dart';
import 'package:get/get.dart';

/// [QuizView] represent the quiz view which contains the questions and answers
class QuizView extends StatelessWidget {
  const QuizView({super.key});

  @override
  Widget build(BuildContext context) {
    QuizController quizController = Get.put(QuizController());
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const ProgressBar(),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
                    child: GetBuilder<QuizController>(
                        init: QuizController(),
                        builder: (scoreController) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text.rich(
                                TextSpan(
                                  text: "Q. ${scoreController.questionNumber.value}",
                                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.black),
                                  children: [
                                    TextSpan(
                                      text: "/${scoreController.questions.length}",
                                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                              Text('Score: ${scoreController.numOfCorrectAns}',
                                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.black))
                            ],
                          );
                        }),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: quizController.pageController,
                onPageChanged: quizController.updateTheQnNum,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: QuestionCard(
                    question: quizController.questions[index],
                  ),
                ),
                itemCount: quizController.questions.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
