import 'dart:convert';

import 'package:firebase_dart/database.dart';

import '../configurations.dart';
import '../domain/match_model.dart';
import '../infra/firebase_init.dart';
import '../interfaces/repositories/matchRepository.dart';

class MatchRepositoryImpl implements MatchRepository {

  @override
  Future<String> addMatch(String email, String result) async {

    var emailBytes = utf8.encode(email);
    String emailCrypto = base64.encode(emailBytes);
    
    var app = await FirebaseInit.initApp();
    var connection = FirebaseDatabase(app: app, databaseURL: Configurations.databaseUrl);

    Map<String, dynamic>? lastMatch;
    var refMatchTeste = await connection.reference().child('players').child(emailCrypto).child('matches').limitToLast(1);

    await refMatchTeste.once().then((value) => lastMatch = value.value);

    MatchModel? match;

    if(lastMatch != null){
      var keyStr = await lastMatch!.keys.first;
      var key = int.parse(keyStr);
      match = MatchModel(result: int.parse(result), id: ++key);
    } else {
      match = MatchModel(result: int.parse(result), id: 0);
    }

    final ref = connection.reference().child('players').child(emailCrypto).child('matches').child(match.id.toString());


    ref.set({
      match.id: match.result
    });

    return jsonEncode({'success': true});
  }

  @override
  Future<String> deleteMatch(String email, String matchId) async {

    var emailBytes = utf8.encode(email);
    String emailCrypto = base64.encode(emailBytes);

    var app = await FirebaseInit.initApp();
    var connection = FirebaseDatabase(app: app, databaseURL: Configurations.databaseUrl);

    final ref = connection.reference().child('players').child(emailCrypto).child('matches').child(matchId);

    ref.remove();

    return jsonEncode({'success': true});
  }

  @override
  Future<String> getAllMatchesFromPlayer(String email) async {

    var emailBytes = utf8.encode(email);
    String emailCrypto = base64.encode(emailBytes);

    print(email);

    var app = await FirebaseInit.initApp();
    var connection = FirebaseDatabase(app: app, databaseURL: Configurations.databaseUrl);

    var responseData;

    final ref = connection.reference().child('players').child(emailCrypto).child('matches');

    await ref.once().then((value) => responseData = value.value);

    return json.encode(responseData);

  }

}