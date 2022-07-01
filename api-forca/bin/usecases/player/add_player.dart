import '../../repositories/playerRepositoryImpl.dart';

class AddPlayer{
  static Future<String> addPlayer(String email, String name) async {
    PlayerRepositoryImpl playerRepositoryImpl = PlayerRepositoryImpl();

    return await playerRepositoryImpl.addPlayer(email, name);
  }
}