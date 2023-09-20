import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:weiss/api/request.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class HistoricalDataScreen extends StatefulWidget {
  const HistoricalDataScreen({super.key});

  @override
  State<HistoricalDataScreen> createState() => _HistoricalDataScreenState();
}

class _HistoricalDataScreenState extends State<HistoricalDataScreen> {
  List<double> data = []; // Store the fetched data

  @override
  void initState() {
    super.initState();
    fetchData(); // Fetch data when the screen is initialized
  }

  Future<void> fetchData() async {
    try {
      final List<double> fetchedData = await Request.fetchData();
      setState(() {
        data = fetchedData;
      });
    } catch (e) {
      // Handle errors
      debugPrint("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      onRefresh: fetchData,
      color: Color.fromARGB(255, 241, 229, 7),
      child: Column(
        children: [
          Container(
            width:
                MediaQuery.of(context).size.width * 0.9, // 90% of screen width
            margin: EdgeInsets.symmetric(vertical: 12),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 158, 212, 255),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: SfSparkLineChart(
                axisLineWidth: 0,
                data: data,
                highPointColor: Colors.red,
                lowPointColor: Colors.red,
                firstPointColor: Colors.orange,
                lastPointColor: Colors.orange,
                width: 3,
                marker: SparkChartMarker(
                  displayMode: SparkChartMarkerDisplayMode.all,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white, // Set the background color for the list
              child: ListView.builder(
                padding: EdgeInsets.all(12),
                itemCount: data.length, // Use the length of the fetched data
                itemBuilder: (context, index) {
                  final double value = data[index];
                  return Container(
                    color: index % 2 == 0
                        ? Colors.grey[100] // Set background color for even rows
                        : Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        Text("${index + 1}:"),
                        SizedBox(width: 4),
                        Text(
                          value.toString(), // Display the full number
                          style: TextStyle(color: Colors.green),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
