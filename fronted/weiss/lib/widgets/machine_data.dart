import 'package:flutter/material.dart';
import 'package:weiss/screen/machine_main_menu.dart';
import 'package:google_fonts/google_fonts.dart';

class MachineData extends StatefulWidget {
  const MachineData({super.key});

  @override
  State<MachineData> createState() => _MachineDataState();
}

class _MachineDataState extends State<MachineData> {
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
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 102, 255, 102), // Set the background color
          borderRadius: BorderRadius.circular(20.0), // Set the border radius
        ),
        margin: EdgeInsets.all(20),
        width: deviceWidth(context) * 0.9,
        height: 90,
        child: Row(
          children: [
            Container(
                padding: EdgeInsets.all(4),
                child: Image(image: AssetImage('assets/tc320t.png'))),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "TC514203",
                  style: GoogleFonts.lato(
                      textStyle:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Status: Funktionsfähig",
                  style: GoogleFonts.lato(
                      textStyle:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w300)),
                ),
                Text(
                  "Standort: Halle B, OG",
                  style: GoogleFonts.lato(
                      textStyle:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w300)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
