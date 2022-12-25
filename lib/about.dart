import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 151, 4, 2),
        elevation: 4.0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'About',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
          )
        ],
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "created by :",
            style:
                GoogleFonts.raleway(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Abigail Tifani Manullang",
            style:
                GoogleFonts.raleway(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Abigail Tifani Manullang",
            style:
                GoogleFonts.raleway(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Alfian Habib Ahmed",
            style:
                GoogleFonts.raleway(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Rendi Hanif Dhaifullah",
            style:
                GoogleFonts.raleway(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Ryan Fahlepy Sinaga",
            style:
                GoogleFonts.raleway(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Tegar Pandu Satria",
            style:
                GoogleFonts.raleway(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            "Informatika Militer Cohort - 2",
            style:
                GoogleFonts.raleway(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          Text(
            "Fakultas Teknik Militer",
            style:
                GoogleFonts.raleway(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          Text(
            "Universitas Pertahanan Republik Indonesia",
            style:
                GoogleFonts.raleway(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "2022 \u00a9 Kelompok 1",
            style:
                GoogleFonts.raleway(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      )),
    );
  }
}
