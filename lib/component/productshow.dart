import 'package:flutter/material.dart';

class Productshow extends StatelessWidget {
  final String title;
  final String image;
  final double rating;
  final int count;
  void Function()? onTap;

  Productshow(
      {super.key,
      required this.title,
      required this.image,
      required this.rating,
      required this.count,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(color: Colors.grey.shade300,borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      height: 100,
                      child: Image.network(
                        image,
                        fit: BoxFit.cover,
                      )),
                ),
                Text(
                  title,
                  style:const  TextStyle(fontSize: 10),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("purchased : " + count.toString(),style: TextStyle(fontSize: 10),),
                      Row(
                        children: [
                          Text("Rating:$rating"),
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
