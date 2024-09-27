// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:plu_trainer/models/exa_history_file_model.dart';
import 'package:plu_trainer/services/supabase_service.dart';

class ExamHistoryDownloadViewModel extends ChangeNotifier {
  final SupabaseService _supabaseService = SupabaseService();

  DateTime? _startDate;
  DateTime? _endDate;
  List<ExamHistoryFileModel> _examHistory = [];
  bool _isLoading = false;
  String? _error;

  // Getters
  DateTime? get startDate => _startDate;
  DateTime? get endDate => _endDate;
  List<ExamHistoryFileModel> get examHistory => _examHistory;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Setters para las fechas
  void setStartDate(DateTime date) {
    _startDate = date;
    notifyListeners();
  }

  void setEndDate(DateTime date) {
    _endDate = date;
    notifyListeners();
  }

  Future<void> fetchExamHistory() async {
    if (_startDate == null || _endDate == null) {
      _error = 'Por favor, seleccione ambas fechas.';
      notifyListeners();
      return;
    }

    if (_startDate!.isAfter(_endDate!)) {
      _error = 'La fecha de inicio no puede ser posterior a la fecha de fin.';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _examHistory = await _supabaseService.getExamHistoryByDateRange(
          _startDate!, _endDate!);
      if (_examHistory.isEmpty) {
        _error =
            'No se encontraron registros para el rango de fechas seleccionado.';
      } else {
        _error = null;
        await generateAndDownloadExcel();
      }
    } catch (e) {
      _error = 'Error al obtener el historial de exámenes: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Map<String, Map<String, double>> _calculateAverageScoresAndDuration() {
    Map<String, List<double>> scoresMap = {};
    Map<String, List<int>> durationMap = {};

    for (var history in _examHistory) {
      if (!scoresMap.containsKey(history.name)) {
        scoresMap[history.name] = [];
        durationMap[history.name] = [];
      }
      scoresMap[history.name]!.add(history.score);
      durationMap[history.name]!.add(history.duration);
    }

    Map<String, Map<String, double>> averageScoresAndDuration = {};
    scoresMap.forEach((name, scores) {
      double averageScore = scores.reduce((a, b) => a + b) / scores.length;
      double averageDuration = durationMap[name]!.reduce((a, b) => a + b) /
          durationMap[name]!.length;
      averageScoresAndDuration[name] = {
        'averageScore': double.parse(averageScore.toStringAsFixed(2)),
        'averageDuration': double.parse(averageDuration.toStringAsFixed(2)),
      };
    });

    return averageScoresAndDuration;
  }

  Future<void> generateAndDownloadExcel() async {
    if (_examHistory.isEmpty) {
      _error = 'No hay datos para generar el archivo Excel.';
      notifyListeners();
      return;
    }

    Map<String, Map<String, double>> averageScoresAndDuration =
        _calculateAverageScoresAndDuration();

    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Historial'];

    sheetObject.appendRow(['Nombre', 'Puntaje promedio', 'Duración promedio']);

    averageScoresAndDuration.forEach((name, averages) {
      sheetObject.appendRow([
        name,
        averages['averageScore'],
        averages['averageDuration'],
      ]);
    });

    var excelBytes = excel.encode()!;

    final blob = html.Blob([excelBytes],
        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', 'historial_promedio.xlsx')
      ..click();
    html.Url.revokeObjectUrl(url);

    _error = 'Archivo Excel descargado con éxito.';
    notifyListeners();
  }

  void resetDates() {
    _startDate = null;
    _endDate = null;
    _examHistory = [];
    _error = null;
    notifyListeners();
  }
}
