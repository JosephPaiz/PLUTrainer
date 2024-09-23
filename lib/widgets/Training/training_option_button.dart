import 'package:flutter/material.dart';
import 'package:plu_trainer/core/style/custom_colors.dart';
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
            width: _isHovered ? 305 : 300,
            height: _isHovered ? 515 : 500,
            decoration: BoxDecoration(
                border: Border.all(color: CustomColors.darkGreen, width: 1),
                color: _isHovered ? Colors.grey[200] : Colors.white,
                borderRadius: BorderRadius.circular(20)),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    widget.nameOfTheTraining,
                    style: Fonts.trainingOptionButtonText,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                      color: CustomColors.darkGreen),
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Icon(
                      widget.trainingIcon,
                      size: 130,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
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
