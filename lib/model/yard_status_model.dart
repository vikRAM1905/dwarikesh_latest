class YardStatusModel {
  bool? status;
  List<Data>? data;

  YardStatusModel({this.status, this.data});

  YardStatusModel.fromJson(Map<String, dynamic> json) {
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
  String? data1;
  String? data2;
  String? data3;
  String? data4;
  String? data5;

  Data({this.data1, this.data2, this.data3, this.data4, this.data5});

  Data.fromJson(Map<String, dynamic> json) {
    data1 = json['data1'];
    data2 = json['data2'];
    data3 = json['data3'];
    data4 = json['data4'];
    data5 = json['data5'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data1'] = this.data1;
    data['data2'] = this.data2;
    data['data3'] = this.data3;
    data['data4'] = this.data4;
    data['data5'] = this.data5;
    return data;
  }
}
