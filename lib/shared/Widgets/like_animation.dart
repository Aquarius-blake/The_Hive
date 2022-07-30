import 'package:flutter/material.dart';

class likeAnimation extends StatefulWidget {
  final Widget child;
  final bool isAnimating;
  final Duration duration;
  final VoidCallback onEnd;
  final bool smallLike;

  const likeAnimation({Key? key,
     this.duration=const Duration(milliseconds: 150),
    required this.child,
    required this.isAnimating,
     this.onEnd,
     this.smallLike=false,
  }) : super(key: key);

  @override
  State<likeAnimation> createState() => _likeAnimationState();
}

class _likeAnimationState extends State<likeAnimation> with SingleTickerProviderStateMixin{
 late AnimationController controller;

@override
  void initState() {

    super.initState();
    controller= AnimationController(vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
