import 'package:flutter/material.dart';
import 'package:plu_trainer/core/style/fonts.dart';
import 'package:plu_trainer/services/navigation_service.dart';

class TrainingOptionButton extends StatefulWidget {
  final IconData trainingIcon;
  final String nameOfTheTraining;
  final String descriptionOfTheTraining;
  final String rute;

  const TrainingOptionButton(
      {super.key,
      required this.trainingIcon,
      required this.nameOfTheTraining,
      required this.descriptionOfTheTraining,
      required this.rute});

  @override
  State<TrainingOptionButton> createState() => _TrainingOptionButtonState();
}

class _TrainingOptionButtonState extends State<TrainingOptionButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GestureDetector(
        onTap: () {
          NavigationService.navigateTo(context, widget.rute);
        },
        child: MouseRegion(
          onEnter: (_) {
            setState(() {
              _isHovered = true;
            });
          },
          onExit: (_) {
            setState(() {
              _isHovered = false;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            width: _isHovered ? 265 : 250,
            height: _isHovered ? 515 : 500,
            decoration: BoxDecoration(
                color: _isHovered
                    ? Colors.grey[300]
                    : Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20)),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue),
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Icon(
                      widget.trainingIcon,
                      size: 100,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      widget.nameOfTheTraining,
                      style: Fonts.trainingOptionButtonText,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: 150,
                  height: 150,
                  child: Text(
                    widget.descriptionOfTheTraining,
                    style: Fonts.trainingOptionButtonDescription,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
