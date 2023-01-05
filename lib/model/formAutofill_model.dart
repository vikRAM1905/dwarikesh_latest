class AutoFillModel {
  bool? status;
  List<Data>? data;

  AutoFillModel({this.status, this.data});

  AutoFillModel.fromJson(Map<String, dynamic> json) {
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
  String? villageCode;
  String? villageName;
  String? growerCode;
  String? growerName;
  String? growerFatherName;
  String? varietyCode;
  String? varietyName;
  String? croptype;

  Data(
      {this.id,
      this.villageCode,
      this.villageName,
      this.growerCode,
      this.growerName,
      this.growerFatherName,
      this.varietyCode,
      this.varietyName,
      this.croptype});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    villageCode = json['village_code'];
    villageName = json['village_name'];
    growerCode = json['grower_code'];
    growerName = json['grower_name'];
    growerFatherName = json['grower_father_name'];
    varietyCode = json['variety_code'];
    varietyName = json['variety_name'];
    croptype = json['croptype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['village_code'] = this.villageCode;
    data['village_name'] = this.villageName;
    data['grower_code'] = this.growerCode;
    data['grower_name'] = this.growerName;
    data['grower_father_name'] = this.growerFatherName;
    data['variety_code'] = this.varietyCode;
    data['variety_name'] = this.varietyName;
    data['croptype'] = this.croptype;
    return data;
  }
}
