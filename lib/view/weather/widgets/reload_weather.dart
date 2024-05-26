import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RotatingIconButton extends StatefulWidget {
  const RotatingIconButton({super.key, required this.onPressed});
  final Function() onPressed;

  @override
  RotatingIconButtonState createState() => RotatingIconButtonState();
}

class RotatingIconButtonState extends State<RotatingIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _rotateIcon() {
    widget.onPressed();
    _controller.repeat();
    Future.delayed(const Duration(seconds: 1), () {
      _controller.stop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _rotateIcon,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.rotate(
            angle: _animation.value *
                2 *
                3.141592653589793, // 360 degrees in radians
            child: Icon(
              Icons.autorenew_rounded,
              size: 30.sp,
              color: Colors.white.withOpacity(0.9),
            ),
          );
        },
      ),
    );
  }
}
