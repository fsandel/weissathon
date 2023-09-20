import 'package:flutter/material.dart';
import 'package:weiss/screen/machine_main_menu.dart';

class EverythingOkay extends StatefulWidget {
  const EverythingOkay({Key? key}) : super(key: key);

  @override
  State<EverythingOkay> createState() => _EverythingOkayState();
}

class _EverythingOkayState extends State<EverythingOkay> {
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
          color: Color.fromARGB(255, 0, 127, 40),
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
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
                    Icons.check,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Alles in Ordnung",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Es wurden keine Fehler erkannt.",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
