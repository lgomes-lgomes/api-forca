import '../../repositories/matchRepositoryImpl.dart';

class AddMatch {
  static Future<String> addMatch(String email, String result) async {
    MatchRepositoryImpl matchRepositoryImpl = MatchRepositoryImpl();

    return await matchRepositoryImpl.addMatch(email, result);
  }
}