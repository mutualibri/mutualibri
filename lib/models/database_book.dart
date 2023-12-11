// To parse this JSON data, do
//
//     final book = bookFromJson(jsonString);

import 'dart:convert';

List<Book> bookFromJson(String str) => List<Book>.from(json.decode(str).map((x) => Book.fromJson(x)));

String bookToJson(List<Book> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Book {
    int pk;
    Model model;
    Fields fields;

    Book({
        required this.pk,
        required this.model,
        required this.fields,
    });

    factory Book.fromJson(Map<String, dynamic> json) => Book(
        pk: json["pk"],
        model: modelValues.map[json["model"]]!,
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "pk": pk,
        "model": modelValues.reverse[model],
        "fields": fields.toJson(),
    };
}

class Fields {
    int number;
    String title;
    String author;
    double? rating;
    double? voters;
    double price;
    Currency currency;
    String description;
    String publisher;
    int pageCount;
    String generes;
    int? isbn;
    Language language;
    String publishedDate;
    String image;

    Fields({
        required this.number,
        required this.title,
        required this.author,
        required this.rating,
        required this.voters,
        required this.price,
        required this.currency,
        required this.description,
        required this.publisher,
        required this.pageCount,
        required this.generes,
        required this.isbn,
        required this.language,
        required this.publishedDate,
        required this.image,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        number: json["number"],
        title: json["title"],
        author: json["author"],
        rating: json["rating"]?.toDouble(),
        voters: json["voters"]?.toDouble(),
        price: json["price"]?.toDouble(),
        currency: currencyValues.map[json["currency"]]!,
        description: json["description"],
        publisher: json["publisher"],
        pageCount: json["page_count"],
        generes: json["generes"],
        isbn: json["ISBN"],
        language: languageValues.map[json["language"]]!,
        publishedDate: json["published_date"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "number": number,
        "title": title,
        "author": author,
        "rating": rating,
        "voters": voters,
        "price": price,
        "currency": currencyValues.reverse[currency],
        "description": description,
        "publisher": publisher,
        "page_count": pageCount,
        "generes": generes,
        "ISBN": isbn,
        "language": languageValues.reverse[language],
        "published_date": publishedDate,
        "image": image,
    };
}

enum Currency {
    FREE,
    SAR
}

final currencyValues = EnumValues({
    "Free": Currency.FREE,
    "SAR": Currency.SAR
});

enum Language {
    ENGLISH
}

final languageValues = EnumValues({
    "English": Language.ENGLISH
});

enum Model {
    BOOK_BOOK
}

final modelValues = EnumValues({
    "book.Book": Model.BOOK_BOOK
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
extension BookSearchExtension on Book {
  bool matchesQuery(String query) {
    // Check if any relevant fields match the search query
    return fields.title.toLowerCase().contains(query.toLowerCase()) ||
        fields.author.toLowerCase().contains(query.toLowerCase()) ||
        fields.generes.toLowerCase().contains(query.toLowerCase()) ||
        fields.description.toLowerCase().contains(query.toLowerCase());
  }
}
