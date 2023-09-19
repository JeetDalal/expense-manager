import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/utils/data_provider.dart';
import 'package:provider/provider.dart';

class Records extends StatelessWidget {
  const Records({super.key});

  @override
  Widget build(BuildContext context) {
    final dateProvider = Provider.of<DataProvider>(context);
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('dd MMMM,yyyy').format(dateProvider.rawDate),
              style: Theme.of(context).primaryTextTheme.titleLarge,
            ),
            const Divider(
              color: Colors.grey,
              thickness: 2,
            ),
            ListTile(
              leading: CircleAvatar(backgroundColor: Colors.green),
              title: Text(
                'Zomato Order',
                style: Theme.of(context).primaryTextTheme.titleLarge!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
              ),
              subtitle: Text(
                'Pizza Hut',
                style: Theme.of(context).primaryTextTheme.titleLarge!.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
