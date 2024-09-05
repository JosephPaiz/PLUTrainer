class Profile {
  final int superkey;
  final String name;

  Profile({
    required this.superkey,
    required this.name,
  });

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      superkey: map['superkey'],
      name: map['profile_name'],
    );
  }
}

class Role {
  final int id;
  final String roleName;

  Role({
    required this.id,
    required this.roleName,
  });

  factory Role.fromMap(Map<String, dynamic> map) {
    return Role(
      id: map['role_id'],
      roleName: map['role_name'],
    );
  }
}

class ProfileWithRoles {
  final Profile profile;
  final List<Role> roles;

  ProfileWithRoles({
    required this.profile,
    required this.roles,
  });
}
