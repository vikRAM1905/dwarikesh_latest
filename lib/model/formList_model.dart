class PlotListModel {
  bool? status;
  List<Demoplots>? demoplots;
  List<DemoplotHeaderInfo>? demoplotHeaderInfo;

  PlotListModel({this.status, this.demoplots, this.demoplotHeaderInfo});

  PlotListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['demoplots'] != null) {
      demoplots = <Demoplots>[];
      json['demoplots'].forEach((v) {
        demoplots!.add(new Demoplots.fromJson(v));
      });
    }
    if (json['demoplot_header_info'] != null) {
      demoplotHeaderInfo = <DemoplotHeaderInfo>[];
      json['demoplot_header_info'].forEach((v) {
        demoplotHeaderInfo!.add(new DemoplotHeaderInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.demoplots != null) {
      data['demoplots'] = this.demoplots!.map((v) => v.toJson()).toList();
    }
    if (this.demoplotHeaderInfo != null) {
      data['demoplot_header_info'] =
          this.demoplotHeaderInfo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Demoplots {
  String? name;

  Demoplots({this.name});

  Demoplots.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class DemoplotHeaderInfo {
  int? id;
  String? growerCode;
  String? villageCode;
  String? croptype;
  String? varietyCode;
  String? varietyName;
  String? factoryId;

  DemoplotHeaderInfo(
      {this.id,
      this.growerCode,
      this.villageCode,
      this.croptype,
      this.varietyCode,
      this.varietyName,
      this.factoryId});

  DemoplotHeaderInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    growerCode = json['grower_code'];
    villageCode = json['village_code'];
    croptype = json['croptype'];
    varietyCode = json['variety_code'];
    varietyName = json['variety_name'];
    factoryId = json['factory_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['grower_code'] = this.growerCode;
    data['village_code'] = this.villageCode;
    data['croptype'] = this.croptype;
    data['variety_code'] = this.varietyCode;
    data['variety_name'] = this.varietyName;
    data['factory_id'] = this.factoryId;
    return data;
  }
}
