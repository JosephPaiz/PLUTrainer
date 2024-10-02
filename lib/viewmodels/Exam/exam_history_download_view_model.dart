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
  String _starDateText = '';
  String _endDateText = '';
  List<ExamHistoryFileModel> _examHistory = [];
  bool _isLoading = false;
  String? _error;

  DateTime? get startDate => _startDate;
  DateTime? get endDate => _endDate;
  List<ExamHistoryFileModel> get examHistory => _examHistory;
  bool get isLoading => _isLoading;
  String? get error => _error;

  void setStartDate(DateTime date) {
    _startDate = date;
    _starDateText = '${date.day}/${date.month}/${date.year}';

    notifyListeners();
  }

  void setEndDate(DateTime date) {
    _endDate = date;
    _endDateText = '${date.day}/${date.month}/${date.year}';

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

    CellStyle defaultCellStyle = CellStyle(
      backgroundColorHex: "#FFFFFF",
      fontFamily: getFontFamily(FontFamily.Calibri),
    );

    CellStyle redCellStyle = CellStyle(
      backgroundColorHex: "#FF0000",
      fontFamily: getFontFamily(FontFamily.Calibri),
    );

    sheetObject.appendRow(
        ['Nombre', 'Puntaje promedio', 'Duración promedio', 'Estado']);

    averageScoresAndDuration.forEach((name, averages) {
      var rowIndex = sheetObject.maxRows;

      String estado =
          averages['averageScore']! >= 80 ? 'Aprobado' : 'Reprobado';

      sheetObject.appendRow([
        name,
        averages['averageScore'],
        averages['averageDuration'],
        estado, // Agregar el estado
      ]);

      var scoreCell = sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: rowIndex));
      if (averages['averageScore']! < 80) {
        scoreCell.cellStyle = redCellStyle;
      } else {
        scoreCell.cellStyle = defaultCellStyle;
      }

      var durationCell = sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: rowIndex));
      durationCell.cellStyle = defaultCellStyle;
    });

    var excelBytes = excel.encode()!;

    final blob = html.Blob([excelBytes],
        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute(
          'download', 'Historial-prueba-plu-$_starDateText-$_endDateText.xlsx')
      ..click();
    html.Url.revokeObjectUrl(url);

    _error = 'Promedio de las pruebas PLU descargado con éxito.';
    notifyListeners();
  }

  void resetDates() {
    _starDateText = '';
    _endDateText = '';
    _startDate = null;
    _endDate = null;
    _examHistory = [];
    _error = null;
    notifyListeners();
  }
}
