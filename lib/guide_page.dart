import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Guide extends StatelessWidget {
  const Guide({super.key});

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
          'Guide',
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
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Alur Pembelian Produk",
                style: GoogleFonts.raleway(
                    fontSize: 25, fontWeight: FontWeight.w800),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "1. Kadet dapat melihat produk yang dijual di catalog\n\n2. Klik gambar produk untuk melihat detail produk\n\n3. Kadet dapat memasukkan produk kedalam troli belanja\n\n4. Checkout produk didalam troli belanja\n\n5. Upload bukti pembayaran sesuai nominal\n\n6. Klik Bayar",
                style: GoogleFonts.raleway(
                    fontSize: 15, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 70,
              ),
              Text("Simbol",
                  style: GoogleFonts.raleway(
                      fontSize: 25, fontWeight: FontWeight.w800)),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Icon(
                    Icons.book_rounded,
                    color: Color.fromARGB(255, 151, 4, 2),
                  ),
                  Text(" Catalog , laman produk yang dijual",
                      style: GoogleFonts.raleway(
                          fontSize: 15, fontWeight: FontWeight.w600)),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Icon(
                    Icons.shopping_cart_rounded,
                    color: Color.fromARGB(255, 151, 4, 2),
                  ),
                  Text(" My Cart , laman produk didalam troli belanja",
                      style: GoogleFonts.raleway(
                          fontSize: 15, fontWeight: FontWeight.w600))
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Icon(
                    Icons.settings_rounded,
                    color: Color.fromARGB(255, 151, 4, 2),
                  ),
                  Text(" Setting , laman pengaturan aplikasi",
                      style: GoogleFonts.raleway(
                          fontSize: 15, fontWeight: FontWeight.w600))
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Icon(
                    Icons.info_rounded,
                    color: Color.fromARGB(255, 151, 4, 2),
                  ),
                  Text(" Guide , laman panduan aplikasi",
                      style: GoogleFonts.raleway(
                          fontSize: 15, fontWeight: FontWeight.w600))
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Icon(
                    Icons.logout_rounded,
                    color: Color.fromARGB(255, 151, 4, 2),
                  ),
                  Text(" Logout , logout dan keluar aplikasi",
                      style: GoogleFonts.raleway(
                          fontSize: 15, fontWeight: FontWeight.w600))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
