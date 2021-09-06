class User{
  int? id;
  String? name;
  String? username;
  String? headline;
  String? imageUrl;

  User({
    this.id,
    this.name,
    this.username,
    this.headline,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'headline': headline,
      'image_url': imageUrl,
    };
  }

  factory User.fromMap(Map<String, dynamic> json) => new User(
    id: json["id"],
    name: json["name"],
    username: json["username"],
    headline: json["headline"],
    imageUrl: json["image_url"]['100px'],
  );
}