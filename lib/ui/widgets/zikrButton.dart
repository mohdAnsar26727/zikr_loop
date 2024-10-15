import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ZikrButton extends StatefulWidget {
  final VoidCallback onZikrCompleted;
  final int zikrDuration;

  const ZikrButton(
      {super.key, required this.onZikrCompleted, required this.zikrDuration});

  @override
  _ZikrButtonState createState() => _ZikrButtonState();
}

class _ZikrButtonState extends State<ZikrButton> with TickerProviderStateMixin {
  double progressValue = 0.0;
  late AnimationController _controller;
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100));

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.zikrDuration),
    )
      ..addListener(() {
        setState(() {
          progressValue = _controller.value;
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          resetProgress();
        }
      });

    // Initialize scale animation
    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 0.8).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeIn,
    ));
  }

  void resetProgress() {
    _controller.reset(); // Resets the animation to zero
    setState(() {
      progressValue = 0.0; // Update the progressValue as well
    });
    widget.onZikrCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Outer progress circle
        SizedBox(
          width: 120,
          height: 120,
          child: CircularProgressIndicator(
            value: progressValue,
            strokeWidth: 10.0,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
            backgroundColor: Colors.grey[800],
          ),
        ),

        // Button
        ScaleTransition(
          scale: _scaleAnimation,
          child: GestureDetector(
            onTapDown: (details) {
              _scaleController.forward();
            },
            onTapUp: (_) {
              _scaleController.reverse(); // Reverse scaling when released
              _controller.forward(); // Start the timer when released
            },
            onTapCancel: () {
              _scaleController
                  .reverse(); // Reverse scaling when tap is canceled
            },
            child: Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.limeAccent, // Green inner circle
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/logo.svg', // Replace with your SVG path
                  width: 24.0, // Desired width
                  height: 24.0, // Desired height
                  colorFilter: ColorFilter.mode(
                    Colors.black, // Color to apply
                    BlendMode.srcIn, // Blend mode to use
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
