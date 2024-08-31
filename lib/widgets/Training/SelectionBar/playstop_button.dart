import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class PlayStopButton extends StatefulWidget {
  final bool isSelectionBarOpen;
  final bool isPlaying;
  final VoidCallback? onTap;

  const PlayStopButton({
    super.key,
    required this.isSelectionBarOpen,
    required this.isPlaying,
    required this.onTap,
  });

  @override
  State<PlayStopButton> createState() => _PlayStopButtonState();
}

class _PlayStopButtonState extends State<PlayStopButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (event) {
        setState(() {
          isHovered = false;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: AnimatedContainer(
          alignment: Alignment.center,
          height: 40,
          width: widget.isSelectionBarOpen ? 130 : 65,
          duration: const Duration(milliseconds: 100),
          decoration: BoxDecoration(
            color: widget.isPlaying ? Colors.red : Colors.green,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: ListTile(
              title: widget.isSelectionBarOpen
                  ? AnimatedDefaultTextStyle(
                      style: TextStyle(
                        fontSize: isHovered ? 17.0 : 16.0,
                        color: Colors.white,
                      ),
                      duration: const Duration(milliseconds: 100),
                      child: Text(widget.isPlaying ? 'Pause' : 'Play'),
                    )
                  : null,
              onTap: widget.onTap,
              leading: AnimatedSize(
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  widget.isPlaying
                      ? HugeIcons.strokeRoundedPause
                      : HugeIcons.strokeRoundedPlay,
                  color: Colors.white,
                  size: isHovered ? 27.0 : 24.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
