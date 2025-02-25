// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:med_adherence_app/features/views/edit_profile.dart';
import 'package:med_adherence_app/features/views/emergency_settings.dart';
import 'package:med_adherence_app/features/views/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  String? userID;

  ProfileScreen({
    super.key,
    this.userID,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String fullName = '';
  String email = '';
  String imageProfile =
      'https://firebasestorage.googleapis.com/v0/b/dating-app-a5c06.appspot.com/o/Place%20Holder%2Fprofile_avatar.jpg?alt=media&token=dea921b1-1228-47c2-bc7b-01fb05bd8e2d';

  retrieveUserInfo() async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(widget.userID)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        if (snapshot.data()!["imageProfile"] != null) {
          setState(() {
            imageProfile = snapshot.data()!["imageProfile"];
          });
        }
        setState(() {
          fullName = snapshot.data()!["fullName"];
          email = snapshot.data()!["email"];
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    retrieveUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage(imageProfile),
              backgroundColor: Colors.white, // Add a background color
              foregroundColor: Colors.black, // Add a border color
            ),
            const SizedBox(height: 20),
            ListTile(
              title: Text(
                fullName,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              subtitle: Text(
                email,
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                shrinkWrap: true,
                children: [
                  ListTile(
                    leading: const Icon(Icons.person, size: 30),
                    horizontalTitleGap: 50,
                    title: const Text("Edit Profile"),
                    onTap: () {
                      Get.to(const EditProfile());
                    },
                  ),
                  ListTile(
                    leading:
                        const Icon(Icons.contact_emergency_outlined, size: 30),
                    horizontalTitleGap: 50,
                    title: const Text("Set Up Emergency"),
                    onTap: () {
                      Get.to(EmergencyScreen());
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout, size: 30),
                    horizontalTitleGap: 50,
                    title: const Text("Logout"),
                    onTap: () {
                      Get.off(const LoginScreen());
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
