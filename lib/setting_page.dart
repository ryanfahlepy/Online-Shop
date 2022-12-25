import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wk/about.dart';
import 'package:wk/change_email.dart';
import 'package:wk/change_password.dart';
import 'package:wk/profile_image.dart';
import 'package:wk/theme.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

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
          'Setting',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(25),
        child: Column(children: [
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "Profile",
              style: GoogleFonts.raleway(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 151, 4, 2),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileImage()));
            },
            child: Container(
              height: 50,
              child: Card(
                shadowColor: Colors.black,
                elevation: 4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "   Profile Image",
                      style: GoogleFonts.raleway(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios_rounded)
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 0),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChangeEmail()));
            },
            child: Container(
              height: 50,
              child: Card(
                shadowColor: Colors.black,
                elevation: 4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "   Change Email",
                      style: GoogleFonts.raleway(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios_rounded)
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChangePassword()));
            },
            child: Container(
              height: 50,
              child: Card(
                shadowColor: Colors.black,
                elevation: 4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "   Change Password",
                      style: GoogleFonts.raleway(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios_rounded)
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "App",
              style: GoogleFonts.raleway(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 151, 4, 2),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          /*
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ThemePage()));
            },
            child: Container(
              height: 50,
              child: Card(
                shadowColor: Colors.black,
                elevation: 4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "   Theme",
                      style: GoogleFonts.raleway(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios_rounded)
                  ],
                ),
              ),
            ),
          ),*/
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AboutPage()));
            },
            child: Container(
              height: 50,
              child: Card(
                shadowColor: Colors.black,
                elevation: 4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "   About",
                      style: GoogleFonts.raleway(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios_rounded)
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
