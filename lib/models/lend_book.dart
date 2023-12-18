// To parse this JSON data, do
//
//     final oneBook = oneBookFromJson(jsonString);

import 'dart:convert';

List<OneBook> oneBookFromJson(String str) => List<OneBook>.from(json.decode(str).map((x) => OneBook.fromJson(x)));

String oneBookToJson(List<OneBook> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OneBook {
    Model model;
    int pk;
    Fields fields;

    OneBook({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory OneBook.fromJson(Map<String, dynamic> json) => OneBook(
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
    int book;
    DateTime startDate;
    DateTime endDate;
    int number;

    Fields({
        required this.user,
        required this.book,
        required this.startDate,
        required this.endDate,
        required this.number,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        book: json["book"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        number: json["number"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "book": book,
        "start_date": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "number": number,
    };
}

enum Model {
    // ignore: constant_identifier_names
    LEND_LEND
}

final modelValues = EnumValues({
    "lend.lend": Model.LEND_LEND
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
