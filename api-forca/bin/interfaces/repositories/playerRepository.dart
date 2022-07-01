import 'package:http/http.dart';
import 'package:shelf/shelf.dart';

import '../../domain/player.dart';

abstract class PlayerRepository{
  Future<String> getAllPlayers();
  Future<String> addPlayer(String email, String name);
  Future<String> deletePlayer(String projectData);
  Future<String> getPlayer(String projectData);
}