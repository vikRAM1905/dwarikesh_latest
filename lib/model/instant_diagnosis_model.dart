class InstantDiagnosisListModel {
  String? status;
  Result? result;

  InstantDiagnosisListModel({this.status, this.result});

  InstantDiagnosisListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result = json['results'] != null
        ? Result.fromJson(json['results'])
        : Result("", "", OtherInfo("", "", "", "", "", "", ""));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['results'] = this.result;
    return data;
  }
}

class Result {
  String? message;
  String? key;
  OtherInfo? otherInfo;

  Result(this.message, this.key, this.otherInfo);

  Result.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    key = json['key'];
    otherInfo = json['otherInfo'] != null
        ? OtherInfo.fromJson(json['otherInfo'])
        : OtherInfo("", "", "", "", "", "", "");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['key'] = this.key;
    data['otherInfo'] = this.otherInfo;
    return data;
  }
}

class OtherInfo {
  String? cropType;
  String? category;
  String? name;
  String? symptoms;
  String? cause;
  String? comments;
  String? management;

  OtherInfo(this.cropType, this.category, this.name, this.symptoms, this.cause,
      this.comments, this.management);

  OtherInfo.fromJson(Map<String, dynamic> json) {
    cropType = json['cropType'];
    category = json['category'];
    name = json['name'];
    symptoms = json['symptoms'];
    cause = json['cause'];
    comments = json['comments'];
    management = json['management'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cropType'] = this.cropType;
    data['category'] = this.category;
    data['name'] = this.name;
    data['symptoms'] = this.symptoms;
    data['cause'] = this.cause;
    data['comments'] = this.comments;
    data['management'] = this.management;
    return data;
  }
}
