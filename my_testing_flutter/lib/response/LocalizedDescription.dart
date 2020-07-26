class LocalizedDescription {
  int languageId;
  String localizedDescription;

  LocalizedDescription({this.languageId, this.localizedDescription});

  LocalizedDescription.fromJson(Map<String, dynamic> json) {
    languageId = json['language_id'];
    localizedDescription = json['localized_Description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['language_id'] = this.languageId;
    data['localized_Description'] = this.localizedDescription;
    return data;
  }
}