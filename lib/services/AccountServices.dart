
import 'package:hafazni/Models/User.dart';
import 'package:hafazni/services/GeneralServices/NetworkService.dart';
import 'package:hafazni/services/GeneralServices/StorageService.dart';

class AccountServices {
  static AccountServices instance = AccountServices();
  final StorageServices _services = StorageServices.instance;
  User? user;
  Future<void> signOut() async {
    user = null;
    NetworkService.refreshAccessToken("");
    await _services.removeUserToken();
  }
}
