class HarverstingModel {
  bool? status;
  List<Completed>? completed;
  List<Plotdetails>? plotdetails;

  HarverstingModel({this.status, this.completed, this.plotdetails});

  HarverstingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['completed'] != null) {
      completed = <Completed>[];
      json['completed'].forEach((v) {
        completed!.add(new Completed.fromJson(v));
      });
    }
    if (json['plotdetails'] != null) {
      plotdetails = <Plotdetails>[];
      json['plotdetails'].forEach((v) {
        plotdetails!.add(new Plotdetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.completed != null) {
      data['completed'] = this.completed!.map((v) => v.toJson()).toList();
    }
    if (this.plotdetails != null) {
      data['plotdetails'] = this.plotdetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Completed {
  String? village;
  String? season;
  String? plantType;
  String? plantationStartDate;
  String? harvestingType;
  String? yieldQuantity;
  String? image;
  String? content;

  Completed(
      {this.village,
      this.season,
      this.plantType,
      this.plantationStartDate,
      this.harvestingType,
      this.yieldQuantity,
      this.image,
      this.content});

  Completed.fromJson(Map<String, dynamic> json) {
    village = json['village'];
    season = json['season'];
    plantType = json['plantType'];
    plantationStartDate = json['plantationStartDate'];
    harvestingType = json['harvestingType'];
    yieldQuantity = json['yieldQuantity'];
    image = json['image'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['village'] = this.village;
    data['season'] = this.season;
    data['plantType'] = this.plantType;
    data['plantationStartDate'] = this.plantationStartDate;
    data['harvestingType'] = this.harvestingType;
    data['yieldQuantity'] = this.yieldQuantity;
    data['image'] = this.image;
    data['content'] = this.content;
    return data;
  }
}

class Plotdetails {
  int? growerId;
  int? plotId;
  String? plotName;
  String? villagename;
  int? villageid;
  String? canearea;
  String? season;
  String? seasonshow;
  String? croptypeshow;
  String? croptype;
  int? cfaid;
  String? plantationStartDate;
  String? selectedPartialYieldQuantity;
  List<Harvestingtype>? harvestingtype;

  Plotdetails(
      {this.growerId,
      this.plotId,
      this.plotName,
      this.villagename,
      this.villageid,
      this.canearea,
      this.season,
      this.seasonshow,
      this.croptype,
      this.croptypeshow,
      this.cfaid,
      this.plantationStartDate,
      this.selectedPartialYieldQuantity,
      this.harvestingtype});

  Plotdetails.fromJson(Map<String, dynamic> json) {
    growerId = json['grower_id'];
    plotId = json['plot_id'];
    plotName = json['plot_name'];
    villagename = json['villagename'];
    villageid = json['villageid'];
    canearea = json['canearea'];
    season = json['season'];
    seasonshow = json['seasonshow'];
    croptype = json['croptype'];
    croptypeshow = json['croptypeshow'];
    cfaid = json['cfaid'];
    plantationStartDate = json['plantation_start_date'];
    selectedPartialYieldQuantity = json['partial_yield_quantity'];
    if (json['harvestingtype'] != null) {
      harvestingtype = <Harvestingtype>[];
      json['harvestingtype'].forEach((v) {
        harvestingtype!.add(new Harvestingtype.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['grower_id'] = this.growerId;
    data['plot_id'] = this.plotId;
    data['plot_name'] = this.plotName;
    data['villagename'] = this.villagename;
    data['villageid'] = this.villageid;
    data['canearea'] = this.canearea;
    data['season'] = this.season;
    data['croptype'] = this.croptype;
    data['cfaid'] = this.cfaid;
    data['plantation_start_date'] = this.plantationStartDate;
    if (this.harvestingtype != null) {
      data['harvestingtype'] =
          this.harvestingtype!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Harvestingtype {
  String? type_id;
  String? type;
  bool? ratoon;
  bool? TypeclickPos = false;

  Harvestingtype({this.type_id, this.type, this.ratoon});

  Harvestingtype.fromJson(Map<String, dynamic> json) {
    type_id = json['type_id'];
    type = json['type'];
    ratoon = json['ratoon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['ratoon'] = this.ratoon;
    return data;
  }

  bool get getCropTypePosition {
    return TypeclickPos!;
  }

  set setCropTypePosition(bool value) {
    this.TypeclickPos = value;
  }
}
