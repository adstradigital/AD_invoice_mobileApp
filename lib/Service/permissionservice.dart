import 'package:get/get.dart';

class PermissionService extends GetxService {
  var userPermissions = <String>[].obs;
  
  // Set permissions directly from API response
  void setPermissions(List<String> permissions) {
    userPermissions.value = permissions;
    print("User has ${permissions.length} permissions: $permissions");
  }

  bool can(String permissionCode) {
    return userPermissions.contains(permissionCode);
  }

  bool canAny(List<String> permissionCodes) {
    return permissionCodes.any((code) => userPermissions.contains(code));
  }
}