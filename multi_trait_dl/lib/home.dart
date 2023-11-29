import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_trait_dl/snp.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(103, 5, 7, 6),
      body: Container(
        padding: EdgeInsets.all(50),
        // alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "🧬 Genomic Precision",
              style: GoogleFonts.alegreyaSans(
                  fontSize: 38,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              "Harness the genetic potential of Triticum Aestivum like never before.Our state-of-the-art algorithms analyze the wheat genome to make predictions with unmatched accuracy.",
              style: GoogleFonts.alegreya(
                  fontStyle: FontStyle.italic,
                  fontSize: 25,
                  wordSpacing: 3,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 35,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SNPDATA()));
              },
              child: Text(
                "Get Started",
                style: GoogleFonts.alegreya(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
