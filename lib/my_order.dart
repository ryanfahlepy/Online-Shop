import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:wk/currency_format.dart';

import 'checkout.dart';

class MyOrder extends StatelessWidget {
  final _descriptionController = TextEditingController();

  Future checkOut() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('users-checkout');
    return _collectionRef
        .doc(currentUser!.email)
        .collection('items')
        .doc()
        .set({
      'status': 'waiting',
      'description': _descriptionController.text.trim(),
    }).then((value) => print('Checkout'));
  }

  num total = 0;
  @override
  void dispose() {
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          'My Cart',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users-cart-items')
                      .doc(FirebaseAuth.instance.currentUser!.email)
                      .collection('items')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading");
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot _documentSnapshot =
                            snapshot.data!.docs[index];
                        return Card(
                          elevation: 0,
                          child: ListTile(
                            contentPadding: EdgeInsets.only(
                                top: 10, bottom: 10, left: 10, right: 10),
                            trailing: GestureDetector(
                              child: CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.cancel_rounded,
                                  size: 20,
                                  color: Color.fromARGB(255, 151, 4, 2),
                                ),
                              ),
                              onTap: () {
                                FirebaseFirestore.instance
                                    .collection('users-cart-items')
                                    .doc(FirebaseAuth
                                        .instance.currentUser!.email)
                                    .collection('items')
                                    .doc(_documentSnapshot.id)
                                    .delete();
                              },
                            ),
                            leading: Container(
                              child: Image.network(
                                _documentSnapshot['image'],
                              ),
                              height: 200,
                              width: 100,
                            ),
                            title: Text(
                              _documentSnapshot['name'].toString(),
                              style: GoogleFonts.raleway(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  _documentSnapshot['quantity'].toString(),
                                  style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  width: 70,
                                ),
                                Text(
                                  CurrencyFormat.convertToIdr(
                                      (_documentSnapshot['price'] *
                                          _documentSnapshot['quantity']),
                                      0),
                                  style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25), topLeft: Radius.circular(25)),
              boxShadow: [
                BoxShadow(
                  blurRadius: 8,
                  color: Colors.black.withOpacity(.2),
                  offset: Offset(0, -4),
                ),
              ],
            ),
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(25)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  hintText: 'Description (ex : Sepatu PDL No.42)',
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 20),
            color: Colors.white,
            height: 80,
            child: Container(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users-cart-items')
                    .doc(FirebaseAuth.instance.currentUser!.email)
                    .collection('items')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  } else {
                    snapshot.data!.docs.forEach((result) {
                      total += result['price'] * result['quantity'];
                    });
                    return Container(
                      padding: EdgeInsets.only(left: 25, right: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: GoogleFonts.raleway(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            CurrencyFormat.convertToIdr((total), 0),
                            style: GoogleFonts.poppins(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 20),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 75.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CheckOut(
                              description: _descriptionController.text.trim(),
                              price: total.toInt())));
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 151, 4, 2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Text(
                      "Checkout",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
