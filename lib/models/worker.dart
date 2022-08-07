class Worker {
  final int id;
  final String name;
  final String imageUrl;
  final String address;
  final DateTime DOB;
  final String email;
  final String qualification;
  final int experience;
  bool isFavorite = false;
  final int departmentId;

  Worker({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.address,
    required this.DOB,
    required this.email,
    required this.qualification,
    required this.experience,
    required this.isFavorite,
    required this.departmentId
  });
}
