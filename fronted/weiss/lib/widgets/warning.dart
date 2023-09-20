import 'package:flutter/material.dart';
import 'package:weiss/screen/machine_main_menu.dart';

class Warning extends StatefulWidget {
  const Warning({super.key});

  @override
  State<Warning> createState() => _WarningState();
}

class _WarningState extends State<Warning> {
  double deviceHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MachineMainMenu()),
        );
      },
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 249, 46, 46), // Set the background color
          borderRadius: BorderRadius.circular(20.0), // Set the border radius
        ),
        margin: EdgeInsets.all(20),
        width: deviceWidth(context) * 0.9,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(4),
                  child: Icon(
                    Icons.warning,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Warnung!",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      "Es wurden Unregelmäßigkeiten erkannt!",
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                )
              ],
            ),
            Row(
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 14),
                  ),
                  onPressed: null,
                  child: const Text('Mehr Informationen'),
                ),
                SizedBox(
                  width: 12,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 14),
                  ),
                  onPressed: null,
                  child: const Text('Meldung schließen'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
