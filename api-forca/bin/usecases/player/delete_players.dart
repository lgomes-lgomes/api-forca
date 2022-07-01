import '../../repositories/playerRepositoryImpl.dart';

class DeletePlayers {
  static Future<String> deletePlayers(String projectData) async {
    PlayerRepositoryImpl playerRepositoryImpl = PlayerRepositoryImpl();

    return await playerRepositoryImpl.deletePlayer(projectData);
  }
}