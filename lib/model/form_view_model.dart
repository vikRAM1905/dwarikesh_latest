class FormViewModel {
  bool? status;
  List<Data>? data;

  FormViewModel({this.status, this.data});

  FormViewModel.fromJson(Map<String, dynamic> json) {
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
  String? activityType;
  String? cropType;
  String? activityCode;
  String? activityName;
  String? activityDate;
  String? activityUpdatedDate;
  String? inputQty;
  String? unit;
  String? valueChar;
  String? image;
  String? remarks;
  String? updatedBy;

  Data(
      {this.id,
      this.villageCode,
      this.villageName,
      this.growerCode,
      this.growerName,
      this.growerFatherName,
      this.varietyCode,
      this.varietyName,
      this.activityType,
      this.cropType,
      this.activityCode,
      this.activityName,
      this.activityDate,
      this.activityUpdatedDate,
      this.inputQty,
      this.unit,
      this.valueChar,
      this.image,
      this.remarks,
      this.updatedBy});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    villageCode = json['village_code'];
    villageName = json['village_name'];
    growerCode = json['grower_code'];
    growerName = json['grower_name'];
    growerFatherName = json['grower_father_name'];
    varietyCode = json['variety_code'];
    varietyName = json['variety_name'];
    activityType = json['activity_type'];
    cropType = json['crop_type'];
    activityCode = json['activity_code'];
    activityName = json['activity_name'];
    activityDate = json['activity_date'];
    activityUpdatedDate = json['activity_updated_date'];
    inputQty = json['input_qty'];
    unit = json['unit'];
    valueChar = json['value_char'];
    image = json['image'];
    remarks = json['remarks'];
    updatedBy = json['updated_by'];
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
    data['activity_type'] = activityType;
    data['crop_type'] = this.cropType;
    data['activity_code'] = this.activityCode;
    data['activity_name'] = this.activityName;
    data['activity_date'] = this.activityDate;
    data['activity_updated_date'] = this.activityUpdatedDate;
    data['input_qty'] = this.inputQty;
    data['unit'] = this.unit;
    data['value_char'] = this.valueChar;
    data['image'] = this.image;
    data['remarks'] = this.remarks;
    data['updated_by'] = this.updatedBy;
    return data;
  }
}
