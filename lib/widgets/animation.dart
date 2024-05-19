import 'package:flutter/material.dart';

///Animation

///animation-press
class AnimatedPress extends StatefulWidget {
  const AnimatedPress({
    super.key,
    required this.child,
    this.scaleEnd = 0.9,
  });

  final Widget child;

  ///Scale ratio after pressing, maximum [1.0]
  final double scaleEnd;

  @override
  State<AnimatedPress> createState() => _AnimatedPressState();
}

class _AnimatedPressState extends State<AnimatedPress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late CurvedAnimation _curve;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..addListener(() {});

    _curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.decelerate,
      reverseCurve: Curves.easeIn,
    );
    _scale = Tween(begin: 1.0, end: widget.scaleEnd).animate(_curve);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  ///Start animation
  void controllerForward() {
    final AnimationStatus status = _controller.status;
    if (status != AnimationStatus.forward &&
        status != AnimationStatus.completed) {
      _controller.forward();
    }
  }

  ///End animation
  void controllerReverse() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => controllerForward(),
      onPointerHover: (_) => controllerForward(),
      onPointerMove: (_) => controllerForward(),
      onPointerCancel: (_) => controllerReverse(),
      onPointerUp: (_) => controllerReverse(),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) =>
            Transform.scale(scale: _scale.value, child: child),
        child: widget.child,
      ),
    );
  }
}
