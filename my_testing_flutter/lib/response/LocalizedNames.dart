class LocalizedNames {
  int languageId;
  String localizedName;

  LocalizedNames({this.languageId, this.localizedName});

  LocalizedNames.fromJson(Map<String, dynamic> json) {
    languageId = json['language_id'];
    localizedName = json['localized_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['language_id'] = this.languageId;
    data['localized_name'] = this.localizedName;
    return data;
  }
}