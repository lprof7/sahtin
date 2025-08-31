import 'package:hive/hive.dart';
import 'package:food_app/data/models/dish.dart';

import 'package:flutter/material.dart';

class Dish {
  final String uid;
  final String name;
  final String description;
  final int kal;
  final Rating rating;
  final List<Option> options;
  final String picture;
  final String category;

  Dish({
    required this.uid,
    required this.name,
    required this.description,
    required this.kal,
    required this.rating,
    required this.options,
    required this.picture,
    required this.category,
  });

  factory Dish.fromJson(Map<String, dynamic> json) {
    return Dish(
      uid: json['uid'],
      name: json['name'],
      description: json['description'],
      kal: json['kal'],
      rating: Rating.fromJson(json['rating']),
      options:
          (json['options'] as List).map((i) => Option.fromJson(i)).toList(),
      picture: json['picture'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'description': description,
      'kal': kal,
      'rating': rating.toJson(),
      'options': options.map((i) => i.toJson()).toList(),
      'picture': picture,
      'category': category,
    };
  }
}

class Rating {
  final double stars;
  final int ratingsNumber;

  Rating({required this.stars, required this.ratingsNumber});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(stars: json['stars'], ratingsNumber: json['ratingsNumber']);
  }

  Map<String, dynamic> toJson() {
    return {'stars': stars, 'ratingsNumber': ratingsNumber};
  }
}

class Option {
  final String name;
  final double price;

  Option({required this.name, required this.price});

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(name: json['name'], price: json['price']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'price': price};
  }
}

// Dish adapter
class DishAdapter extends TypeAdapter<Dish> {
  @override
  final int typeId = 0; // Unique ID for this adapter

  @override
  Dish read(BinaryReader reader) {
    final Map<String, dynamic> json = Map<String, dynamic>.from(
      reader.readMap(),
    );
    return Dish.fromJson(json);
  }

  @override
  void write(BinaryWriter writer, Dish obj) {
    writer.writeMap(obj.toJson());
  }
}

// Rating adapter
class RatingAdapter extends TypeAdapter<Rating> {
  @override
  final int typeId = 1; // Unique ID for this adapter

  @override
  Rating read(BinaryReader reader) {
    final Map<String, dynamic> json = Map<String, dynamic>.from(
      reader.readMap(),
    );
    return Rating.fromJson(json);
  }

  @override
  void write(BinaryWriter writer, Rating obj) {
    writer.writeMap(obj.toJson());
  }
}

// Option adapter
class OptionAdapter extends TypeAdapter<Option> {
  @override
  final int typeId = 2; // Unique ID for this adapter

  @override
  Option read(BinaryReader reader) {
    final Map<String, dynamic> json = Map<String, dynamic>.from(
      reader.readMap(),
    );
    return Option.fromJson(json);
  }

  @override
  void write(BinaryWriter writer, Option obj) {
    writer.writeMap(obj.toJson());
  }
}
