import 'package:flutter/material.dart';

class Category {
  String catName;
  IconData icon;

  Category({required this.catName, required this.icon});
}

List<Category> categories = [
  Category(
    catName: 'Food',
    icon: Icons.food_bank,
  ),
  Category(
    catName: 'Shopping',
    icon: Icons.shopping_bag,
  ),
  Category(
    catName: 'Grocery',
    icon: Icons.local_grocery_store,
  ),
  Category(
    catName: 'Leisure',
    icon: Icons.movie,
  ),
];
