import 'dart:ffi';
import 'package:cool_alert/cool_alert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wk/currency_format.dart';
import 'package:wk/main_page.dart';

class ProductDetail extends StatefulWidget {
  final product_detail_name;
  final product_detail_image;
  final product_detail_price;

  ProductDetail({
    this.product_detail_name,
    this.product_detail_image,
    this.product_detail_price,
  });

  @override
  State<ProductDetail> createState() => _ProductDetailState();
  final data = MainPage;
}

class _ProductDetailState extends State<ProductDetail> {
  Future addtoCart() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('users-cart-items');
    return _collectionRef
        .doc(currentUser!.email)
        .collection('items')
        .doc()
        .set({
      'image': widget.product_detail_image,
      'name': widget.product_detail_name,
      'price': widget.product_detail_price,
      'quantity': count,
    }).then((value) => print("Added to Cart"));
  }

  int count = 1;

  void addCount() {
    count = count + 1;
    setState(() {});
  }

  void removeCount() {
    if (count != 1) {
      count = count - 1;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Product Detail"),
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
      ),
      body: ListView(
        children: [
          Container(
            height: 400,
            child: GridTile(
              child: Container(
                  color: Colors.white,
                  child: Image.network(widget.product_detail_image)),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height / 2.5,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 8,
                    color: Colors.black.withOpacity(.2),
                    offset: Offset(0, -4),
                  ),
                ],
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, right: 20, left: 24),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.product_detail_name,
                              style: GoogleFonts.raleway(
                                fontSize: 24,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 25, right: 30),
                      child: Row(
                        children: [
                          Text(
                            CurrencyFormat.convertToIdr(
                                widget.product_detail_price, 0),
                            style: GoogleFonts.poppins(
                                color: Color.fromARGB(255, 151, 4, 2),
                                fontSize: 24,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 25),
                      child: Text(
                        'Quantity',
                        style: GoogleFonts.raleway(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.only(left: 10)),
                        IconButton(
                          onPressed: removeCount,
                          icon: const Icon(
                            Icons.remove_circle_outline,
                            color: Color.fromARGB(255, 151, 4, 2),
                            size: 30,
                          ),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Text(
                          count.toString(),
                          style: TextStyle(
                              color: Color.fromARGB(255, 151, 4, 2),
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        IconButton(
                            onPressed: addCount,
                            icon: const Icon(
                              Icons.add_circle_outline,
                              color: Color.fromARGB(255, 151, 4, 2),
                              size: 30,
                            )),
                      ],
                    )),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 30),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(.07),
                                offset: Offset(0, -3),
                                blurRadius: 12,
                                blurStyle: BlurStyle.outer),
                          ]),
                      child: Row(
                        children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Total"),
                              Text(
                                CurrencyFormat.convertToIdr(
                                    (widget.product_detail_price * count), 0),
                                style: GoogleFonts.poppins(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          )),
                          Material(
                            color: Color.fromARGB(255, 233, 231, 231),
                            borderRadius: BorderRadius.circular(25),
                            child: InkWell(
                              onTap: () {
                                addtoCart();
                                CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.success,
                                  text: "Product Added to Your Cart",
                                  title: "Great",
                                  onConfirmBtnTap: () {
                                    Navigator.pop(context);
                                  },
                                  confirmBtnColor:
                                      Color.fromARGB(255, 151, 4, 2),
                                  confirmBtnText: 'OK',
                                  backgroundColor: Colors.white,
                                  width: 100,
                                );
                              },
                              borderRadius: BorderRadius.circular(25),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 151, 4, 2),
                                    borderRadius: BorderRadius.circular(25)),
                                child: Text(
                                  'Add to Cart',
                                  style: GoogleFonts.raleway(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ]),
            ),
          ),
        ],
      ),
      /*
      */
    );
  }
}
