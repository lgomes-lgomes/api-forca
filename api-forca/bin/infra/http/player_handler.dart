
import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../usecases/player/add_player.dart';
import '../../usecases/player/allPlayers.dart';
import '../../usecases/player/delete_players.dart';
import '../../usecases/match/get_match.dart';

class PlayerHandler {
  Handler get handler{

    var router = Router();

    router.get('/all', (request) async{

      String allPlayers = "";

      await AllPlayers.getAllPlayers().then((value) => allPlayers = value);

      return Response.ok(
        allPlayers,
        headers:{'content-type': 'application/json'}
      );
    });

    router.post('/add', (Request request) async {
      var projectData = await request.readAsString();

      var payload = jsonDecode(projectData);

      String email = payload['email'];
      String name = payload['name'];

      String response = "";

      await AddPlayer.addPlayer(email, name).then((value) => response = value);

      return Response.ok(
        response,
        headers: {'content-type': 'application/json'}
      );
    });

    router.delete('/delete', (Request request) async {

      var uri = Uri.parse(request.url.toString());

      var email = uri.queryParameters['email'];

      String response = "";

      await DeletePlayers.deletePlayers(email!).then((value) => response = value);

      return Response.ok(
          response,
          headers: {'content-type': 'application/json'}
      );
    });

    router.get('/get', (Request request) async {

      Uri uri = Uri.parse(request.url.toString());

      var email = uri.queryParameters['email'];

      String response = "";

      await GetPlayer.getPlayer(email!).then((value) => response = value);

      return Response.ok(
          response,
          headers: {'content-type': 'application/json'}
      );
    });

    return router;
  }
}