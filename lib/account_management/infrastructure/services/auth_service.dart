import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  signInWithGoogle() async {
    //begin interactive sign in process
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    //obtain auth details from request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    //create a new credential for the user
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    //finally, lets sign in the user
    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    // Get the user
    User? user = userCredential.user;

    // Check if the user already exists in Firestore
    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(user?.uid).get();

    // If the user doesn't exist, add their basic info to Firestore
    if (!userDoc.exists) {
      await FirebaseFirestore.instance.collection('users').doc(user?.uid).set({
        'name': user?.displayName,
        'email': user?.email,
        'photoURL': user?.photoURL,
      });
    }

    return userCredential;
  }
}