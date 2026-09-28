import 'dart:async';
import 'package:flutter/material.dart';

enum SlideFromSlide { TOP, BOTTOM, LEFT, RIGHT }

class ShowUpTransition extends StatefulWidget {
  final Widget? child;
  final Duration? duration;
  final Duration? delay;
  final bool? forward;
  final SlideFromSlide slideSide;

  const ShowUpTransition({
    super.key,
    @required this.child,
    this.duration = const Duration(milliseconds: 600),
    this.delay = Duration.zero,
    this.slideSide = SlideFromSlide.RIGHT,
    this.forward = true,
  });

  @override
  State<ShowUpTransition> createState() => _ShowUpTransitionState();
}

class _ShowUpTransitionState extends State<ShowUpTransition>
    with SingleTickerProviderStateMixin {
  AnimationController? _animController;
  Animation<Offset>? _animOffset;

  List<Offset> slideSides = [
    const Offset(-0.35, 0.0), // LEFT
    const Offset(0.35, 0.0), // RIGHT
    const Offset(0.0, 0.35), // BOTTOM
    const Offset(0.0, -0.35), // TOP
  ];
  Offset? selectedSlide;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
        vsync: this,
        duration: widget.duration ?? const Duration(milliseconds: 400));
    switch (widget.slideSide) {
      case SlideFromSlide.LEFT:
        selectedSlide = slideSides[0];
        break;
      case SlideFromSlide.RIGHT:
        selectedSlide = slideSides[1];
        break;
      case SlideFromSlide.BOTTOM:
        selectedSlide = slideSides[2];
        break;
      case SlideFromSlide.TOP:
        selectedSlide = slideSides[3];
        break;
    }
    _animOffset = Tween<Offset>(begin: selectedSlide, end: Offset.zero).animate(
        CurvedAnimation(
            curve: Curves.fastLinearToSlowEaseIn, parent: _animController!));
  }

  @override
  void dispose() {
    _animController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Timer(widget.delay!, () {
      if (widget.forward!) {
        if (mounted) _animController!.forward();
      } else {
        if (mounted) _animController!.reverse();
      }
    });
    return widget.forward!
        ? FadeTransition(
            opacity: _animController!,
            child: SlideTransition(
              position: _animOffset!,
              child: widget.child,
            ),
          )
        : Container();
  }
}
