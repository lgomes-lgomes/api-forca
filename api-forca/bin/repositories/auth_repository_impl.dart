import 'dart:convert';

import 'package:firebase_dart/auth.dart';

import '../infra/firebase_init.dart';

class AuthRepositoryImpl {

  Future<String> registerUser(String email, String password) async {

    var app = await FirebaseInit.initApp();
    var auth = FirebaseAuth.instanceFor(app: app);

    try{

      await auth.createUserWithEmailAndPassword(email: email, password: password);

    } on FirebaseAuthException catch(e){
      print(email);
      print(password);
      print(e.code);
      return jsonEncode({'success' : false, 'error': e.code});
    }

    return jsonEncode({'success': true});
  }

  Future<String> loginUser(String email, String password) async {

    var app = await FirebaseInit.initApp();
    var auth = FirebaseAuth.instanceFor(app: app);

    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e){
      print(e.code);
    }

    return jsonEncode({'success': true});
  }


}