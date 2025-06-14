import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';

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
  String getUpdate = 'Update';

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
    setState(() {
      getUpdate = 'Updating';
    });
    _controller.repeat();
    Future.delayed(const Duration(seconds: 4), () {
      _controller.stop();
      setState(() {
        getUpdate = 'Update';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _rotateIcon,
      child: Row(
        spacing: 6,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform.rotate(
                angle: _animation.value * 2 * 3.141592653589793,
                alignment: Alignment.center, // Ensure center alignment
                child: Container(
                  width: 16.sp,
                  height: 16.sp,
                  alignment:
                      Alignment.center, // Center the icon within container
                  child: Icon(
                    Remix.refresh_line,
                    size: 16.sp,
                    color: Colors.black,
                  ),
                ),
              );
            },
          ),
          Text(
            getUpdate,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
