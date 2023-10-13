import '../services/services.dart';

class UserController {
  static Future login({required String email, required String password}) async {
    var response = await DestinationServices.login(
      email: email,
      password: password,
    );
    return response;
  }
}
