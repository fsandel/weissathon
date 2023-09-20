import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weiss/screen/historical_data_screen.dart';

class HistoricalDataCollection extends StatelessWidget {
  const HistoricalDataCollection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        child: ListView(
          children: [
            _buildButton(
              context,
              'Temperature',
              const Color.fromARGB(255, 76, 110, 62),
              variable1: 'temperature', // Hier Variablen hinzufügen
            ),
            _buildButton(
              context,
              'Current voltage',
              const Color.fromARGB(255, 76, 110, 62),
              variable1: 'current', // Hier andere Variablen hinzufügen
            ),
            // Add a floating action button
          ],
        ),
      ),
    );
  }

  Widget _buildButton(
      BuildContext context, String buttonText, Color buttonColor,
      {required String variable1}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 20.0), // Add margin
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            // Hier Variablen an HistoricalDataScreen übergeben
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => HistoricalDataScreen(
                  dataType: variable1,
                ),
              ),
            );
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0), // Rounded corners
              ),
            ),
          ),
          child: Container(
            width:
                double.infinity, // Button takes full width inside the Container
            alignment: Alignment.center,
            child: Text(
              buttonText,
              style: GoogleFonts.lato(
                // Apply Google Fonts (Lato)
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0, // Adjust the font size as needed
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
