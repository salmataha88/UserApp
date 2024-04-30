class Users {
  String? name;
  String? email;
  String? studentId;
  String? password;
  List<int>? profilePhoto;
  String? level;
  String? gender;

  Users({this.name, this.email, this.studentId, this.password, this.profilePhoto , this.level , this.gender});

  // Convert map to user object
  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      name: map['name'],
      email: map['email'],
      studentId: map['studentId'],
      password: map['password'],
      profilePhoto: map['profilePhoto'],
      level: map['level'],
      gender: map['gender'],
    );
  }

  // Convert user object to map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'studentId': studentId,
      'password': password,
      'profilePhoto': profilePhoto,
      'level': level,
      'gender': gender,
    };
  }
}
