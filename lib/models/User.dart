class User {
  String username;
  String password;
  int diamonds;
  int points;

  User({
    required this.username,
    required this.password,
    this.diamonds = 0,
    this.points = 0,
  });
}
