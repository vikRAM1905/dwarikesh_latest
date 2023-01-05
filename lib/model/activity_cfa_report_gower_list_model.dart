class ActivityCFAReportGowerList {
  bool? status;
  List<Data>? data;

  ActivityCFAReportGowerList({this.status, this.data});

  ActivityCFAReportGowerList.fromJson(Map<String, dynamic> json) {
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
  String? growername;
  String? growercode;
  String? phoneNumber;
  int? activityid;
  String? activityname;
  int? plotid;
  String? caneareaha;
  String? growervillage;
  String? activitystatus;
  String? status;
  String? latlongvillage;

  Data(
      {this.growername,
      this.growercode,
      this.phoneNumber,
      this.activityid,
      this.activityname,
      this.plotid,
      this.caneareaha,
      this.growervillage,
      this.activitystatus,
      this.status,
      this.latlongvillage});

  Data.fromJson(Map<String, dynamic> json) {
    growername = json['growername'];
    growercode = json['growercode'];
    phoneNumber = json['phone_number'];
    activityid = json['activityid'];
    activityname = json['activityname'];
    plotid = json['plotid'];
    caneareaha = json['caneareaha'];
    growervillage = json['growervillage'];
    activitystatus = json['activitystatus'];
    latlongvillage = json['latlongvillage'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['growername'] = this.growername;
    data['growercode'] = this.growercode;
    data['phone_number'] = this.phoneNumber;
    data['activityid'] = this.activityid;
    data['activityname'] = this.activityname;
    data['plotid'] = this.plotid;
    data['caneareaha'] = this.caneareaha;
    data['latlongvillage'] = this.latlongvillage;
    data['growervillage'] = this.growervillage;
    data['activitystatus'] = this.activitystatus;
    data['status'] = this.status;
    return data;
  }
}
