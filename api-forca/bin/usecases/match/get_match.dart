import '../../repositories/playerRepositoryImpl.dart';

class GetPlayer {
  static Future<String> getPlayer(String projectData) async {
    PlayerRepositoryImpl playerRepositoryImpl = PlayerRepositoryImpl();

    return await playerRepositoryImpl.getPlayer(projectData);
  }
}