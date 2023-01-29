import 'package:dochub/Models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthMethods{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Users? _userFromFirebaseUser(User user){
    return user!=null ? Users(userId: user.uid) : null;
  }
  Future signInWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);

      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } on FirebaseAuthException catch(e){
      print(e.toString());
      if(e.code == 'user-not-found' || e.code == 'wrong-password'){
        Fluttertoast.showToast(
            msg: "Email or Password incorrect!!!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.grey,
            textColor: Colors.black,
            fontSize: 15
        );
      }else if (e.code == 'invalid-email'){
        Fluttertoast.showToast(
            msg: "Invalid Email",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.grey,
            textColor: Colors.black,
            fontSize: 15
        );
      }
    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      User? user = result.user;
      return _userFromFirebaseUser(user!);

    } on FirebaseAuthException catch(e){
      if(e.code == 'email-already-in-use'){
        Fluttertoast.showToast(
            msg: "Email already in use",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.grey,
            textColor: Colors.black,
            fontSize: 15
        );
      }else if (e.code == 'invalid-email'){
        Fluttertoast.showToast(
            msg: "Invalid Email",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.grey,
            textColor: Colors.black,
            fontSize: 15
        );
      }
    }
  }

  Future resetPass(String email) async{
    try{
      return await _auth.sendPasswordResetEmail(email: email);
    }catch(e){
      print(e.toString());
    }
  }

  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
    }
  }
}