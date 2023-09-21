import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:weiss/api/request.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:weiss/services/api_service.dart';
import 'package:weiss/widgets/custom_app_bar.dart';

class HistoricalDataScreen extends StatefulWidget {
  final String dataType;

  const HistoricalDataScreen({Key? key, required this.dataType})
      : super(key: key);

  @override
  State<HistoricalDataScreen> createState() => _HistoricalDataScreenState();
}

class _HistoricalDataScreenState extends State<HistoricalDataScreen> {
  List<dynamic> data = []; // Store the fetched data

  @override
  void initState() {
    super.initState();
    fetchData(); // Fetch data when the screen is initialized
  }

  Future<void> fetchData() async {
    try {
      final List fetchedData = await DataService.fetchData();
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
    return Scaffold(
      appBar: CustomAppBar(
        customTitle: "TC514203",
      ),
      body: LiquidPullToRefresh(
        onRefresh: fetchData,
        color: const Color.fromARGB(255, 241, 229, 7),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              margin: const EdgeInsets.symmetric(vertical: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 241, 229, 7),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: SfSparkLineChart(
                  axisLineWidth: 0,
                  data: data.isNotEmpty
                      ? data
                          .map((item) => widget.dataType == 'temperature'
                              ? item.temperature['value']
                              : item.current['value'])
                          .expand((i) => i)
                          .toList()
                          .cast<double>()
                      : [],
                  highPointColor: Colors.red,
                  lowPointColor: Colors.red,
                  firstPointColor: Colors.orange,
                  lastPointColor: Colors.orange,
                  width: 3,
                  marker: const SparkChartMarker(
                    displayMode: SparkChartMarkerDisplayMode.all,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final Data itemData = data[index];
                    final List<dynamic> timeList =
                        widget.dataType == 'temperature'
                            ? itemData.temperature['time']
                            : itemData.current['time'];
                    final List<dynamic> valueList =
                        widget.dataType == 'temperature'
                            ? itemData.temperature['value']
                            : itemData.current['value'];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: timeList.length,
                          itemBuilder: (context, timeIndex) {
                            final String time = timeList[timeIndex].toString();
                            final double value =
                                valueList[timeIndex].toDouble();

                            return Container(
                              color: timeIndex % 2 == 0
                                  ? Colors.grey[100]
                                  : Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                children: [
                                  Text("${time}:"),
                                  const SizedBox(width: 4),
                                  Text(
                                    value.toString(),
                                    style: const TextStyle(color: Colors.green),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
