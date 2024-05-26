import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FireAuth {
  static Future<User?> signInWithGoogle() async {
    try {
      print("hi");
      final GoogleSignInAccount? googleUser = await GoogleSignIn(
              clientId:
                  "759084936586-uac0hfr51rqbdv1pf3m0ikpudq1j0qmk.apps.googleusercontent.com")
          .signIn();
      if (googleUser != null) {
        print('check:${googleUser.email}');
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        print('test:${userCredential.user?.email}');
        return userCredential.user;
      }
    } catch (e) {
      print('Error during Google sign-in: $e');
    }
    return null;
  }
}
