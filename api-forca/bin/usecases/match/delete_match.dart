import '../../repositories/matchRepositoryImpl.dart';

class DeleteMatch {
  static Future<String> deleteMatch(String email, String matchId) async {
    MatchRepositoryImpl matchRepositoryImpl = MatchRepositoryImpl();

    return await matchRepositoryImpl.deleteMatch(email, matchId);
  }
}