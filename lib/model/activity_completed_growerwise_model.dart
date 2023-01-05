class ActivityCompletedGowerwiseModel {
  bool? status;
  List<Data>? data;

  ActivityCompletedGowerwiseModel({this.status, this.data});

  ActivityCompletedGowerwiseModel.fromJson(Map<String, dynamic> json) {
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
  String? season;
  String? growername;
  String? growercode;
  String? canearea;
  String? unit;
  int? plotid;
  int? villageid;
  String? growervillage;
  String? phonenumber;
  int? activitycount;

  Data(
      {this.id,
      this.season,
      this.growername,
      this.growercode,
      this.canearea,
      this.unit,
      this.plotid,
      this.villageid,
      this.growervillage,
      this.phonenumber,
      this.activitycount});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    season = json['season'];
    growername = json['growername'];
    growercode = json['growercode'];
    canearea = json['canearea'];
    unit = json['unit'];
    plotid = json['plotid'];
    villageid = json['villageid'];
    growervillage = json['growervillage'];
    phonenumber = json['phonenumber'];
    activitycount = json['activitycount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['season'] = this.season;
    data['growername'] = this.growername;
    data['growercode'] = this.growercode;
    data['canearea'] = this.canearea;
    data['unit'] = this.unit;
    data['plotid'] = this.plotid;
    data['villageid'] = this.villageid;
    data['growervillage'] = this.growervillage;
    data['phonenumber'] = this.phonenumber;
    data['activitycount'] = this.activitycount;
    return data;
  }
}
