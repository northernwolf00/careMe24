import 'package:careme24/pages/medical_bag/widgets/custom_gradient_button.dart';
import 'package:careme24/utils/image_constant.dart';
import 'package:careme24/utils/size_utils.dart';
import 'package:careme24/widgets/app_bar/appbar_image.dart';
import 'package:careme24/widgets/app_bar/appbar_title.dart';
import 'package:careme24/widgets/app_bar/custom_app_bar.dart';
import 'package:careme24/widgets/custom_image_view.dart';
import 'package:careme24/widgets/review_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewsScreen extends StatefulWidget {
  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  int _rating = 0;
  final List<Map<String, dynamic>> reviews = [
    {
      "name": "Пашковский Павел Павлович Третий",
      "rating": 3.2,
      "comment":
          "ОтзывОтзывОтзывОтзывОтзывОтзывОтзывОтзывОтзывОтзывОтзывОтзыв..."
    },
    {
      "name": "Пашковский Павел Павлович Третий",
      "rating": 5.0,
      "comment":
          "ОтзывОтзывОтзывОтзывОтзывОтзывОтзывОтзывОтзывОтзывОтзывОтзыв..."
    }
  ];

  Widget _buildStar(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _rating = index;
        });
      },
      child: Icon(
        Icons.star,
        size: 40,
        color: index <= _rating ? Colors.amber : Colors.grey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          height: getVerticalSize(48),
          leadingWidth: 43,
          leading: AppbarImage(
              height: getVerticalSize(16),
              width: getHorizontalSize(11),
              svgPath: ImageConstant.imgArrowleft,
              margin: getMargin(left: 15, right: 15, top: 15, bottom: 15),
              onTap: () {
                Navigator.pop(context);
              }),
          centerTitle: true,
          title: AppbarTitle(text: "Отзывы"),
          styleType: Style.bgFillBlue60001),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 52,
                  width: 62,
                  child: Card(
                    color: Colors.white,
                    child: Stack(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: CustomImageView(
                                svgPath: ImageConstant.imgStarGold,
                                height: getSize(35),
                                width: getSize(35),
                                margin: getMargin(left: 3, top: 3, bottom: 3)),
                          ),
                        ),
                        Center(
                          child: Text("4.4",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.4,
                  child: CustomGradientButton(
                    text: 'Оставить отзыв',
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => ReviewDialog(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                final review = reviews[index];
                return Card(
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(review["name"],
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),

                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: List.generate(
                        //       5, (index) => _buildStar(review["rating"].toInt() + 1)),
                        // ),

                        Center(
                          child: RatingBarIndicator(
                            itemPadding: const EdgeInsets.only(right: 15, bottom: 20, top: 10),
                            rating: review["rating"],
                            itemBuilder: (context, index) => CustomImageView(
                                svgPath: ImageConstant.imgStarGold,
                                height: getSize(44),
                                width: getSize(44),
                                margin: getMargin(left: 3, top: 3, bottom: 3,)),
                            itemCount: 5,
                            itemSize: 44.0,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(review["comment"],
                            maxLines: 4, overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
