import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../repositories/matchRepositoryImpl.dart';
import '../../usecases/match/delete_match.dart';
import '../../usecases/match/get_matches.dart';

class MatchHandler {

  Handler get handler {

    var router = Router();

    router.post('/add-match', (Request request) async {

      var uri = request.url;

      var email = uri.queryParameters['email'];
      var result = uri.queryParameters['result'];

      String response = "";

      await MatchRepositoryImpl().addMatch(email!, result!).then((value) => response = value);

      return Response.ok(
        response,
        headers: {'content-type': 'application/json'}
      );
    });

    router.get('/all-matches', (Request request) async {

      var uri = request.url;

      var email = uri.queryParameters['email'];

      String response = "";

      await GetAllMatchesFromPlayer.getAllMatchesFromPlayer(email!).then((value) => response = value);

      return Response.ok(
          response,
          headers: {'content-type': 'application/json'}
      );
    });

    router.delete('/delete-match', (Request request) async {

      var uri = request.url;

      var email = uri.queryParameters['email'];
      var matchId = uri.queryParameters['matchId'];

      String response = "";

      await DeleteMatch.deleteMatch(email!, matchId!).then((value) => response = value);

      return Response.ok(
        response,
        headers: {'content-type': 'application/json'}
      );
    });

    return router;
  }
}