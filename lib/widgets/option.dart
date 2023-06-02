import 'package:flutter/material.dart';
import 'package:flutter_quiz/controller/quiz_controller.dart';
import 'package:get/get.dart';

class Option extends StatelessWidget {
  const Option({
    Key? key,
    required this.text,
    required this.index,
    required this.press,
  }) : super(key: key);

  final String text;
  final int index;
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuizController>(
        init: QuizController(),
        builder: (quizController) {
          Color getTheRightColor() {
            if (quizController.isAnswered) {
              if (index == quizController.correctAns) {
                return const Color(0xFF6AC259);
              } else if (index == quizController.selectedAns &&
                  quizController.selectedAns != quizController.correctAns) {
                return const Color(0xFFE92E30);
              }
            }
            return Colors.blueGrey;
          }

          IconData getTheRightIcon() {
            return getTheRightColor() == const Color(0xFFE92E30) ? Icons.close : Icons.done;
          }

          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: InkWell(
              borderRadius: BorderRadius.circular(25),
              onTap: quizController.isAnswered ? () {} : press,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(color: getTheRightColor()),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${index + 1}. $text',
                      style: TextStyle(color: getTheRightColor(), fontSize: 16),
                    ),
                    Container(
                      height: 26,
                      width: 26,
                      decoration: BoxDecoration(
                        color: getTheRightColor() == Colors.blueGrey ? Colors.transparent : getTheRightColor(),
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: getTheRightColor()),
                      ),
                      child: getTheRightColor() == Colors.blueGrey
                          ? null
                          : Icon(getTheRightIcon(), size: 16, color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
