import 'dart:convert';

import 'package:http/src/response.dart';
import 'package:shelf/shelf.dart';

import '../configurations.dart';
import '../domain/match_model.dart';
import '../domain/player.dart';
import 'package:firebase_dart/src/database.dart';
import 'dart:convert';

import '../infra/firebase_init.dart';
import '../interfaces/repositories/playerRepository.dart';

class PlayerRepositoryImpl implements PlayerRepository {

  @override
  Future<String> addPlayer(String email, String name) async {

    final List matches = [];

    if(name == null){
      return jsonEncode({'success': false, 'error': 'Missing color'});
    } else if(email == null){
      return jsonEncode({'success': false, 'error': 'Missing color'});
    }

    var emailBytes = utf8.encode(email);
    String emailCrypto = base64.encode(emailBytes);

    var app = await FirebaseInit.initApp();
    var connection =FirebaseDatabase(app: app, databaseURL: Configurations.databaseUrl);

    final ref = connection.reference().child('players').child(emailCrypto);

    await ref.set({
      'email': email,
      'name': name,
      'matches': matches,
      'emailCrypto': emailCrypto
    });

    return jsonEncode({'success': true});
  }

  @override
  Future<String> deletePlayer(String email) async {

    var emailBytes = utf8.encode(email);
    String emailCrypto = base64.encode(emailBytes);

    var app = await FirebaseInit.initApp();
    var connection =FirebaseDatabase(app: app, databaseURL: Configurations.databaseUrl);
    final ref = connection.reference().child('players').child(emailCrypto);

    ref.remove();

    return jsonEncode({'success': true});
  }

  @override
  Future<String> getAllPlayers() async {

    var app = await FirebaseInit.initApp();
    var connection =FirebaseDatabase(app: app, databaseURL: Configurations.databaseUrl);
    final ref = connection.reference().child('players');

    var responseData;

    await ref.once().then((value) => responseData = value.value);

    return json.encode(responseData);
  }

  @override
  Future<String> getPlayer(String email) async {

    var emailBytes = utf8.encode(email);
    String emailCrypto = base64.encode(emailBytes);

    var app = await FirebaseInit.initApp();
    var connection =FirebaseDatabase(app: app, databaseURL: Configurations.databaseUrl);
    final ref = connection.reference().child('players').child(emailCrypto);

    var responseData;

    await ref.once().then((value) => responseData = value.value);


    return json.encode(responseData);
  }


}