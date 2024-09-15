class HistoryData {
  final int superKey;
  final double score;
  final int answeredQuestions;
  final int correctAnswers;
  final int pluHelperUsage;
  final String trainingType;
  final int duration;
  final DateTime date;

  HistoryData({
    required this.superKey,
    required this.score,
    required this.answeredQuestions,
    required this.correctAnswers,
    required this.pluHelperUsage,
    required this.trainingType,
    required this.duration,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'superkey': superKey,
      'score': score,
      'answered_questions': answeredQuestions,
      'correct_answers': correctAnswers,
      'pluhelper_usage': pluHelperUsage,
      'training_type': trainingType,
      'duration': duration,
      'date': date.toIso8601String(),
    };
  }
}
