import '../../../../models/Role.dart';
import '../../../../models/User.dart';

class RoleChecker {
  late final User user;

  void setUser(User myUser) {
    user = myUser;
  }

  bool get canCreateSchool {
    if (user.role == Role.SuperAdmin) {
      return true;
    } else {
      return false;
    }
  }
}
