import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class SettingsView extends StatefulWidget {
  static const name = 'ProfileConfiguration';
  static String getViewName() => name;
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final user = FirebaseAuth.instance.currentUser!;
  final ImagePicker _picker = ImagePicker();
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  String photoURL = '';
  String email = '';
  String name = '';
  String? _selectedImagePath;

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

  Future<void> _getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImagePath = image.path; // Save image path
      });
      // Upload the image to Firebase Storage
      try {
        final ref = storage.ref().child('user_images/${user.uid}');
        final uploadTask = ref.putData((await image.readAsBytes()));
        final snapshot = await uploadTask.whenComplete(() {});
        // Get the download URL
        final photoURL = await snapshot.ref.getDownloadURL();
        setState(() {
          _selectedImagePath =
              photoURL; // Update selectedImagePath with the download URL
        });
        // Update the photoURL in Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({'photoURL': photoURL});
        // Show a success message or perform any other actions
        //print('Image uploaded and photoURL updated in Firestore.');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('¡Éxito!'),
              content: const Text('Datos actualizados en Firestore.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } catch (e) {
        // Handle errors
        //print('Error uploading image: $e');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text('Error actualizando datos: $e'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  void _saveChanges() async {
    // Update user data in Firestore
    final userEmail = user.email;
    if (userEmail != null) {
      try {
        // Update user data
        await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: userEmail)
            .get()
            .then((querySnapshot) {
          querySnapshot.docs.first.reference.update({
            'name': name,
            // Update photoURL if a new image was selected
            'photoURL': _selectedImagePath ?? photoURL,
          });
        });
        // Show success message or navigate
      } catch (e) {
        // Handle errors
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Configuración',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.grey),
            onPressed: () {
              context.go('/home/3');
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(photoURL)),
                        IconButton(
                          onPressed: _getImage,
                          icon: const Icon(Icons.edit, size: 20),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: name,
                    decoration: const InputDecoration(labelText: 'Tu nombre'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingresa tu nombre';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        name = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: email,
                    decoration: const InputDecoration(labelText: 'Correo'),
                    readOnly: true, // Make email field read-only
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFC4B5FD),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                    ),
                    child: const Text('Guardar cambios'),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
