/// [HistoryModel] represent the history model of the quiz
class HistoryModel {
  String date;
  int score;
  HistoryModel({
    required this.date,
    required this.score,
  });

  HistoryModel.fromMap(Map map)
      : date = map["date"],
        score = map["score"];

  Map toMap() {
    return {
      "date": date,
      "score": score,
    };
  }
}
