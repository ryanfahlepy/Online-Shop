import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
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

  String imageUrl = "";
  String _profilePicture = "";
  String _name = "";
  String _email = "";
  String _studentid = "";
  String _userimage = "";
  String _password = "";

  final String _collection = 'users';
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future updatePp() async {
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref('pp # ' + FirebaseAuth.instance.currentUser!.email.toString());

    await ref.putFile(File(_image!.path));
    ref.getDownloadURL().then((value) {
      print(value);
      setState(() {
        if (value != null) {
          imageUrl = value;
        } else {
          print("no image picked");
        }
      });
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
        print(_profilePicture);
        setState(() {
          if (doc.id != null) {
            _profilePicture = doc.id;
          } else {
            print("no image picked");
          }
        });
      });
    });
  }

  CollectionReference users_picture =
      FirebaseFirestore.instance.collection('users');

  Future updateUser(String _profilePicture, String imageUrl) async {
    return await users_picture
        .doc(_profilePicture)
        .update({'user-image': imageUrl})
        .then((value) => print("Update Success"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future docUpdate(String _name, String _studentid, String _email,
      String _password, String _userimage) async {
    return await FirebaseFirestore.instance.collection('users').add({
      'name': _name,
      'email': _email,
      'student_id': _studentid.toString(),
      'password': _password.toString(),
      'user-image': _userimage.toString(),
    });
  }

  Future getData() async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(_profilePicture)
        .get()
        .then((DocumentSnapshot documentsnapshot) {
      if (documentsnapshot.exists) {
        print(documentsnapshot['password']);
        setState(() {
          _name = documentsnapshot['name'];
          _email = documentsnapshot['email'];
          _studentid = documentsnapshot['student_id'];
          _password = documentsnapshot['password'];
          _userimage = documentsnapshot['user-image'];
        });
      }
      ;
    });
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
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 151, 4, 2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Text(
                      "Pilih Foto",
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
                  if (_image != null) {
                    CoolAlert.show(
                      context: context,
                      type: CoolAlertType.success,
                      text: "Your profile picture has been updated",
                      title: "Success",
                      confirmBtnColor: Color.fromARGB(255, 151, 4, 2),
                      confirmBtnText: 'Re - Login',
                      backgroundColor: Colors.white,
                      width: 100,
                    );
                    updatePp();
                    getDocId();
                    getData();
                    docUpdate(_name, _studentid, _email, _password, _userimage);
                  }
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
