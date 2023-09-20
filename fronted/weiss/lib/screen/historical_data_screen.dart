import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class HistoricalDataScreen extends StatefulWidget {
  const HistoricalDataScreen({super.key});

  @override
  State<HistoricalDataScreen> createState() => _HistoricalDataScreenState();
}

class _HistoricalDataScreenState extends State<HistoricalDataScreen> {
  Future<void> _handleRefresh() async {
    debugPrint("Hi");
  }

  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      // key if you want to add
      onRefresh: _handleRefresh,
      color: Color.fromARGB(255, 241, 229, 7), // refresh callback
      child: ListView(), // scroll view
    );
  }
}
