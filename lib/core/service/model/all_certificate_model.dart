class AllCertificateModel {
  late final int id;
  late final int sectionId;
  late final String title;
  late final String duration;
  late final String name;
  late final String phone;
  late final String idNumber;
  late final String file;

  AllCertificateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sectionId = json['section_id'];
    title = json['title'];
    duration = json['duration'];
    name = json['name'];
    phone = json['phone'];
    idNumber = json['id_number'];
    file = json['file'];
  }
}
