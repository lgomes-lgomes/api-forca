import '../../repositories/auth_repository_impl.dart';

class RegisterUser {
  static Future<String> registerUser (String email, String password) async {
    AuthRepositoryImpl authRepositoryImpl = AuthRepositoryImpl();

    return await authRepositoryImpl.registerUser(email, password);
  }



}