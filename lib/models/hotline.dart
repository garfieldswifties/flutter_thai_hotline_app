class Hotline {
  const Hotline(this.name, this.phone, this.image);

  final String name;
  final String phone;
  final String image;

  Uri get phoneUri =>
      Uri(scheme: 'tel', path: phone.replaceAll(RegExp(r'[\s-]'), ''));
}
