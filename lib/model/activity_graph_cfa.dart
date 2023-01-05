class ActivityGraphCfaModel {
  bool? status;
  List<Data>? data;

  ActivityGraphCfaModel({this.status, this.data});

  ActivityGraphCfaModel.fromJson(Map<String, dynamic> json) {
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
  String? approved;
  String? pending;
  String? actcompleted;
  String? totalactivity;
  int? percentage;
  String? color;
  String? image;
  int? totalplots;
  String? canearea;
  String? date;
  String? month;
  String? year;
  List<Details>? details;

  Activities(
      {this.id,
      this.name,
      this.percentage,
      this.approved,
      this.totalactivity,
      this.pending,
      this.color,
      this.image,
      this.actcompleted,
      this.totalplots,
      this.canearea,
      this.date,
      this.month,
      this.year,
      this.details});

  Activities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    percentage = json['percentage'];
    pending = json['pending'];
    totalactivity = json['totalactivity'];
    approved = json['approved'];
    actcompleted = json['actcompleted'];
    color = json['color'];
    image = json['image'];
    totalplots = json['totalplots'];
    canearea = json['canearea'];
    date = json['date'];
    month = json['month'];
    year = json['year'];
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(new Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['actcompleted'] = this.actcompleted;
    data['totalactivity'] = this.totalactivity;
    data['percentage'] = this.percentage;
    data['color'] = this.color;
    data['image'] = this.image;
    data['totalplots'] = this.totalplots;
    data['canearea'] = this.canearea;
    data['date'] = this.date;
    data['month'] = this.month;
    data['year'] = this.year;
    if (this.details != null) {
      data['details'] = this.details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  String? id;
  String? name;
  int? approvedplots;
  String? canearea;
  String? color;
  String? image;

  Details(
      {this.id,
      this.name,
      this.approvedplots,
      this.canearea,
      this.color,
      this.image});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    approvedplots = json['approvedplots'];
    canearea = json['canearea'];
    color = json['color'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['approvedplots'] = this.approvedplots;
    data['canearea'] = this.canearea;
    data['color'] = this.color;
    data['image'] = this.image;
    return data;
  }
}
