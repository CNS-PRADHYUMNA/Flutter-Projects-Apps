import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './model.dart';

class SNPDATA extends StatefulWidget {
  const SNPDATA({super.key});

  @override
  State<SNPDATA> createState() => _SNPDATAState();
}

class _SNPDATAState extends State<SNPDATA> {
  final List<String> snps = [
    'AX-94462858',
    'AX-95071247',
    'AX-94646188',
    'AX-94776946',
    'AX-94702181',
    'AX-94477591',
    'AX-94710748',
    'AX-94440104',
    'AX-94480569',
    'AX-94524677',
    'AX-94547219',
    'AX-94670667',
    'AX-94572618',
    'AX-94663690',
    'AX-94998259',
    'AX-94475556',
    'AX-94534637',
    'AX-94823460',
    'AX-94978875',
    'AX-95224988',
    'AX-94944591',
    'AX-94541833',
    'AX-94628115',
    'AX-94981573'
  ];
  final List<int> pos = [
    553146272,
    143438568,
    78343644,
    647927975,
    105412667,
    635264767,
    326464823,
    59213510,
    478555437,
    514593813,
    513572057,
    479876161,
    591524581,
    45354900,
    555325353,
    586102229,
    517524441,
    86398896,
    25633098,
    547810743,
    157862189,
    3740808,
    462228297,
    116377176
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Gene Info",
            style: GoogleFonts.alegreya(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  border: TableBorder.all(color: Colors.white),
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                          child: Container(
                            padding: const EdgeInsets.all(2.0),
                            alignment: Alignment.center,
                            child: const Text('🧬SNP',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            padding: const EdgeInsets.all(2.0),
                            alignment: Alignment.center,
                            child: const Text('📍Position',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                    for (int index = 0; index < snps.length; index++)
                      TableRow(
                        children: [
                          TableCell(
                            child: Container(
                              padding: const EdgeInsets.all(2.0),
                              alignment: Alignment.center,
                              child: Text(snps[index],
                                  style: const TextStyle(color: Colors.white)),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              padding: const EdgeInsets.all(5.5),
                              alignment: Alignment.center,
                              child: Text(pos[index].toString(),
                                  style: const TextStyle(color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => FNNModelApp()));
                  },
                  child: Text(
                    "Let's Start Predictions 🌾",
                    style: GoogleFonts.alegreya(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
