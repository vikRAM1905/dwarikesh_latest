class ActivityorVillageCfaReportModel {
  bool? status;
  List<Data>? data;

  ActivityorVillageCfaReportModel({this.status, this.data});

  ActivityorVillageCfaReportModel.fromJson(Map<String, dynamic> json) {
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
  int? percentage;
  int? totalplots;
  String? canearea;
  String? totalactivity;
  String? color;
  String? image;
  String? approved;
  String? pending;
  String? actcompleted;

  Data(
      {this.id,
      this.name,
      this.percentage,
      this.totalplots,
      this.canearea,
      this.totalactivity,
      this.color,
      this.approved,
      this.pending,
      this.actcompleted,
      this.image});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    percentage = json['percentage'];
    totalplots = json['totalplots'];
    canearea = json['canearea'];
    totalactivity = json['totalactivities'];
    color = json['color'];
    approved = json['approved'];
    actcompleted = json['actcompleted'];
    pending = json['pending'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['percentage'] = this.percentage;
    data['totalplots'] = this.totalplots;
    data['totalactivities'] = this.totalactivity;
    data['actcompleted'] = this.actcompleted;
    data['canearea'] = this.canearea;
    data['color'] = this.color;
    data['image'] = this.image;
    data['approved'] = this.approved;
    data['pending'] = this.pending;
    return data;
  }
}
