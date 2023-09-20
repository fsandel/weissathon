import 'package:flutter/material.dart';
import 'package:weiss/screen/machine_main_menu.dart';
import 'package:weiss/widgets/custom_popup.dart';
import 'package:google_fonts/google_fonts.dart';

class Warning extends StatefulWidget {
  const Warning({Key? key}) : super(key: key);

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
          color: Color.fromARGB(255, 255, 110, 110),
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
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align text to the left
              children: [
                Container(
                  padding: EdgeInsets.all(4),
                  child: Icon(
                    Icons.warning,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  // Allow the text to expand to the available width
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Warnung!",
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Es wurden Unregelmäßigkeiten erkannt",
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        softWrap: true, // Allow text to wrap to the next line
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    textStyle: MaterialStateProperty.all(
                      TextStyle(
                        fontSize: 14,
                        color: Colors.blue, // Change the link color as desired
                      ),
                    ),
                  ),
                  onPressed: () {
                    CustomPopup.showPopup(context, "Hallo", "Welt");
                  },
                  child: Text('Mehr Informationen'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
