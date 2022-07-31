import 'package:flutter/material.dart';

class McommentsScreen extends StatefulWidget {
  const McommentsScreen({Key? key}) : super(key: key);

  @override
  State<McommentsScreen> createState() => _McommentsScreenState();
}

class _McommentsScreenState extends State<McommentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title:const Text(
          "Comments",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: SafeArea(
          child: Container(
            height: kToolbarHeight,
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom
            ),
            padding: const EdgeInsets.only(
              left: 16,
              right: 8,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  //backgroundColor: NetworkImage(),
                  radius: 18,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 12.0,
                        right: 1.0
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Comment as Username",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                InkWell()
              ],
            ),
          )
      ),
    );
  }
}
