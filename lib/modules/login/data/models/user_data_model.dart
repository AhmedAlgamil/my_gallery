class UserDataModel {
  UserData? data;
  String? token;

  UserDataModel.fromJson(Map<String, dynamic> json) {
    if (json["user"] != null) {
      data = UserData.fromJson(json["user"]);
    }
    token = json["token"];
  }
}

class UserData {
  int? id;
  String? name;
  String? email;
  String? email_verified_at;
  String? created_at;
  String? updated_at;

  UserData({
    required this.email,
    required this.email_verified_at,
    required this.name,
    required this.updated_at,
});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    email = json["email"];
    email_verified_at = json["email_verified_at"];
    created_at = json["created_at"];
    updated_at = json["updated_at"];
  }

  static Map<String, dynamic> toJson(UserData data) {
    return {
      "id": data.id,
      "name": data.name,
      "email": data.email,
      "email_verified_at": data.email_verified_at,
      "created_at": data.created_at,
      "updated_at": data.updated_at,
    };
  }
}
