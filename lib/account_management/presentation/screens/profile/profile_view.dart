import 'package:chapa_tu_bus_app/account_management/presentation/widgets/profile/my_text_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  static const name = 'Profile';
  static String getViewName() => name;
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final user = FirebaseAuth.instance.currentUser!;

  String? photoURL;
  String? email;
  String? name;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userEmail = user.email; // Obtiene el email del usuario actual
    if (userEmail != null) {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: userEmail)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final userData = querySnapshot.docs.first.data();
        setState(() {
          name = userData['name'];
          email = userData['email'];
          photoURL = userData['photoURL'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF556BDA),
        title: const Text('Profile'),
      ),
      body: SizedBox.expand(
        child: ListView(
          children: [
            const SizedBox(height: 50),

            // profile picture
            FadeInImage(
              placeholder: const NetworkImage(
                  'https://t3.ftcdn.net/jpg/02/48/42/64/360_F_248426448_NVKLywWqArG2ADUxDq6QprtIzsF82dMF.jpg'),
              image: NetworkImage(
                photoURL ??
                    'https://t3.ftcdn.net/jpg/05/87/76/66/360_F_587766653_PkBNyGx7mQh9l1XXPtCAq1lBgOsLl6xH.jpg',
              ),
              fit: BoxFit.fitHeight,
              width: 100,
              height: 100,
            ),

            const SizedBox(height: 25),

            // user details
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  Text('User Details',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  Divider(),
                  SizedBox(height: 25),
                ],
              ),
            ),

            // name
            MyTextBox(text: name, sectionName: 'Nombre', icon: Icons.person),

            const SizedBox(height: 25),

            // email
            MyTextBox(text: email, sectionName: 'Email', icon: Icons.email),

            const SizedBox(height: 25),

            // update profile button

            ElevatedButton(
              onPressed: () {},
              child: const Row(
                children: [Icon(Icons.edit), Text('Actualizar Perfil')],
              ),
            ),
          ],
        ),
      ),
    );
  }
}