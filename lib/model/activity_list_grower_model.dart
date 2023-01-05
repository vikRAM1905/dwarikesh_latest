class ActivityListGrowerModel {
  bool? status;
  String? totalRewardPoints;
  int? totalData;
  int? pageCount;
  List<Data>? data;

  ActivityListGrowerModel(
      {this.status,
      this.totalRewardPoints,
      this.totalData,
      this.pageCount,
      this.data});

  ActivityListGrowerModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalRewardPoints = json['total_reward_points'];
    totalData = json['totalData'];
    pageCount = json['pageCount'];
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
    data['total_reward_points'] = this.totalRewardPoints;
    data['totalData'] = this.totalData;
    data['pageCount'] = this.pageCount;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? type;
  int? activityId;
  String? activityType;
  String? activitySeason;
  String? activityName;
  String? activityEndMonth;
  String? growerCompletedDate;
  int? activityRewardPoints;
  int? activityEarnedPoints;
  String? activityImage;
  List<Groweractivityimage>? groweractivityimage;
  String? activitySteps;
  int? activityStatus;
  int? plotId;
  int? cfaId;
  String? caneAreaHa;
  String? cropType;
  String? caneVariety;
  String? bcmState;
  String? bcmDistrict;
  String? bcmVillage;
  String? villageName;
  String? overduestatus;
  String? overduedays;
  // List<Plotinfo>? plotinfo;

  Data({
    this.type,
    this.activityId,
    this.activityType,
    this.activitySeason,
    this.activityName,
    this.activityEndMonth,
    this.growerCompletedDate,
    this.activityRewardPoints,
    this.activityEarnedPoints,
    this.activityImage,
    this.groweractivityimage,
    this.activitySteps,
    this.activityStatus,
    this.plotId,
    this.cfaId,
    this.caneAreaHa,
    this.cropType,
    this.caneVariety,
    this.bcmState,
    this.bcmDistrict,
    this.bcmVillage,
    this.villageName,
    this.overduestatus,
    this.overduedays,
    // this.plotinfo
  });

  Data.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    activityId = json['activity_id'];
    activityType = json['activity_type'];
    activitySeason = json['activity_season'];
    activityName = json['activity_name'];
    activityEndMonth = json['activity_end_month'];
    growerCompletedDate = json['grower_completed_date'];
    activityRewardPoints = json['activity_reward_points'];
    activityEarnedPoints = json['activity_earned_points'];
    activityImage = json['activity_image'];
    if (json['groweractivityimage'] != null) {
      groweractivityimage = <Groweractivityimage>[];
      json['groweractivityimage'].forEach((v) {
        groweractivityimage!.add(new Groweractivityimage.fromJson(v));
      });
    }
    activitySteps = json['activity_steps'];
    activityStatus = json['activity_status'];
    plotId = json['plot_id'];
    cfaId = json['cfa_id'];
    caneAreaHa = json['cane_area_ha'];
    cropType = json['crop_type'];
    caneVariety = json['cane_variety'];
    bcmState = json['bcm_state'];
    bcmDistrict = json['bcm_district'];
    bcmVillage = json['bcm_village'];
    villageName = json['village_name'];
    overduestatus = json['overduestatus'];
    overduedays = json['overduedays'];
    // if (json['plotinfo'] != null) {
    //   plotinfo = <Plotinfo>[];
    //   json['plotinfo'].forEach((v) {
    //     plotinfo!.add(new Plotinfo.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['activity_id'] = this.activityId;
    data['activity_type'] = this.activityType;
    data['activity_season'] = this.activitySeason;
    data['activity_name'] = this.activityName;
    data['activity_end_month'] = this.activityEndMonth;
    data['grower_completed_date'] = this.growerCompletedDate;
    data['activity_reward_points'] = this.activityRewardPoints;
    data['activity_earned_points'] = this.activityEarnedPoints;
    data['activity_image'] = this.activityImage;
    if (this.groweractivityimage != null) {
      data['groweractivityimage'] =
          this.groweractivityimage!.map((v) => v.toJson()).toList();
    }
    data['activity_steps'] = this.activitySteps;
    data['activity_status'] = this.activityStatus;
    data['plot_id'] = this.plotId;
    data['cfa_id'] = this.cfaId;
    data['cane_area_ha'] = this.caneAreaHa;
    data['crop_type'] = this.cropType;
    data['cane_variety'] = this.caneVariety;
    data['bcm_state'] = this.bcmState;
    data['bcm_district'] = this.bcmDistrict;
    data['bcm_village'] = this.bcmVillage;
    data['village_name'] = this.villageName;
    data['overduestatus'] = this.overduestatus;
    data['overduedays'] = this.overduedays;
    // if (this.plotinfo != null) {
    //   data['plotinfo'] = this.plotinfo!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Groweractivityimage {
  String? image;

  Groweractivityimage({this.image});

  Groweractivityimage.fromJson(Map<String, dynamic> json) {
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    return data;
  }
}

// class Plotinfo {
//   int? plotid;
//   String? villagename;
//   String? canearea;
//   String? caneareaunit;

//   Plotinfo({this.plotid, this.villagename, this.canearea, this.caneareaunit});

//   Plotinfo.fromJson(Map<String, dynamic> json) {
//     plotid = json['plotid'];
//     villagename = json['villagename'];
//     canearea = json['canearea'];
//     caneareaunit = json['caneareaunit'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['plotid'] = this.plotid;
//     data['villagename'] = this.villagename;
//     data['canearea'] = this.canearea;
//     data['caneareaunit'] = this.caneareaunit;
//     return data;
//   }
// }
