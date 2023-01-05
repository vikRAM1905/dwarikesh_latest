class DashboardModel {
  bool? status;
  bool? updatetrigger;
  bool? cancelbtn;
  String? appstore;
  String? name;
  String? id;
  String? token;
  String? phonenumber;
  List<Banners>? banner;
  List<Incomeresponse>? incomeresponse;
  List<Menu>? menu;
  List<Groweractivities>? groweractivities;
  List<Cfarequest>? cfarequest;
  List<Cdorequest>? cdorequest;

  DashboardModel(
      {this.status,
      this.updatetrigger,
      this.cancelbtn,
      this.appstore,
      this.name,
      this.token,
      this.phonenumber,
      this.id,
      this.menu,
      this.incomeresponse,
      this.groweractivities,
      this.cfarequest,
      this.banner,
      this.cdorequest});

  DashboardModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    name = json['name'];
    token = json['token'];
    cancelbtn = json['updatecancel'];
    updatetrigger = json['updatetrigger'];
    appstore = json['appstore'];
    id = json['id'];
    phonenumber = json['phonenumber'];

    if (json['banner'] != null) {
      banner = <Banners>[];
      json['banner'].forEach((v) {
        banner!.add(new Banners.fromJson(v));
      });
    }
    if (json['incomeresponse'] != null) {
      incomeresponse = <Incomeresponse>[];
      json['incomeresponse'].forEach((v) {
        incomeresponse!.add(new Incomeresponse.fromJson(v));
      });
    }

    if (json['menu'] != null) {
      menu = <Menu>[];
      json['menu'].forEach((v) {
        menu!.add(new Menu.fromJson(v));
      });
    }
    if (json['groweractivities'] != null) {
      groweractivities = <Groweractivities>[];
      json['groweractivities'].forEach((v) {
        groweractivities!.add(new Groweractivities.fromJson(v));
      });
    }

    if (json['cfarequest'] != null) {
      cfarequest = <Cfarequest>[];
      json['cfarequest'].forEach((v) {
        cfarequest!.add(new Cfarequest.fromJson(v));
      });
    }

    if (json['cdorequest'] != null) {
      cdorequest = <Cdorequest>[];
      json['cdorequest'].forEach((v) {
        cdorequest!.add(new Cdorequest.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['name'] = this.name;
    data['phonenumber'] = this.phonenumber;
    if (this.banner != null) {
      data['banner'] = this.banner!.map((v) => v.toJson()).toList();
    }
    if (this.incomeresponse != null) {
      data['incomeresponse'] =
          this.incomeresponse!.map((v) => v.toJson()).toList();
    }
    if (this.menu != null) {
      data['menu'] = this.menu!.map((v) => v.toJson()).toList();
    }
    if (this.groweractivities != null) {
      data['groweractivities'] =
          this.groweractivities!.map((v) => v.toJson()).toList();
    }
    if (this.cfarequest != null) {
      data['cfarequest'] = this.cfarequest!.map((v) => v.toJson()).toList();
    }
    if (this.cdorequest != null) {
      data['cdorequest'] = this.cdorequest!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Banners {
  String? image;
  String? page;

  Banners({this.image, this.page});

  Banners.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['page'] = this.page;
    return data;
  }
}

class Incomeresponse {
  String? text;
  String? symbol;
  String? incomeAmount;

  Incomeresponse({this.text, this.symbol, this.incomeAmount});

  Incomeresponse.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    symbol = json['symbol'];
    incomeAmount = json['income_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['symbol'] = this.symbol;
    data['income_amount'] = this.incomeAmount;
    return data;
  }
}

class Menu {
  String? id;
  String? title;
  String? count;
  String? icon;
  String? link;
  String? colour;

  Menu({this.id, this.title, this.count, this.icon, this.colour, this.link});

  Menu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    count = json['count'];
    link = json['link'];
    icon = json['icon'];
    colour = json['colour'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['count'] = this.count;
    data['icon'] = this.icon;
    data['link'] = this.link;
    data['colour'] = this.colour;
    return data;
  }
}

class Groweractivities {
  String? title;
  int? ploatid;
  String? area;
  String? type;
  List<Activity>? activity;

  Groweractivities(
      {this.title, this.ploatid, this.area, this.type, this.activity});

  Groweractivities.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    ploatid = json['ploatid'];
    area = json['area'];
    type = json['type'];
    if (json['activity'] != null) {
      activity = <Activity>[];
      json['activity'].forEach((v) {
        activity!.add(new Activity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['ploatid'] = this.ploatid;
    data['area'] = this.area;
    data['type'] = this.type;
    if (this.activity != null) {
      data['activity'] = this.activity!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Activity {
  int? activityId;
  String? activityType;
  String? activityName;
  String? activityEndMonth;
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

  Activity({
    this.activityId,
    this.activityType,
    this.activityName,
    this.activityEndMonth,
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
  });

  Activity.fromJson(Map<String, dynamic> json) {
    activityId = json['activity_id'];
    activityType = json['activity_type'];
    activityName = json['activity_name'];
    activityEndMonth = json['activity_end_month'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['activity_id'] = this.activityId;
    data['activity_type'] = this.activityType;
    data['activity_name'] = this.activityName;
    data['activity_end_month'] = this.activityEndMonth;
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

class Cfarequest {
  String? image;
  String? reqType;
  String? name;
  String? plot;
  String? date;
  String? status;

  Cfarequest(
      {this.image, this.reqType, this.name, this.plot, this.date, this.status});

  Cfarequest.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    reqType = json['req_type'];
    name = json['name'];
    plot = json['plot'];
    date = json['date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['req_type'] = this.reqType;
    data['name'] = this.name;
    data['plot'] = this.plot;
    data['date'] = this.date;
    data['status'] = this.status;
    return data;
  }
}

class Cdorequest {
  String? reqType;
  String? name;
  String? plot;
  String? date;
  String? status;
  String? image;

  Cdorequest(
      {this.reqType, this.name, this.plot, this.date, this.status, this.image});

  Cdorequest.fromJson(Map<String, dynamic> json) {
    reqType = json['req_type'];
    name = json['name'];
    plot = json['plot'];
    date = json['date'];
    status = json['status'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['req_type'] = this.reqType;
    data['name'] = this.name;
    data['plot'] = this.plot;
    data['date'] = this.date;
    data['status'] = this.status;
    data['image'] = this.image;
    return data;
  }
}
