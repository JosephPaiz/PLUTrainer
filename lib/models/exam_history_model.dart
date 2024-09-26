class ExamHistoryModel {
  final double score;
  final int answeredQuestions;
  final int correctAnswers;
  final int authorizedSuperkey;
  final int duration;
  final DateTime date;

  ExamHistoryModel({
    required this.score,
    required this.answeredQuestions,
    required this.correctAnswers,
    required this.authorizedSuperkey,
    required this.duration,
    required this.date,
  });

  factory ExamHistoryModel.fromMap(Map<String, dynamic> map) {
    return ExamHistoryModel(
      score: map['score'] ?? 0.0,
      answeredQuestions: map['answered_questions'] ?? 0,
      correctAnswers: map['correct_answers'] ?? 0,
      authorizedSuperkey: map['authorized_superkey'] ?? 0,
      duration: map['duration'] ?? 0,
      date: DateTime.parse(map['date']),
    );
  }
}
