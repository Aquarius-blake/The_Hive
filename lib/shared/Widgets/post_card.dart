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
                        child:Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Username",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold
                              ),)
                          ],
                        ) ,
                        padding:const EdgeInsets.only(
                            left: 8.0
                        )
                    )
                ),
                IconButton(
                    onPressed: (){},
                    icon: const Icon(
                        Icons.more_vert,
                      color: Colors.black,
                    ),
                )

              ],
            ),
          ],
        ),
      ),
    );
  }
}
