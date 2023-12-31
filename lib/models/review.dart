// To parse this JSON data, do
//
//     final review = reviewFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'dart:convert';

List<Review> reviewFromJson(String str) =>
    List<Review>.from(json.decode(str).map((x) => Review.fromJson(x)));

String reviewToJson(List<Review> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Review {
  Model model;
  int pk;
  Fields fields;

  Review({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        model: modelValues.map[json["model"]]!,
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "model": modelValues.reverse[model],
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  int user;
  String username;
  // dynamic books;
  String title;
  String review;
  int rating;
  DateTime dateAdded;

  Fields({
    required this.user,
    required this.username,
    // required this.books,
    required this.title,
    required this.review,
    required this.rating,
    required this.dateAdded,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        username: json["username"],
        // books: json["books"],
        title: json["title"],
        review: json["review"],
        rating: json["rating"],
        dateAdded: DateTime.parse(json["date_added"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "username": username,
        // "books": books,
        "title": title,
        "review": review,
        "rating": rating,
        "date_added":
            "${dateAdded.year.toString().padLeft(4, '0')}-${dateAdded.month.toString().padLeft(2, '0')}-${dateAdded.day.toString().padLeft(2, '0')}",
      };
}

enum Model { REVIEW_ITEM }

final modelValues = EnumValues({"review.item": Model.REVIEW_ITEM});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
