import 'package:flutter/material.dart';
import 'package:flutter_quiz/controller/quiz_controller.dart';
import 'package:flutter_quiz/models/question_model.dart';
import 'package:flutter_quiz/widgets/option.dart';
import 'package:get/get.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    Key? key,
    required this.question,
  }) : super(key: key);

  final QuestionModel question;

  @override
  Widget build(BuildContext context) {
    QuizController controller = Get.put(QuizController());
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              question.question!,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.black),
            ),
            const SizedBox(height: 10),
            ...List.generate(
              question.options!.length,
              (index) => Option(
                index: index,
                text: question.options![index],
                press: () => controller.checkAns(question, index),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
