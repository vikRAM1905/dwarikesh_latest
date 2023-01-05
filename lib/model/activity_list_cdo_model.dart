class ActivityListCdoModel {
  bool? status;
  List<Data>? data;

  ActivityListCdoModel({this.status, this.data});

  ActivityListCdoModel.fromJson(Map<String, dynamic> json) {
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
  String? activitytype;
  String? activityname;
  String? growerid;
  String? growername;
  int? plotid;
  String? caneareaha;
  List<Groweractivityimage>? groweractivityimage;
  int? activitystatus;
  int? earnedrewardpoints;
  String? growercompletiondate;
  String? growerphone;
  String? growervillage;
  String? approveddate;
  String? overduestatus;
  String? overduedays;

  Data({
    this.id,
    this.activitytype,
    this.activityname,
    this.growerid,
    this.growername,
    this.plotid,
    this.caneareaha,
    this.groweractivityimage,
    this.activitystatus,
    this.earnedrewardpoints,
    this.growercompletiondate,
    this.growerphone,
    this.growervillage,
    this.approveddate,
    this.overduestatus,
    this.overduedays,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    activitytype = json['activitytype'];
    activityname = json['activityname'];
    growerid = json['growerid'];
    growername = json['growername'];
    plotid = json['plotid'];
    caneareaha = json['caneareaha'];
    if (json['groweractivityimage'] != null) {
      groweractivityimage = <Groweractivityimage>[];
      json['groweractivityimage'].forEach((v) {
        groweractivityimage!.add(new Groweractivityimage.fromJson(v));
      });
    }
    activitystatus = json['activitystatus'];
    earnedrewardpoints = json['earnedrewardpoints'];
    growercompletiondate = json['growercompletiondate'];
    growerphone = json['growerphone'];
    growervillage = json['growervillage'];
    approveddate = json['approveddate'];
    overduestatus = json['overduestatus'];
    overduedays = json['overduedays'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['activitytype'] = this.activitytype;
    data['activityname'] = this.activityname;
    data['growerid'] = this.growerid;
    data['growername'] = this.growername;
    data['plotid'] = this.plotid;
    data['caneareaha'] = this.caneareaha;
    if (this.groweractivityimage != null) {
      data['groweractivityimage'] =
          this.groweractivityimage!.map((v) => v.toJson()).toList();
    }
    data['activitystatus'] = this.activitystatus;
    data['earnedrewardpoints'] = this.earnedrewardpoints;
    data['growercompletiondate'] = this.growercompletiondate;
    data['growerphone'] = this.growerphone;
    data['growervillage'] = this.growervillage;
    data['approveddate'] = this.approveddate;
    data['overduestatus'] = this.overduestatus;
    data['overduedays'] = this.overduedays;
    return data;
  }
}

class Groweractivityimage {
  String? image;

  Groweractivityimage({this.image});

  Groweractivityimage.fromJson(Map<String, dynamic> json) {
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    return data;
  }
}
