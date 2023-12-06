import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mutualibri/models/review_models.dart';
import 'package:mutualibri/screens/review_add.dart';

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
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              ReviewData newReview = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReviewAddPage()),
              );

              if (newReview != null) {
                setState(() {
                  reviews.add(newReview);
                });
              }
            },
            child: Text('Add Review'),
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: reviews.map((review) {
                return ReviewCard(
                  username: 'user', // You may need to adjust this
                  title: review.title,
                  rating: review.rating,
                  review: review.review,
                );
              }).toList(),
            ),
          ),
        ],
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
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '@$username',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8),
            ],
          ),
          Container(
            height: 2.0,
            color: Colors.black,
            margin: EdgeInsets.symmetric(vertical: 8),
          ),
          SizedBox(height: 8),
          Text(
            'Title: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text('$title'),
          SizedBox(height: 8),
          Row(
            children: [
              Text(
                'Rating: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              RatingBarIndicator(
                rating: rating,
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 20.0,
                unratedColor: Colors.grey[300]!,
                direction: Axis.horizontal,
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'Review: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '$review',
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
