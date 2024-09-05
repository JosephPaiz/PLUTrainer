// class HistoryModel {
//   final String profileName;
//   final double score;
//   final int answeredQuestions;
//   final int correctAnswers;
//   final int pluHelperUsage;
//   final int duration;
//   final DateTime date;

//   HistoryModel({
//     required this.profileName,
//     required this.score,
//     required this.answeredQuestions,
//     required this.correctAnswers,
//     required this.pluHelperUsage,
//     required this.duration,
//     required this.date,
//   });

//   factory HistoryModel.fromMap(Map<String, dynamic> map) {
//     return HistoryModel(
//       profileName: map['profiles']['name'] ?? '',
//       score: map['score'] ?? 0.0,
//       answeredQuestions: map['answered_questions'] ?? 0,
//       correctAnswers: map['correct_answers'] ?? 0,
//       pluHelperUsage: map['pluhelper_usage'] ?? 0,
//       duration: map['duration'] ?? 0,
//       date: DateTime.parse(map['date']),
//     );
//   }
// }

class HistoryModel {
  final String profileName;
  final double score;
  final int answeredQuestions;
  final int correctAnswers;
  final int pluHelperUsage;
  final int duration;
  final DateTime date;
  final String trainingType; // Nueva propiedad para training_type

  HistoryModel({
    required this.profileName,
    required this.score,
    required this.answeredQuestions,
    required this.correctAnswers,
    required this.pluHelperUsage,
    required this.duration,
    required this.date,
    required this.trainingType, // Añadir el training_type al constructor
  });

  factory HistoryModel.fromMap(Map<String, dynamic> map) {
    return HistoryModel(
      profileName: map['profiles']['name'] ?? '',
      score: map['score'] ?? 0.0,
      answeredQuestions: map['answered_questions'] ?? 0,
      correctAnswers: map['correct_answers'] ?? 0,
      pluHelperUsage: map['pluhelper_usage'] ?? 0,
      duration: map['duration'] ?? 0,
      date: DateTime.parse(map['date']),
      trainingType: map['training_type'] ?? '', // Mapear el campo training_type
    );
  }
}
