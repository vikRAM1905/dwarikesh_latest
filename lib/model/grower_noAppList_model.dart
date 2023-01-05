class GrowerNoAppListModel {
  bool? status;
  int? totalgrowerCount;
  List<Data>? data;

  GrowerNoAppListModel({this.status, this.totalgrowerCount, this.data});

  GrowerNoAppListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalgrowerCount = json['totalgrowerCount'];
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
    data['totalgrowerCount'] = this.totalgrowerCount;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? bcmFactoryName;
  String? bcmGname;
  String? bcmFname;
  String? bcmGrowerCode;
  String? bcmGcode;
  String? bcmPhoneNumber;
  String? bcmVillage;
  String? bcmVillageCode;

  Data(
      {this.id,
      this.bcmFactoryName,
      this.bcmGname,
      this.bcmFname,
      this.bcmGrowerCode,
      this.bcmGcode,
      this.bcmPhoneNumber,
      this.bcmVillage,
      this.bcmVillageCode});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bcmFactoryName = json['bcm_factory_name'];
    bcmGname = json['bcm_gname'];
    bcmFname = json['bcm_fname'];
    bcmGrowerCode = json['bcm_grower_code'];
    bcmGcode = json['bcm_gcode'];
    bcmPhoneNumber = json['bcm_phone_number'];
    bcmVillage = json['bcm_village'];
    bcmVillageCode = json['bcm_village_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bcm_factory_name'] = this.bcmFactoryName;
    data['bcm_gname'] = this.bcmGname;
    data['bcm_fname'] = this.bcmFname;
    data['bcm_grower_code'] = this.bcmGrowerCode;
    data['bcm_gcode'] = this.bcmGcode;
    data['bcm_phone_number'] = this.bcmPhoneNumber;
    data['bcm_village'] = this.bcmVillage;
    data['bcm_village_code'] = this.bcmVillageCode;
    return data;
  }
}
