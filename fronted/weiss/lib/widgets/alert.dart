import 'package:flutter/material.dart';
import 'package:weiss/screen/machine_main_menu.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weiss/services/notification_service.dart';
import 'package:weiss/widgets/custom_popup.dart';

class Alert extends StatefulWidget {
  const Alert({Key? key}) : super(key: key);

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
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 148, 151, 2),
          borderRadius: BorderRadius.circular(20.0),
        ),
        margin: const EdgeInsets.all(20),
        width: deviceWidth(context) * 0.9,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  child: const Icon(
                    Icons.build,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
                Flexible(
                  // Allow text to expand and wrap
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hinweis!",
                        style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Es wurden geringe Unregelmäßigkeiten erkannt!",
                        style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        softWrap: true, // Allow text to wrap to the next line
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 16), // Add spacing
            Row(
              children: [
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    textStyle: MaterialStateProperty.all(
                      const TextStyle(
                        fontSize: 14,
                        color: Colors.blue, // Change the link color as desired
                      ),
                    ),
                  ),
                  onPressed: () {
                    CustomPopup.showPopup(
                        context, "Attention", "Minor deviations were detected");
                  },
                  child: const Text('More Information'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
