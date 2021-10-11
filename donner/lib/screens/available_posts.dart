import 'package:donner/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class AvailablePosts extends StatefulWidget {
  const AvailablePosts({Key? key}) : super(key: key);

  @override
  _AvailablePostsState createState() => _AvailablePostsState();
}

class _AvailablePostsState extends State<AvailablePosts> {
  String? postTypeFilter;

  @override
  Widget build(BuildContext context) {
    double? imageHeight = 80;
    double? dividerHeight = 10;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(10, (index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: InkWell(
                  onTap: () {},
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Image.asset(
                          "assets/mini_logo_donner.png",
                          height: imageHeight,
                        ),
                      ),
                      SizedBox(
                        height: dividerHeight,
                      ),
                      Text(
                        "Item $index",
                        style: AppTextStyles.cardText,
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: dividerHeight,
                      ),
                      Text(
                        "Cidade ${index + 1}",
                        style: AppTextStyles.cardText,
                        textAlign: TextAlign.left,
                      )
                    ],
                  ),
                ),
              ),
            );
          })),
    );
  }
}
