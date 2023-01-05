class ActivityCdoReportList {
  bool? status;
  List<Data>? data;

  ActivityCdoReportList({this.status, this.data});

  ActivityCdoReportList.fromJson(Map<String, dynamic> json) {
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
  int? type;
  String? tabname;
  List<Activities>? activities;

  Data({this.type, this.tabname, this.activities});

  Data.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    tabname = json['tabname'];
    if (json['activities'] != null) {
      activities = <Activities>[];
      json['activities'].forEach((v) {
        activities!.add(new Activities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['tabname'] = this.tabname;
    if (this.activities != null) {
      data['activities'] = this.activities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Activities {
  String? id;
  String? name;
  String? code;
  String? phonenumber;
  String? approved;
  String? pending;
  String? actcompleted;
  String? totalactivity;
  int? approvedplots;
  String? totalarea;
  int? progress;
  int? percentage;
  String? color;
  String? image;

  Activities(
      {this.id,
      this.name,
      this.code,
      this.phonenumber,
      this.approved,
      this.pending,
      this.approvedplots,
      this.totalactivity,
      this.totalarea,
      this.progress,
      this.actcompleted,
      this.percentage,
      this.color,
      this.image});

  Activities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    phonenumber = json['phonenumber'];
    approved = json['approved'];
    pending = json['pending'];
    approvedplots = json['approvedplots'];
    totalactivity = json['totalactivity'];
    totalarea = json['totalarea'];
    progress = json['progress'];
    percentage = json['percentage'];
    actcompleted = json['actcompleted'];
    color = json['color'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['phonenumber'] = this.phonenumber;
    data['approved'] = this.approved;
    data['totalactivities'] = this.totalactivity;
    data['pending'] = this.pending;
    data['approvedplots'] = this.approvedplots;
    data['totalarea'] = this.totalarea;
    data['progress'] = this.progress;
    data['percentage'] = this.percentage;
    data['color'] = this.color;
    data['image'] = this.image;
    data['actcompleted'] = this.actcompleted;
    return data;
  }
}
