import 'package:flutter/material.dart';
import 'dart:math' show pi;

class ElsieButton extends StatefulWidget {
  final bool playing;
  final Icon playIcon;
  final Icon pauseIcon;
  final VoidCallback onPressed;

  ElsieButton({
    required this.onPressed,
    this.playing = false,
    this.playIcon = const Icon(Icons.mic),
    this.pauseIcon = const Icon(Icons.mic),
  }) : assert(onPressed != null);

  @override
  _ElsieButtonState createState() => _ElsieButtonState();
}

class _ElsieButtonState extends State<ElsieButton> with TickerProviderStateMixin {
  static const _kToggleDuration = Duration(milliseconds: 300);  
  static const _kRotationDuration = Duration(seconds: 5);

  // rotation and scale animations
  late AnimationController _rotationController;
  late AnimationController _scaleController;
  double _rotation = 0;
  double _scale = 0.85;

  bool get _showWaves => !_scaleController.isDismissed;

  void _updateRotation() => _rotation = _rotationController.value * 2 * pi;
  void _updateScale() => _scale = (_scaleController.value * 0.2) + 0.85;

  @override
  void initState() {
    _rotationController =
        AnimationController(vsync: this, duration: _kRotationDuration)
          ..addListener(() => setState(_updateRotation))
          ..repeat();

    _scaleController =
        AnimationController(vsync: this, duration: _kToggleDuration)
          ..addListener(() => setState(_updateScale));

    super.initState();
  }

  void _onToggle() {
    // if (_scaleController.isCompleted) {
    //   print("A");
    //   _scaleController.reverse();
    // } else {
    //   print("B");
    //   _scaleController.forward();
    // }

    _scaleController.forward();
	  
    widget.onPressed();
  }

  Widget _buildIcon(bool isPlaying) {
    return SizedBox.expand(
      key: ValueKey<bool>(isPlaying),
      child: IconButton(
        icon: isPlaying ? widget.pauseIcon : widget.playIcon,
        onPressed: _onToggle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (widget.playing) ...[
            Blob(color: Color(0xff0092ff), scale: _scale, rotation: _rotation),
            Blob(color: Color(0xff4ac7b7), scale: _scale, rotation: _rotation * 2 - 30),
            Blob(color: Color(0xffa4a6f6), scale: _scale, rotation: _rotation * 3 - 45),
          ],
          Container(
            constraints: const BoxConstraints.expand(),
            child: AnimatedSwitcher(
              child: _buildIcon(widget.playing),
              duration: _kToggleDuration,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _rotationController.dispose();
    super.dispose();
  }
}

class Blob extends StatelessWidget {
  final double rotation;
  final double scale;
  final Color color;

  const Blob({required this.color, this.rotation = 0, this.scale = 1});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      child: Transform.rotate(
        angle: rotation,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(150),
              topRight: Radius.circular(240),
              bottomLeft: Radius.circular(220),
              bottomRight: Radius.circular(180),
            ),
          ),
        ),
      ),
    );
  }
}