abstract class MatchRepository {
  Future<String> getAllMatchesFromPlayer(String projectData);
  Future<String> addMatch(String email, String result);
  Future<String> deleteMatch(String email, String matchId);
}