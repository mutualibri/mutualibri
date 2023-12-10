import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mutualibri/models/review_models.dart';
import 'package:mutualibri/screens/review_form.dart';

class ReviewPage extends StatefulWidget {
  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  List<ReviewData> reviews = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            Text("Add your own book review here!"),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                ReviewData newReview = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReviewFormPage()),
                );

                if (newReview != null) {
                  setState(() {
                    reviews.add(newReview);
                  });
                }
              },
              child: Text('Add Review'),
            ),
            Expanded(
              child: ListView(
                children: reviews.map((review) {
                  return ReviewCard(
                    username: 'user',
                    title: review.title,
                    rating: review.rating,
                    review: review.review,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class ReviewCard extends StatelessWidget {
  final String username;
  final String title;
  final double rating;
  final String review;

  ReviewCard({
    required this.username,
    required this.title,
    required this.rating,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16, left: 16, right: 16),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.person,
                size: 18,
              ),
              SizedBox(width: 8),
              Text(
                '@$username',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Container(
            height: 2.0,
            color: Colors.black,
            margin: EdgeInsets.symmetric(vertical: 8),
          ),
          SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Title: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  '$title',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Text(
                'Rating: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8),
              RatingBarIndicator(
                rating: rating,
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 20.0,
                unratedColor: Colors.grey[300],
                direction: Axis.horizontal,
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Review: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  '$review',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
