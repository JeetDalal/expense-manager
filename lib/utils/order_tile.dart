import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  final String title;
  final double amount;
  final String type;
  final String desc;
  final String date;
  final String cat;
  const OrderTile({
    required this.amount,
    required this.cat,
    required this.date,
    required this.desc,
    required this.title,
    required this.type,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    late IconData icon;
    switch (cat) {
      case "Food":
        icon = Icons.food_bank;
        break;
      case "Leisure":
        icon = Icons.movie;
        break;
      case "Shopping":
        icon = Icons.shopping_bag;
        break;
      case "Grocery":
        icon = Icons.shopping_cart;
        break;
    }
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.yellow,
        size: 50,
      ),
      title: Text(
        title,
        style: Theme.of(context).primaryTextTheme.titleLarge!.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
      ),
      subtitle: Text(
        desc,
        style: Theme.of(context).primaryTextTheme.titleLarge!.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              color: Colors.blueGrey[500],
            ),
      ),
      trailing: Text(
        (type == "Expense" ? "-\$ " : "\$ ") + amount.toStringAsFixed(2),
        style: TextStyle(
          color: type == "Expense"
              ? Colors.red[400]
              : Theme.of(context).colorScheme.secondary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
