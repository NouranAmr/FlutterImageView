class CarMakeImage360 {
  int carId;
  int type;
  String colorhex;
  String path;
  List<String> items;

  CarMakeImage360(
      {this.carId, this.type, this.colorhex, this.path, this.items});

  CarMakeImage360.fromJson(Map<String, dynamic> json) {
    carId = json['carId'];
    type = json['type'];
    colorhex = json['colorhex'];
    path = json['path'];
    items = json['items'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['carId'] = this.carId;
    data['type'] = this.type;
    data['colorhex'] = this.colorhex;
    data['path'] = this.path;
    data['items'] = this.items;
    return data;
  }
}