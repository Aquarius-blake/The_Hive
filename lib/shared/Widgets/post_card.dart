import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  const PostCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: Card(
        child: Column(
          children: [
            Row(
              children: [

                CircleAvatar(
                  radius: 16,
                ),
                Expanded(
                    child: Padding(
                      child:Column() ,
                        padding:const EdgeInsets.only(
                          left: 8.0
                        )
                    )
                )

              ],
            ),
          ],
        ),
      ),
    );
  }
}
