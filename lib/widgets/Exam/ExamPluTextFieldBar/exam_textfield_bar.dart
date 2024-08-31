import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hugeicons/hugeicons.dart';

class PLUTextFiedBar extends StatefulWidget {
  final void Function(String) onPLUEntered;

  const PLUTextFiedBar({super.key, required this.onPLUEntered});

  @override
  State<PLUTextFiedBar> createState() => _PLUTextFiedBarState();
}

class _PLUTextFiedBarState extends State<PLUTextFiedBar> {
  final TextEditingController _pluController = TextEditingController();

  void _submitPLU() {
    widget.onPLUEntered(_pluController.text);
    _pluController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 600,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: TextField(
                  controller: _pluController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(
                    labelText: 'Enter PLU',
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                  onSubmitted: (value) => _submitPLU(),
                ),
              ),
              ElevatedButton(
                onPressed: _submitPLU,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  iconColor: Colors.white,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20),
                ),
                child: const Icon(
                  HugeIcons.strokeRoundedNavigation03,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
