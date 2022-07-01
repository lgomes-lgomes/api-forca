import 'dart:convert';

import 'package:firebase_dart/auth.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../usecases/auth/login_user.dart';
import '../../usecases/auth/register_user.dart';
import '../../usecases/player/add_player.dart';
import '../firebase_init.dart';

class AuthHandler {

  Handler get handler {

    var router = Router();

    router.post('/register', (Request request) async{

      var requestStr = await request.readAsString();
      final payload = jsonDecode(requestStr);

      String email = payload['email'];
      String password = payload['password'];
      String name = payload['name'];

      String response = "";

      await RegisterUser.registerUser(email, password).then((value) => response = value);
      await AddPlayer.addPlayer(email, name);

      return Response.ok(
        response,
        headers: {'content-type': 'application/json'}
      );
    });

    router.post('/login', (Request request) async {
      var requestStr = await request.readAsString();
      final payload = jsonDecode(requestStr);

      String email = payload['email'];
      String password = payload['password'];

      String response = "";

      await LoginUser.loginUser(email, password).then((value) => response = value);

      return Response.ok(
        response,
        headers: {'content-type': 'application/json'}
      );
    });

    router.get('/is-logged', (Request request) async {

      var app = await FirebaseInit.initApp();
      var auth = FirebaseAuth.instanceFor(app: app);

      bool? logado;

      if(auth.currentUser != null){
        logado = true;
      } else {
        logado = false;
      }

      return Response.ok(
        jsonEncode({'success': true, 'logado': logado, 'user': auth.currentUser}),
        headers: {'content-type': 'application/json'}
      );
    });

    router.post('/logout', (Request request) async {
      var app = await FirebaseInit.initApp();
      var auth = FirebaseAuth.instanceFor(app: app);

      try{
        auth.signOut();
      } catch (e){
        print(e.toString());
      }

      return Response.ok(
          jsonEncode({'success': true}),
          headers: {'content-type': 'application/json'}
      );
    });

    return router;
  }
}