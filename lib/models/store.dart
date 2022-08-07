class Store {
  final int id;
  final String imageUrl;
  final String title;
  final String address;
  final String contact;
  final String store_description;
  bool is_recent;

  Store({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.address,
    required this.contact,
    required this.store_description,
    required this.is_recent,
  });
}
