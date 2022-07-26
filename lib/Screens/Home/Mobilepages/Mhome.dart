import 'package:flutter/material.dart';
import 'package:forum3/shared/Widgets/post_card.dart';


class Mhome extends StatefulWidget {
  const Mhome({Key? key}) : super(key: key);

  @override
  State<Mhome> createState() => _MhomeState();
}

class _MhomeState extends State<Mhome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  body: PostCard(),
    );
  }
}
