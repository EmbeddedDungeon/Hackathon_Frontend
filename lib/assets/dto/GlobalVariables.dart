import 'dart:collection';

class GlobalVariables {
  static final Map<String, int> globalValues = HashMap();
}

class GroupManager {
  void setGroupId(int groupId) {
    GlobalVariables.globalValues['groupId'] = groupId;
  }

  int? getGroupId() {
    return GlobalVariables.globalValues['groupId'];
  }
}

class CampagneManager {
  void setCampagneId(int campagneId) {
    GlobalVariables.globalValues['campagneId'] = campagneId;
  }

  int? getCampagneId() {
    return GlobalVariables.globalValues['campagneId'];
  }
}

class UserManager {
  void setUserId(int userId) {
    GlobalVariables.globalValues['userId'] = userId;
  }

  int? getUserId() {
    return GlobalVariables.globalValues['userId'];
  }
}