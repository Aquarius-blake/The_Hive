
import 'package:flutter/material.dart';

class likeAnimation extends StatefulWidget {
  final Widget child;
  final bool isAnimating;
  final Duration duration;
  final VoidCallback? onEnd;
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
  late Animation<double> scale;

  @override
  void initState() {

    super.initState();
    controller= AnimationController(vsync: this,duration: Duration(milliseconds: widget.duration.inMilliseconds ~/2
    )
    );
    scale=Tween<double>(begin: 1.0,end: 1.2).animate(controller);
  }

  @override
  void didUpdateWidget(covariant likeAnimation oldWidget) {

    super.didUpdateWidget(oldWidget);
    if(widget.isAnimating!=oldWidget.isAnimating){
      startanimation();
    }
  }

  startanimation()async{
    if(widget.isAnimating || widget.smallLike){
      await controller.forward();
      await controller.reverse();
      await Future.delayed(const Duration(
          milliseconds: 200
      )
      );
      if(widget.onEnd!=null){
        widget.onEnd!();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
        scale: scale,
      child: widget.child,
    );
  }
}
