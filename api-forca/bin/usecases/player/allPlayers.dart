import '../../repositories/playerRepositoryImpl.dart';

class AllPlayers {

  static Future<String> getAllPlayers() async {
    PlayerRepositoryImpl playerRepositoryImpl = PlayerRepositoryImpl();

    return await playerRepositoryImpl.getAllPlayers();
  }
}