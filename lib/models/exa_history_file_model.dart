class ExamHistoryFileModel {
  final int superkey;
  final String name;
  final double score;
  final int duration;
  final DateTime date;

  ExamHistoryFileModel({
    required this.superkey,
    required this.name,
    required this.score,
    required this.duration,
    required this.date,
  });

  factory ExamHistoryFileModel.fromMap(Map<String, dynamic> map) {
    return ExamHistoryFileModel(
      superkey: map['superkey'] as int,
      name: map['name'] as String,
      score: (map['score'] as num).toDouble(),
      duration: map['duration'] as int,
      date: DateTime.parse(map['date'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'superkey': superkey,
      'name': name,
      'score': score,
      'duration': duration,
      'date': date.toIso8601String(),
    };
  }
}
