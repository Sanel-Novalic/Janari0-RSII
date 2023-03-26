import 'package:flutter/material.dart';

Widget buildCard() => Container(
        child: ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        color: const Color.fromRGBO(236, 232, 231, 1),
        child: Column(
          children: const [
            Image(
              image: NetworkImage(
                  "https://assets.bonappetit.com/photos/63a390eda38261d1c3bdc555/4:5/w_1920,h_2400,c_limit/best-food-writing-2022-lede.jpg"),
              fit: BoxFit.cover, // use this
              height: 120,
              width: 160,
            ),
            SizedBox(height: 2),
            SizedBox(width: 150, child: Text('Banana')),
            SizedBox(height: 23),
            SizedBox(width: 150, child: Text('Free'))
          ],
        ),
      ),
    ));

class CustomCarousel extends StatelessWidget {
  final String text;
  const CustomCarousel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5.0, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(child: Text(text)),
              Padding(
                  padding: EdgeInsets.only(right: 2.0),
                  child: InkWell(
                      onTap: () => print("AYY"), child: Text('See all >')))
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width - 10,
          child: const Divider(
            thickness: 1,
          ),
        ),
        Container(
            height: 180,
            padding: EdgeInsets.only(left: 5),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, _) => const SizedBox(width: 8),
              itemBuilder: (context, index) => buildCard(),
              itemCount: 6,
            ))
      ],
    );
  }
}
