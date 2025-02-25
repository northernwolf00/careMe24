import 'package:careme24/pages/medical_bag/widgets/custom_gradient_button.dart';
import 'package:careme24/utils/image_constant.dart';
import 'package:careme24/utils/size_utils.dart';
import 'package:careme24/widgets/custom_image_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ReviewDialog extends StatefulWidget {
  @override
  _ReviewDialogState createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<ReviewDialog> {
  int _rating = 0;
  TextEditingController _commentController = TextEditingController();

  void _submitReview() async {
    String comment = _commentController.text.trim();
    if (_rating == 0 || comment.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please provide a rating and comment")),
      );
      return;
    }

    try {
      Response response = await Dio().post(
        'https://your-api-endpoint.com/reviews',
        data: {'rating': _rating, 'comment': comment},
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Review submitted successfully!")),
      );
      _commentController.clear();
      setState(() => _rating = 0);
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to submit review")),
      );
    }
  }

  Widget _buildStar(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _rating = index;
        });
      },
      child:  CustomImageView(
                                svgPath: ImageConstant.imgStarGold,
                                height: getSize(44),
                                width: getSize(44),
                                margin: getMargin(left: 3, top: 3, bottom: 3),
                                color:index <= _rating ? Colors.amber : Colors.grey ,)
      
     
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(Icons.close,
                size: 30,),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          const  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Оставьте отзыв", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text("Никишин Н.A", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                
              ],
            ),
          const  SizedBox(height: 5),
          const  Text("Если вы уже взаимодействовали со специалистом", style: TextStyle(color: Colors.grey)),
          const  SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) => _buildStar(index + 1)),
            ),
          const  SizedBox(height: 10),
          const  Text("Комментарий:", style: TextStyle(fontSize: 16)),
          const  SizedBox(height: 5),
            Container(
              padding:const EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextField(
                controller: _commentController,
                maxLines: 4,
                decoration:const InputDecoration(
                  isDense: true,
              contentPadding: EdgeInsets.zero,
                  hintText: "Напишите ваш комментарий",
                  border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
                      
              
                ),
              ),
            ),


           const SizedBox(height: 10),
            SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: CustomGradientButton(
                    text: 'Отправить',
                    onPressed: () {
                     Navigator.pop(context);
                    },
                  ),
                ),
            
          ],
        ),
      ),
    );
  }
}