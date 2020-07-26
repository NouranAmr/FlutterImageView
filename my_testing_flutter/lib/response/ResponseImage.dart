class ResponseImage {
  String src;
  Null attachment;
  Null pictureType;

  ResponseImage({this.src, this.attachment, this.pictureType});

  ResponseImage.fromJson(Map<String, dynamic> json) {
    src = json['src'];
    attachment = json['attachment'];
    pictureType = json['pictureType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['src'] = this.src;
    data['attachment'] = this.attachment;
    data['pictureType'] = this.pictureType;
    return data;
  }
}