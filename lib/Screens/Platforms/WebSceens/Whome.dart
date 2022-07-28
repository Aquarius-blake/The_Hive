import 'package:flutter/material.dart';
import 'package:forum3/shared/Widgets/post_card.dart';


class WebHome extends StatefulWidget {
  const WebHome({Key? key}) : super(key: key);

  @override
  State<WebHome> createState() => _WebHomeState();
}

class _WebHomeState extends State<WebHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        width: MediaQuery.of(context).size.width*0.9,
          child: PostCard()
      ),
    );
  }
}