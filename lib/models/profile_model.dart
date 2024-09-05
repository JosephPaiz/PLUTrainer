class ProfileModel {
  final int superkey;
  final String name;

  ProfileModel({
    required this.superkey,
    required this.name,
  });

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      superkey: map['superkey'],
      name: map['name'],
    );
  }
}
