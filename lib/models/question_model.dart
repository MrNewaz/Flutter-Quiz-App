/// [QuestionModel] represent the question and answer model of the quiz
class QuestionModel {
  int? id, answer;
  String? question;
  List<String>? options;

  QuestionModel({
    this.id,
    this.answer,
    this.question,
    this.options,
  });
}
