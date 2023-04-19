class AlgorithmFunctions {

  static bool isUserIDExistAndisNotEmpty(
      {required List<String> userIdsList, required String userId}) {
    if (userIdsList.isEmpty) {
      return false;
    } else {
      if (userIdsList.contains(userId)) {
        return true;
      } else {
        return false;
      }
    }

    // return userIdsList.isNotEmpty
    //     ? (userIdsList.contains(userId) ? true : false)
    //     : false;
  }
}
