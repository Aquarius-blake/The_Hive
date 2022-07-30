import 'package:flutter/material.dart';

class likeAnimation extends StatefulWidget {
  const likeAnimation({Key? key}) : super(key: key);

  @override
  State<likeAnimation> createState() => _likeAnimationState();
}

class _likeAnimationState extends State<likeAnimation> with SingleTickerProviderStateMixin{
 late AnimationController controller;

@override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
