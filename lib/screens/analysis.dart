import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/utils/data_provider.dart';
import 'package:provider/provider.dart';

class Analysis extends StatefulWidget {
  const Analysis({super.key});

  @override
  State<Analysis> createState() => _AnalysisState();
}

class _AnalysisState extends State<Analysis> {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final p = Provider.of<DataProvider>(context, listen: false);
      p.moneyTransactionListByCategory();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    List<Color?> colors = [
      Colors.green[400],
      Colors.blue[400],
      Colors.yellow[400],
      Colors.orange[400],
    ];
    // dataProvider.moneyTransactionListByCategory();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: PieChart(
                  PieChartData(
                    centerSpaceRadius: 10,
                    borderData: FlBorderData(show: false),
                    sectionsSpace: 2,
                    sections: List.generate(dataProvider.categoryData.length,
                        (index) {
                      return PieChartSectionData(
                        value: dataProvider.categoryData[index]['total'],
                        // title: 'Food',
                        color: colors[index],
                        // titlePositionPercentageOffset: 6,
                        showTitle: true,
                        // titleStyle: Theme.of(context).primaryTextTheme.titleLarge,
                        radius: 70,
                      );
                    }),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
                width: 100,
                child: ListView.builder(
                    itemCount: dataProvider.categoryData.length,
                    itemBuilder: (context, index) {
                      var data = dataProvider.categoryData[index];
                      return Row(
                        children: [
                          CircleAvatar(
                            radius: 10,
                            backgroundColor: colors[index],
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(
                            data['tCat'],
                            style: Theme.of(context)
                                .primaryTextTheme
                                .titleLarge!
                                .copyWith(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16),
                          )
                        ],
                      );
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
