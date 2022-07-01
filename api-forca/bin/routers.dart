import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'infra/http/auth_handler.dart';
import 'infra/http/match_handler.dart';
import 'infra/http/player_handler.dart';

class Routers {
  Handler get handler {
    var router = Router();

    router.mount('/players', PlayerHandler().handler);
    router.mount('/matches', MatchHandler().handler);
    router.mount('/auth', AuthHandler().handler);

    return router;
  }
}