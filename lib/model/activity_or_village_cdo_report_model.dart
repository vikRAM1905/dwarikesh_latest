class ActivityorVillageCdoReportModel {
  bool? status;
  List<Data>? data;

  ActivityorVillageCdoReportModel({this.status, this.data});

  ActivityorVillageCdoReportModel.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? name;
  int? cfaid;
  String? cfaname;
  String? cfacode;
  String? approved;
  String? pending;
  int? percentage;
  int? approvedplots;
  String? canearea;
  String? totalactivity;
  String? actcompleted;
  String? color;
  String? image;

  Data(
      {this.id,
      this.name,
      this.cfaid,
      this.cfaname,
      this.cfacode,
      this.approved,
      this.pending,
      this.actcompleted,
      this.totalactivity,
      this.percentage,
      this.approvedplots,
      this.canearea,
      this.color,
      this.image});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    cfaid = json['cfaid'];
    cfaname = json['cfaname'];
    cfacode = json['cfacode'];
    approved = json['approved'];
    totalactivity = json['totalactivities'];
    pending = json['pending'];
    percentage = json['percentage'];
    approvedplots = json['approvedplots'];
    canearea = json['canearea'];
    actcompleted = json['actcompleted'];
    color = json['color'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['cfaid'] = this.cfaid;
    data['cfaname'] = this.cfaname;
    data['cfacode'] = this.cfacode;
    data['approved'] = this.approved;
    data['totalactivities'] = this.totalactivity;
    data['pending'] = this.pending;
    data['percentage'] = this.percentage;
    data['approvedplots'] = this.approvedplots;
    data['canearea'] = this.canearea;
    data['actcompleted'] = this.actcompleted;
    data['color'] = this.color;
    data['image'] = this.image;
    return data;
  }
}
