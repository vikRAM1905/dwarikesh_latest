class ActivityCfaNameListModel {
  bool? status;
  List<Data>? data;

  ActivityCfaNameListModel({this.status, this.data});

  ActivityCfaNameListModel.fromJson(Map<String, dynamic> json) {
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
  int? cfaid;
  String? cfaname;
  String? cfacode;
  String? villageid;
  String? activityid;
  String? activityname;
  String? approved;
  String? actcompleted;
  String? totalactivity;
  String? pending;
  int? percentage;
  int? totalplots;
  String? canearea;
  String? phonenumber;
  String? color;
  String? image;

  Data(
      {this.cfaid,
      this.cfaname,
      this.cfacode,
      this.villageid,
      this.activityid,
      this.activityname,
      this.actcompleted,
      this.totalactivity,
      this.approved,
      this.pending,
      this.percentage,
      this.totalplots,
      this.canearea,
      this.color,
      this.image,
      this.phonenumber});

  Data.fromJson(Map<String, dynamic> json) {
    cfaid = json['cfaid'];
    cfaname = json['cfaname'];
    cfacode = json['cfacode'];
    villageid = json['villageid'];
    totalactivity = json['totalactivities'];
    activityid = json['activityid'];
    activityname = json['activityname'];
    approved = json['approved'];
    pending = json['pending'];
    percentage = json['percentage'];
    actcompleted = json['actcompleted'];
    totalplots = json['totalplots'];
    canearea = json['canearea'];
    color = json['color'];
    phonenumber = json['phonenumber'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cfaid'] = this.cfaid;
    data['cfaname'] = this.cfaname;
    data['cfacode'] = this.cfacode;
    data['villageid'] = this.villageid;
    data['totalactivity'] = this.totalactivity;
    data['activityid'] = this.activityid;
    data['activityname'] = this.activityname;
    data['approved'] = this.approved;
    data['pending'] = this.pending;
    data['actcompleted'] = this.actcompleted;
    data['percentage'] = this.percentage;
    data['totalplots'] = this.totalplots;
    data['canearea'] = this.canearea;
    data['color'] = this.color;
    data['phonenumber'] = this.phonenumber;
    data['image'] = this.image;
    return data;
  }
}
