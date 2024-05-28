
import 'package:chapa_tu_bus_app/account_management/infrastructure/services/auth_service.dart';
import 'package:chapa_tu_bus_app/account_management/presentation/widgets/auth/my_button.dart';
import 'package:chapa_tu_bus_app/account_management/presentation/widgets/auth/my_text_field.dart';
import 'package:chapa_tu_bus_app/account_management/presentation/widgets/auth/square_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.onTap});
  final Function()? onTap;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // text editing controllers
  final nameController = TextEditingController();
  final numberPhoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    numberPhoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  // sign user in method
  void signUserUp() async {
    // show loading dialog
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // try creating user
    try {
      if(passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

        // add user to firestore
        addUserToFirestore(
          nameController.text.trim(),
          emailController.text.trim()
        );
        
      } else {
        //pop the loading circle
        Navigator.pop(context);
        // show error message, passwords do not match
        showErrorMessage('Las contraseñas no coinciden');
      }
      //pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //pop the loading circle
      Navigator.pop(context);
      // show error message
      showErrorMessage(e.code);
    }
  }

  Future addUserToFirestore(String name, String email) async {
    await FirebaseFirestore.instance.collection('users').add({
      'name': name,
      'email': email,
      'photoURL': 'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgQrn0h8YlouX1uYeAHOjVV_1zOiEzM0Q_Ftq_kDVXy8XUJVc2bLiMCHa6-hYHGBKHswAnzu6McRzACcS7kAwtq0Q8f-2vzFpOtBmnMGs9M7a5avCRCGuyMzRRUOGHLTNxlzQ1WcwgmM6xhJ-_3GycyKrQstuDFIVisogfV9FaYpaJzfciWLj8B1VOxlfA/s1600/Ellipse%2049.png',
    });
  }

  // wrong message to user
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 5),
            
                // logo
                Stack(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const ShapeDecoration(
                        color: Color(0xFF556BDA),
                        shape: OvalBorder(),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.directions_bus,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
            
                const SizedBox(height: 25),
            
                // let's create an account for you
                Text(
                  '¡Vamos a crear una cuenta para ti!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
            
                const SizedBox(height: 25),
            
                // name textfield
                MyTextField(
                  controller: nameController,
                  hintText: 'Nombre',
                  obscureText: false,
                ),
                
                const SizedBox(height: 10),

                // email textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
            
                const SizedBox(height: 10),
            
                // password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Contraseña',
                  obscureText: true,
                ),
            
                const SizedBox(height: 10),

                // confirm password textfield
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirmar contraseña',
                  obscureText: true,
                ),
            
                const SizedBox(height: 25),
            
                // sign in button
                MyButton(
                  text: 'Registrarse',
                  onTap: signUserUp,
                ),
            
                const SizedBox(height: 25),
            
                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'O continuar con',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
            
                const SizedBox(height: 25),
            
                // google sign in buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google button
                    SquareTile(
                      onTap: () => AuthService().signInWithGoogle(),
                      imagePath: 'assets/images/google.png'
                    ),
                  ],
                ),
            
                const SizedBox(height: 25),
            
                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '¿Ya tienes una cuenta?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Inicia sesión ahora',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}