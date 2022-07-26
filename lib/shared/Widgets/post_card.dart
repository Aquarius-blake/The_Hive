import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {


  dynamic _image;

 Widget Postimage(dynamic image,BuildContext context){
    return image!=null? SizedBox(
      width: MediaQuery.of(context).size.width*0.8,
      child: Image.network(image),
    ):SizedBox();
  }

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
                            left: 10.0
                        )
                    )
                ),
                IconButton(
                  onPressed: (){
                    showDialog(context: context, builder: (context)=>Dialog(
                      child: ListView(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,),
                        shrinkWrap: true,
                        children: [
                          'Edit',
                          'Delete'
                        ].map((e) => InkWell(
                          onTap: (){},
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 16,
                            ),
                            child: Text(e),
                          ),
                        )
                        ).toList(),
                      ),
                    )
                    );
                  },
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.black,
                  ),
                )

              ],
            ),
            Container(
              padding:const EdgeInsets.only(
                top: 5,
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width*0.8,
                child: Text(
                  "Title",
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Container(
              padding:const EdgeInsets.only(
                top: 5,
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width*0.8,
                child: Text(
                  "Detailsnjsndjfksfnksjndjksnfdksjdnfkjsdnfkjsdnfkjdsnfjksnfjdnksjnfkjsdnfjksnfksjdnkjsdndskjnksjdfnkjsnfkjndskfjnsdkjfskfjnsdkfnsdfnskfnsdfnsldfnsndfjsdnkfjsnfkjskfbsfksf"
                      "kjnknkjnkjnkjnkbkbkjbkjbkjbkjbknlklknjnknlnlnkjnkkfsnnslflsnfdjfskdfjkdsjnksdjnfjksdfksdbfn",
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Postimage(_image, context),
            Row(
              children: [
IconButton(
    onPressed: (){},
    icon: Icon(
        Icons.favorite_border_outlined,
      color: Colors.red,
    )
),
                IconButton(
                    onPressed: (){},
                    icon: Icon(
                      Icons.comment_outlined,
                      color: Colors.black,
                    )
                ),
                IconButton(
                    onPressed: (){},
                    icon: Icon(
                      Icons.favorite_border_outlined,
                      color: Colors.red,
                    )
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
