// class HasPermissionsModel {
//   final bool hasPermissions;
//   final String message;

//   HasPermissionsModel({
//     required this.hasPermissions,
//     required this.message,
//   });

//   factory HasPermissionsModel.fromMap(Map<String, dynamic> map) {
//     return HasPermissionsModel(
//       hasPermissions: map['has_permissions'] ?? false,
//       message: map['message'] ?? '',
//     );
//   }
// }

class HasPermissionsModel {
  final bool hasPermissions;
  final String message;

  HasPermissionsModel({
    required this.hasPermissions,
    required this.message,
  });
}
