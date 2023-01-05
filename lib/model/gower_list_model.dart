class GowerListModel {
  bool? status;
  List<Data>? data;

  GowerListModel({this.status, this.data});

  GowerListModel.fromJson(Map<String, dynamic> json) {
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
  String? growername;
  String? fathername;
  String? growercode;
  String? phonenumber;
  String? personalvillage;
  int? plotcount;

  Data(
      {this.id,
      this.growername,
      this.fathername,
      this.growercode,
      this.phonenumber,
      this.personalvillage,
      this.plotcount});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    growername = json['growername'];
    fathername = json['fathername'];
    growercode = json['growercode'];
    phonenumber = json['phonenumber'];
    personalvillage = json['personalvillage'];
    plotcount = json['plotcount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['growername'] = this.growername;
    data['fathername'] = this.fathername;
    data['growercode'] = this.growercode;
    data['phonenumber'] = this.phonenumber;
    data['personalvillage'] = this.personalvillage;
    data['plotcount'] = this.plotcount;
    return data;
  }
}
