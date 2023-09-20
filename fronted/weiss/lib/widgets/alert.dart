import 'package:flutter/material.dart';
import 'package:weiss/screen/machine_main_menu.dart';

class Alert extends StatefulWidget {
  const Alert({super.key});

  @override
  State<Alert> createState() => _AlertState();
}

class _AlertState extends State<Alert> {
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
          color: Color.fromARGB(255, 148, 151, 2), // Set the background color
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
                    Icons.sim_card_alert,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hinweis!",
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
