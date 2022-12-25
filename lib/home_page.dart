import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:wk/about.dart';
import 'package:wk/guide_page.dart';
import 'package:wk/my_order.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wk/setting_page.dart';
import 'firebase_options.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'main_page.dart';
import 'product_detail.dart';
import 'package:wk/currency_format.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Stream<QuerySnapshot> _products =
      FirebaseFirestore.instance.collection('products').snapshots();
  final currentUser = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GNav(
        backgroundColor: Colors.white,
        activeColor: Color.fromARGB(255, 151, 4, 2),
        // tab button ripple color when pressed
        // tab button hover color

        duration: Duration(milliseconds: 900), // tab animation duration
        // the tab button gap between icon and text

        iconSize: 24, // tab button icon size
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),

        tabs: [
          GButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyOrder()));
            },
            icon: Icons.shopping_cart,
            iconColor: Color.fromARGB(2551, 151, 4, 2),
          ),
          GButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
            icon: Icons.home,
            iconColor: Color.fromARGB(2551, 151, 4, 2),
          ),
          GButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Setting()));
            },
            icon: Icons.settings,
            iconColor: Color.fromARGB(2551, 151, 4, 2),
          )
        ],
      ),
      appBar: AppBar(
        title: const Text(
          "Catalog",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 151, 4, 2),
        elevation: 4.0,
        actions: [
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: IconButton(
              icon:
                  const Icon(Icons.shopping_cart_rounded, color: Colors.white),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyOrder()));
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .where('email', isEqualTo: currentUser.currentUser!.email)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text('Loading');
                  }
                  return SizedBox(
                    height: 230,
                    child: ListView(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        title:
                        Image.network(data['user-image']);
                        return Container(
                          height: 190,
                          padding: EdgeInsets.only(left: 20),
                          color: Color.fromARGB(255, 151, 4, 2),
                          width: double.infinity,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.only(right: 150),
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 38,
                                    backgroundImage: NetworkImage(
                                      data['user-image'],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                data['name'],
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                              Text(
                                data['email'],
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }),
            ListTile(
              leading: const Icon(Icons.book_rounded),
              iconColor: Color.fromARGB(255, 151, 4, 2),
              title: const Text("Catalog", style: TextStyle(fontSize: 17)),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              iconColor: Color.fromARGB(255, 151, 4, 2),
              title: const Text("My Cart", style: TextStyle(fontSize: 17)),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyOrder()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings_rounded),
              iconColor: Color.fromARGB(255, 151, 4, 2),
              title: const Text("Setting", style: TextStyle(fontSize: 17)),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Setting()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.rule_rounded),
              iconColor: Color.fromARGB(255, 151, 4, 2),
              title: const Text(
                "Guide",
                style: TextStyle(fontSize: 17),
              ),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Guide()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_rounded),
              iconColor: Color.fromARGB(255, 151, 4, 2),
              title: const Text(
                "About",
                style: TextStyle(fontSize: 17),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout_rounded),
              iconColor: Color.fromARGB(255, 151, 4, 2),
              title: const Text("Logout", style: TextStyle(fontSize: 17)),
              onTap: () {
                CoolAlert.show(
                  context: context,
                  type: CoolAlertType.warning,
                  title: "Are you sure want to logout?",
                  onCancelBtnTap: () {
                    Navigator.pop(context);
                  },
                  onConfirmBtnTap: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => MainPage()),
                        (route) => false);
                  },
                  cancelBtnText: "Cancel",
                  cancelBtnTextStyle: TextStyle(
                      color: Color.fromARGB(255, 151, 4, 2),
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                  showCancelBtn: true,
                  confirmBtnColor: Color.fromARGB(255, 151, 4, 2),
                  confirmBtnText: 'Continue',
                  backgroundColor: Colors.white,
                  width: 100,
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
          padding: const EdgeInsets.all(10),
          child: StreamBuilder<QuerySnapshot>(
            stream: _products,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text('Loading');
              }

              // ignore: dead_code
              return GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2),
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return GridTile(
                    child: Card(
                      elevation: 4,
                      shadowColor: Color.fromARGB(255, 151, 4, 2),
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductDetail(
                                            product_detail_name:
                                                data['product-name'],
                                            product_detail_image:
                                                data['product-image'],
                                            product_detail_price:
                                                data['product-price'],
                                          )));
                            },
                            child: Container(
                              padding: const EdgeInsets.only(bottom: 0.0),
                              child: Image.network(
                                data['product-image'],
                                height: 120,
                              ),
                            ),
                          ),
                          Text(
                            CurrencyFormat.convertToIdr(
                                data['product-price'], 0),
                            style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: Color.fromARGB(255, 151, 4, 2),
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            data['product-name'],
                            style: GoogleFonts.raleway(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          )),
    );
  }
}
