class Profile {
  final int id;
  final String username;
  final String email;
  final String fullName;
  final String phoneNo;
  final String address;
  final DateTime dateOfBirth;
  String imageUrl;

  Profile(
    this.id,
    this.username,
    this.email,
    this.fullName,
    this.phoneNo,
    this.address,
    this.dateOfBirth,
    this.imageUrl,
  );
}
