import 'package:core/core.dart';
import 'package:user/src/models/user.dart';

class UserRepository {
  UserRepository(this._userHiveOperation);

  final HiveOperation<User> _userHiveOperation;

  static const String _appUserKey = 'APP_USER';

  Future<User?> getCurrentUser() async {
    return _userHiveOperation.getItem(_appUserKey);
  }

  Future<void> setCurrentUser(User user) async {
    return _userHiveOperation.insertOrUpdateItem(_appUserKey, user);
  }

  Future<void> clearCurrentUser() async {
    return _userHiveOperation.deleteItem(_appUserKey);
  }
}
