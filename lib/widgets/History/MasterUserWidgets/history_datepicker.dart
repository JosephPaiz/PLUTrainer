import 'package:flutter/material.dart';
import 'package:plu_trainer/core/style/custom_colors.dart';

class HistoryDatepicker extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  const HistoryDatepicker({super.key, required this.onDateSelected});

  @override
  _HistoryDatepickerState createState() => _HistoryDatepickerState();
}

class _HistoryDatepickerState extends State<HistoryDatepicker> {
  DateTime? selectedDate;
  String buttonText = 'Selecciona la fecha';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        buttonText =
            '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}';
      });
      widget.onDateSelected(selectedDate!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _selectDate(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: CustomColors.darkGreen,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        buttonText,
        style: const TextStyle(
          color: CustomColors.white,
        ),
      ),
    );
  }
}
