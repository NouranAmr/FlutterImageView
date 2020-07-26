class ExtraImages {
  int carId;
  int type;
  Null path;
  List<String> items;

  ExtraImages({this.carId, this.type, this.path, this.items});

  ExtraImages.fromJson(Map<String, dynamic> json) {
    carId = json['carId'];
    type = json['type'];
    path = json['path'];
    items = json['items'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['carId'] = this.carId;
    data['type'] = this.type;
    data['path'] = this.path;
    data['items'] = this.items;
    return data;
  }
}