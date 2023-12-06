import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mutualibri/models/review_models.dart';

class ReviewAddPage extends StatefulWidget {
  @override
  _ReviewAddPageState createState() => _ReviewAddPageState();
}

class _ReviewAddPageState extends State<ReviewAddPage> {
  TextEditingController titleController = TextEditingController();
  double rating = 0.0;
  TextEditingController reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Review'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text(
                  'Rating: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                RatingBar.builder(
                  initialRating: rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (newRating) {
                    setState(() {
                      rating = newRating;
                    });
                  },
                ),
                Text(rating.toString()),
              ],
            ),
            SizedBox(height: 16),
            TextField(
              controller: reviewController,
              maxLines: 3,
              decoration: InputDecoration(labelText: 'Review'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isEmpty || reviewController.text.isEmpty) {
                  _showErrorDialog('Please re-check your input, you might miss something!');
                } else if (reviewController.text.length > 1000) {
                  _showErrorDialog('Review should not exceed 1000 characters.');
                } else {
                  ReviewData newReview = ReviewData(
                    title: titleController.text,
                    rating: rating,
                    review: reviewController.text,
                  );

                  Navigator.pop(context, newReview);
                }
              },
              child: Text('Add Review'),
            ),
          ],
        ),
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
