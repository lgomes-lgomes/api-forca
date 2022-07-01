import '../../repositories/auth_repository_impl.dart';

class LoginUser {

  static Future<String> loginUser (String email, String password) async{
    AuthRepositoryImpl authRepositoryImpl = AuthRepositoryImpl();

    return await authRepositoryImpl.loginUser(email, password);
  }


}