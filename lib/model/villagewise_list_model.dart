class VillagewiseListModel {
  bool? status;
  int? totalvillage;
  List<Data>? data;

  VillagewiseListModel({this.status, this.totalvillage, this.data});

  VillagewiseListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalvillage = json['totalvillage'];
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
    data['totalvillage'] = this.totalvillage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? villageid;
  String? villagename;
  int? growercount;
  int? notdownloadcount;

  Data(
      {this.villageid,
      this.villagename,
      this.growercount,
      this.notdownloadcount});

  Data.fromJson(Map<String, dynamic> json) {
    villageid = json['villageid'];
    villagename = json['villagename'];
    growercount = json['growercount'];
    notdownloadcount = json['notdownloadcount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['villageid'] = this.villageid;
    data['villagename'] = this.villagename;
    data['growercount'] = this.growercount;
    data['notdownloadcount'] = this.notdownloadcount;
    return data;
  }
}
