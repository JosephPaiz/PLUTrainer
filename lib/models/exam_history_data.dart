class ExamHistoryData {
  final int superKey;
  final double score;
  final int answeredQuestions;
  final int correctAnswers;
  final int authorizedSuperkey;
  final int duration;

  ExamHistoryData({
    required this.superKey,
    required this.score,
    required this.answeredQuestions,
    required this.correctAnswers,
    required this.authorizedSuperkey,
    required this.duration,
  });

  Map<String, dynamic> toMap() {
    return {
      'superkey': superKey,
      'score': score,
      'answered_questions': answeredQuestions,
      'correct_answers': correctAnswers,
      'authorized_superkey': authorizedSuperkey,
      'duration': duration,
    };
  }
}
