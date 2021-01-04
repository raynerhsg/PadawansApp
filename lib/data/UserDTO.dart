class UserDTO {
  int id;
  String name;
  String username;
  String email;
  String phone;
  String website;

  UserDTO({this.id,
    this.name,
    this.username,
    this.email,
    this.phone,
    this.website,
  });

  UserDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    website = json['website'];
  }
}