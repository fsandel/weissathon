import 'package:flutter/material.dart';
import 'package:weiss/screen/historical_data_screen.dart';
import 'package:weiss/screen/live_data_screen.dart';
import 'package:weiss/widgets/custom_app_bar.dart';

/// Flutter code sample for [NavigationBar].

void main() => runApp(const MachineMainMenu());

class MachineMainMenu extends StatelessWidget {
  const MachineMainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: NavigationExample());
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(customTitle: "Maschinename"),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Color.fromARGB(255, 241, 229, 7),
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.perm_data_setting),
            label: 'Status',
          ),
          NavigationDestination(
            icon: Icon(Icons.data_usage),
            label: 'Daten',
          ),
        ],
      ),
      body: <Widget>[
        LiveDataScreen(),
        HistoricalDataScreen(),
      ][currentPageIndex],
    );
  }
}
