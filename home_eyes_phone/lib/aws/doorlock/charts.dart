import 'package:flutter/material.dart';
import 'package:flutter_charts/flutter_charts.dart';
import 'package:provider/provider.dart';
import 'package:home_eyes/aws/app_state.dart';

class UnlockEventsBarChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, state, child) {
        if (state.unlocksPerDay.isEmpty) {
          return Center(child: Text('No unlock events data available.'));
        }

        // Prepare data for the chart
        var labels = state.unlocksPerDay.keys.toList();
        var data = state.unlocksPerDay.values.toList();

        var chartData = ChartData(
          dataRows: [data.map((e) => e.toDouble()).toList()],
          xUserLabels: labels,
          dataRowsLegends: ['Unlocks'],
          chartOptions: ChartOptions(),
        );

        var xContainerLabelLayoutStrategy =
            DefaultIterativeLabelLayoutStrategy(options: ChartOptions());

        VerticalBarChartTopContainer verticalBarChartContainer =
            VerticalBarChartTopContainer(
          chartData: chartData,
          xContainerLabelLayoutStrategy: xContainerLabelLayoutStrategy,
        );

        VerticalBarChart verticalBarChart = VerticalBarChart(
          painter: VerticalBarChartPainter(
            verticalBarChartContainer: verticalBarChartContainer,
          ),
        );

        return Container(
          height: 300,
          child: verticalBarChart,
        );
      },
    );
  }
}
