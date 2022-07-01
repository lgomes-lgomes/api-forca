import 'match_model.dart';

class Player{

  String name;
  String email;
  String password;
  List<Match>? matches;

  Player({
    required this.name,
    required this.email,
    required this.password
  });
}