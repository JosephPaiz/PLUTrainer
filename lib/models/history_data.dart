class HistoryData {
  final int superKey;
  final double score;
  final int answeredQuestions;
  final int correctAnswers;
  final int pluHelperUsage;
  final String trainingType;
  final int duration;
  final DateTime date; // Nuevo campo para la fecha

  HistoryData({
    required this.superKey,
    required this.score,
    required this.answeredQuestions,
    required this.correctAnswers,
    required this.pluHelperUsage,
    required this.trainingType,
    required this.duration,
    required this.date, // Agregar la fecha en el constructor
  });

  // Convertir el objeto a un Map que se pueda insertar en la base de datos
  Map<String, dynamic> toMap() {
    return {
      'superkey': superKey,
      'score': score,
      'answered_questions': answeredQuestions,
      'correct_answers': correctAnswers,
      'pluhelper_usage': pluHelperUsage,
      'training_type': trainingType,
      'duration': duration,
      'date': date
          .toIso8601String(), // Convertir la fecha a un formato legible por la base de datos
    };
  }
}
