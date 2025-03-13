class CertificatesModel {
  late final int id;
  late final String title;
  late final bool checked;

  CertificatesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    checked = json['checked'];
  }
}
