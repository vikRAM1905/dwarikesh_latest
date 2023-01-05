class RequestAddModel {
  bool? status;
  List<Data>? data;
  List<Ratoon>? ratoon;
  List<Plot>? plot;

  RequestAddModel({this.status, this.data, this.ratoon});

  RequestAddModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    if (json['ratoon'] != null) {
      ratoon = <Ratoon>[];
      json['ratoon'].forEach((v) {
        ratoon!.add(new Ratoon.fromJson(v));
      });
    }
    if (json['plot'] != null) {
      plot = <Plot>[];
      json['plot'].forEach((v) {
        plot!.add(new Plot.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.ratoon != null) {
      data['ratoon'] = this.ratoon!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? type;
  List<Subquery>? subquery;

  Data({this.type, this.subquery});

  Data.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['subquery'] != null) {
      subquery = <Subquery>[];
      json['subquery'].forEach((v) {
        subquery!.add(new Subquery.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.subquery != null) {
      data['subquery'] = this.subquery!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subquery {
  String? subquery;
  int? id;

  Subquery({this.subquery, this.id});

  Subquery.fromJson(Map<String, dynamic> json) {
    subquery = json['subquery'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subquery'] = this.subquery;
    data['id'] = this.id;
    return data;
  }
}

class Ratoon {
  String? type;

  Ratoon({this.type});

  Ratoon.fromJson(Map<String, dynamic> json) {
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    return data;
  }
}

class Plot {
  int? plotid;
  String? cfaName;
  String? ratoon_status;
  String? cfaPhone;
  String? cfaCode;
  String? stateName;
  String? districtName;
  String? villageName;
  String? caneArea;
  String? cropType;
  String? caneVariety;
  String? startDate;

  Plot(
      {this.plotid,
      this.cfaName,
      this.cfaPhone,
      this.ratoon_status,
      this.cfaCode,
      this.stateName,
      this.districtName,
      this.villageName,
      this.caneArea,
      this.cropType,
      this.caneVariety,
      this.startDate});

  Plot.fromJson(Map<String, dynamic> json) {
    plotid = json['plotid'];
    cfaName = json['cfa_name'];
    cfaPhone = json['cfa_phone'];
    ratoon_status = json['ratoon_status'];
    cfaCode = json['cfa_code'];
    stateName = json['state_name'];
    districtName = json['district_name'];
    villageName = json['village_name'];
    caneArea = json['cane_area'];
    cropType = json['crop_type'];
    caneVariety = json['cane_variety'];
    startDate = json['start_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['plotid'] = this.plotid;
    data['cfa_name'] = this.cfaName;
    data['cfa_phone'] = this.cfaPhone;
    data['ratoon_status'] = this.ratoon_status;
    data['cfa_code'] = this.cfaCode;
    data['state_name'] = this.stateName;
    data['district_name'] = this.districtName;
    data['village_name'] = this.villageName;
    data['cane_area'] = this.caneArea;
    data['crop_type'] = this.cropType;
    data['cane_variety'] = this.caneVariety;
    data['start_date'] = this.startDate;
    return data;
  }
}
