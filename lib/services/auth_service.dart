import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

 class AuthService
{
  signInWithGoogle() async{

//begin interactive sign in process
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

//obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

//create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    //sign in to firebase with the credential
return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}