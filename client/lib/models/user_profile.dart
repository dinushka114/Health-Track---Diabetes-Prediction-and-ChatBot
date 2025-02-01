class UserProfile {
  String? fullName;
  String? phone;
  String? email;
  String? image;

  UserProfile({this.fullName, this.phone, this.email, this.image});

  factory UserProfile.fromJson(Map<dynamic, dynamic> json) {
    return UserProfile(
        fullName: json["fullName"],
        email: json["email"],
        phone: json["phone"],
        image: json["image"]);
  }
}
