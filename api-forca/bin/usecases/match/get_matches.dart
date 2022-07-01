import '../../repositories/matchRepositoryImpl.dart';

class GetAllMatchesFromPlayer {
  static Future<String> getAllMatchesFromPlayer(String projectData) async {
    MatchRepositoryImpl matchRepositoryImpl = MatchRepositoryImpl();

    return await matchRepositoryImpl.getAllMatchesFromPlayer(projectData);
  }
}