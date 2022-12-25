import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:wk/login_page.dart';
import 'home_page.dart';

class ProfileImage extends StatefulWidget {
  final description;

  ProfileImage({this.description});

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  File? _image;
  final picker = ImagePicker();
  String? imageUrl;
  final _profilePicture = TextEditingController();

  @override
  void dispose() {
    _profilePicture.dispose();

    super.dispose();
  }

  final String _collection = 'users';
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future upDel() async {
    return await users_picture
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'user-image': imageUrl.toString()})
        .then((value) => print("Update Success"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future updatePp() async {
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref('pp # ' + FirebaseAuth.instance.currentUser!.email.toString());

    await ref.putFile(File(_image!.path));
    String value = await ref.getDownloadURL();
    print(value);
    setState(() {
      imageUrl = value;
    });
  }

  // Get Document ID
  Future getDocId() async {
    return await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((QuerySnapshot querysnapshot) {
      querysnapshot.docs.forEach((DocumentSnapshot doc) {
        print(doc.id);
        if (mounted) {
          setState(() {
            if (doc.id != null) {
              String _profilePicture = doc.id;
            } else {
              print("no image picked");
            }
          });
        }
      });
    });
  }

  CollectionReference users_picture =
      FirebaseFirestore.instance.collection('users');

  Future updateUser() async {
    return await users_picture
        .doc(_profilePicture.text.toString())
        .update({'user-image': imageUrl})
        .then((value) => print("Update Success"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future getImageGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("no image picked");
      }
    });
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
          'Profile Image',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: InkWell(
                onTap: () {
                  getImageGallery();
                  updatePp();
                },
                child: Container(
                  height: 200,
                  width: 200,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: _image != null
                      ? Image.file(_image!.absolute)
                      : Center(child: Icon(Icons.image)),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 100, right: 100, top: 20, bottom: 20),
              child: GestureDetector(
                onTap: () {
                  getImageGallery();
                  updatePp();
                  print(imageUrl);
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 151, 4, 2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Text(
                      "Choose image",
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
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 75.0),
              child: GestureDetector(
                onTap: () {
                  updatePp();
                  CoolAlert.show(
                    onConfirmBtnTap: () {
                      updatePp();
                      upDel();
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    onCancelBtnTap: () {
                      Navigator.pop(context);
                    },
                    context: context,
                    type: CoolAlertType.confirm,
                    showCancelBtn: true,
                    title: "Are you sure?",
                    confirmBtnColor: Color.fromARGB(255, 151, 4, 2),
                    confirmBtnText: 'Ok',
                    backgroundColor: Colors.white,
                    width: 100,
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 151, 4, 2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Text(
                      "Confirm",
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
          ],
        ),
      ),
    );
  }
}
