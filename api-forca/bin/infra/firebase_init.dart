import 'package:firebase_dart/core.dart';

import '../configurations.dart';

class FirebaseInit{
  static Future<FirebaseApp> initApp() async {
    late FirebaseApp app;

    try{
      app = Firebase.app();
    } catch (e){
      app = await Firebase.initializeApp(options: FirebaseOptions.fromMap(Configurations.firebaseConfig));
    }

    return app;
  }
}