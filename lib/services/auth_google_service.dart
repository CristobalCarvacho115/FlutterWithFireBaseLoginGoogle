import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthGoogleService {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Iniciar sesion
  Future<User?> signIn() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      //Si no hay usuario de google retorna null
      if (googleUser == null) {
        return null;
      }
      //Si hay usuario de google, se obtiene la autenticacion
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      //Se obtiene el usuario de firebase
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user;
    } catch (ex) {
      print("No funciona signInWithGoogle: " + ex.toString());
      return null;
    }
  }

  //Cerrar sesion
  Future<void> signOut() async {
    await googleSignIn.signOut();
    await _auth.signOut();
  }
}
