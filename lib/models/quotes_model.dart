// To parse this JSON data, do
//
//     final quote = quoteFromJson(jsonString);

import 'dart:convert';

List<Quote> quoteFromJson(String str) =>
    List<Quote>.from(json.decode(str).map((x) => Quote.fromJson(x)));

String quoteToJson(List<Quote> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Quote {
  String model;
  int pk;
  Fields fields;

  Quote({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  int user;
  String bookName;
  String quotes;

  Fields({
    required this.user,
    required this.bookName,
    required this.quotes,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        bookName: json["book_name"],
        quotes: json["quotes"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "book_name": bookName,
        "quotes": quotes,
      };
}
