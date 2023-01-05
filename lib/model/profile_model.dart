class ProfileModel {
  bool? success;
  String? roleId;
  String? factoryname;
  String? name;
  String? fathername;
  String? code;
  String? reportingName;
  String? reportingPhone;
  String? reportingCode;
  String? culturablearea;
  String? canearea;
  String? phonenumber;
  int? count;
  int? villagecount;
  int? id;
  List<Zonal>? zonal;
  String? address;
  String? accountNumber;
  String? aadharNumber;
  List<Plot>? plot;
  List<Centre>? centre;

  ProfileModel(
      {this.success,
      this.roleId,
      this.factoryname,
      this.name,
      this.fathername,
      this.code,
      this.reportingName,
      this.reportingPhone,
      this.reportingCode,
      this.culturablearea,
      this.canearea,
      this.phonenumber,
      this.count,
      this.villagecount,
      this.id,
      this.zonal,
      this.address,
      this.accountNumber,
      this.aadharNumber,
      this.plot,
      this.centre});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    roleId = json['role_id'];
    factoryname = json['factoryname'];
    name = json['name'];
    fathername = json['fathername'];
    code = json['code'];
    reportingName = json['reporting_name'];
    reportingPhone = json['reporting_phone'];
    reportingCode = json['reporting_code'];
    culturablearea = json['culturablearea'];
    canearea = json['canearea'];
    phonenumber = json['phonenumber'];
    count = json['count'];
    villagecount = json['villagecount'];
    id = json['id'];
    if (json['zonal'] != null) {
      zonal = <Zonal>[];
      json['zonal'].forEach((v) {
        zonal!.add(new Zonal.fromJson(v));
      });
    }
    address = json['address'];
    accountNumber = json['account_number'];
    aadharNumber = json['aadhar_number'];
    if (json['plot'] != null) {
      plot = <Plot>[];
      json['plot'].forEach((v) {
        plot!.add(new Plot.fromJson(v));
      });
    }
    if (json['centre'] != null) {
      centre = <Centre>[];
      json['centre'].forEach((v) {
        centre!.add(new Centre.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['role_id'] = this.roleId;
    data['factoryname'] = this.factoryname;
    data['name'] = this.name;
    data['fathername'] = this.fathername;
    data['code'] = this.code;
    data['reporting_name'] = this.reportingName;
    data['reporting_phone'] = this.reportingPhone;
    data['reporting_code'] = this.reportingCode;
    data['culturablearea'] = this.culturablearea;
    data['canearea'] = this.canearea;
    data['phonenumber'] = this.phonenumber;
    data['count'] = this.count;
    data['villagecount'] = this.villagecount;
    data['id'] = this.id;
    if (this.zonal != null) {
      data['zonal'] = this.zonal!.map((v) => v.toJson()).toList();
    }
    data['address'] = this.address;
    data['account_number'] = this.accountNumber;
    data['aadhar_number'] = this.aadharNumber;
    if (this.plot != null) {
      data['plot'] = this.plot!.map((v) => v.toJson()).toList();
    }
    if (this.centre != null) {
      data['centre'] = this.centre!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Zonal {
  String? bcmStateHindi;
  String? bcmDistrictHindi;
  String? bcmVillageHindi;

  Zonal({this.bcmStateHindi, this.bcmDistrictHindi, this.bcmVillageHindi});

  Zonal.fromJson(Map<String, dynamic> json) {
    bcmStateHindi = json['bcm_state_hindi'];
    bcmDistrictHindi = json['bcm_district_hindi'];
    bcmVillageHindi = json['bcm_village_hindi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bcm_state_hindi'] = this.bcmStateHindi;
    data['bcm_district_hindi'] = this.bcmDistrictHindi;
    data['bcm_village_hindi'] = this.bcmVillageHindi;
    return data;
  }
}

class Plot {
  int? plotid;
  String? cfaName;
  String? cfaPhone;
  String? cfaCode;
  String? stateName;
  String? districtName;
  String? villageName;
  String? caneArea;
  String? cropType;
  String? caneVariety;
  String? startDate;
  String? deleteBtn;
  String? ratoonStatus;
  int? plotShare;
  String? estimatedYield;
  String? harvestingDate;

  Plot(
      {this.plotid,
      this.cfaName,
      this.cfaPhone,
      this.cfaCode,
      this.stateName,
      this.districtName,
      this.villageName,
      this.caneArea,
      this.cropType,
      this.caneVariety,
      this.startDate,
      this.deleteBtn,
      this.ratoonStatus,
      this.plotShare,
      this.estimatedYield,
      this.harvestingDate});

  Plot.fromJson(Map<String, dynamic> json) {
    plotid = json['plotid'];
    cfaName = json['cfa_name'];
    cfaPhone = json['cfa_phone'];
    cfaCode = json['cfa_code'];
    stateName = json['state_name'];
    districtName = json['district_name'];
    villageName = json['village_name'];
    caneArea = json['cane_area'];
    cropType = json['crop_type'];
    caneVariety = json['cane_variety'];
    startDate = json['start_date'];
    deleteBtn = json['delete_btn'];
    ratoonStatus = json['ratoon_status'];
    plotShare = json['plot_share'];
    estimatedYield = json['estimated_yield'];
    harvestingDate = json['harvesting_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['plotid'] = this.plotid;
    data['cfa_name'] = this.cfaName;
    data['cfa_phone'] = this.cfaPhone;
    data['cfa_code'] = this.cfaCode;
    data['state_name'] = this.stateName;
    data['district_name'] = this.districtName;
    data['village_name'] = this.villageName;
    data['cane_area'] = this.caneArea;
    data['crop_type'] = this.cropType;
    data['cane_variety'] = this.caneVariety;
    data['start_date'] = this.startDate;
    data['delete_btn'] = this.deleteBtn;
    data['ratoon_status'] = this.ratoonStatus;
    data['plot_share'] = this.plotShare;
    data['estimated_yield'] = this.estimatedYield;
    data['harvesting_date'] = this.harvestingDate;
    return data;
  }
}

class Centre {
  String? centre;
  String? society;
  String? village;
  String? villagecode;
  String? district;

  Centre(
      {this.centre,
      this.society,
      this.village,
      this.villagecode,
      this.district});

  Centre.fromJson(Map<String, dynamic> json) {
    centre = json['centre'];
    society = json['society'];
    village = json['village'];
    villagecode = json['villagecode'];
    district = json['district'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['centre'] = this.centre;
    data['society'] = this.society;
    data['village'] = this.village;
    data['villagecode'] = this.villagecode;
    data['district'] = this.district;
    return data;
  }
}
