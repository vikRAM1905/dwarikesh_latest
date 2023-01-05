class AccountListModel {
  bool? status;
  List<Data>? data;

  AccountListModel({this.status, this.data});

  AccountListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? code;
  String? name;
  String? image;
  String? token;
  bool? clickPos = false;

  Data({this.id, this.code, this.name, this.image, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    image = json['image'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['image'] = this.image;
    data['token'] = this.token;
    return data;
  }

  bool get getPosition {
    return clickPos!;
  }

  set setPosition(bool value) {
    this.clickPos = value;
  }
}
