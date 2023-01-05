class GowerReqReportModel {
  bool? status;
  List<Data>? data;

  GowerReqReportModel({this.status, this.data});

  GowerReqReportModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? date;
  String? cfaname;
  String? canearea;
  String? request;
  String? response;
  int? plotid;
  int? id;
  String? status;
  String? croptype;

  Data(
      {this.name,
      this.date,
      this.cfaname,
      this.canearea,
      this.request,
      this.response,
      this.plotid,
      this.id,
      this.status,
      this.croptype});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    date = json['date'];
    cfaname = json['cfaname'];
    canearea = json['canearea'];
    request = json['request'];
    response = json['response'];
    plotid = json['plotid'];
    id = json['id'];
    status = json['status'];
    croptype = json['croptype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['date'] = this.date;
    data['cfaname'] = this.cfaname;
    data['canearea'] = this.canearea;
    data['request'] = this.request;
    data['response'] = this.response;
    data['plotid'] = this.plotid;
    data['id'] = this.id;
    data['status'] = this.status;
    data['croptype'] = this.croptype;
    return data;
  }
}
