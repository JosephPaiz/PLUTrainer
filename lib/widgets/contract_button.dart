import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class ContractButton extends StatefulWidget {
  final VoidCallback onTap;
  const ContractButton({super.key, required this.onTap});

  @override
  State<ContractButton> createState() => _SideBarBackButtonState();
}

class _SideBarBackButtonState extends State<ContractButton> {
  bool _isFirstIcon = true;

  void _onTap() {
    setState(() {
      _isFirstIcon = !_isFirstIcon;
      widget.onTap();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FloatingActionButton(
        backgroundColor: Colors.white,
        elevation: 0,
        onPressed: _onTap,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(
              scale: animation,
              child: child,
            );
          },
          child: Icon(
            _isFirstIcon
                ? HugeIcons.strokeRoundedArrowLeft01
                : HugeIcons.strokeRoundedArrowRight01,
            key: ValueKey<bool>(_isFirstIcon),
            size: 30.0,
          ),
        ),
      ),
    );
  }
}
