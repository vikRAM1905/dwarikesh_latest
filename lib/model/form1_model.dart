class villageNameModel {
  bool? status;
  Data? data;

  villageNameModel({this.status, this.data});

  villageNameModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? villageCode;
  String? villageName;

  Data({this.villageCode, this.villageName});

  Data.fromJson(Map<String, dynamic> json) {
    villageCode = json['village_code'];
    villageName = json['village_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['village_code'] = this.villageCode;
    data['village_name'] = this.villageName;
    return data;
  }
}

class InterCropModel {
  bool? status;
  List<Intercrop>? intercrop;

  InterCropModel({this.status, this.intercrop});

  InterCropModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['intercrop'] != null) {
      intercrop = <Intercrop>[];
      json['intercrop'].forEach((v) {
        intercrop!.add(new Intercrop.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.intercrop != null) {
      data['intercrop'] = this.intercrop!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Intercrop {
  String? name;

  Intercrop({this.name});

  Intercrop.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class ActivityTypeListModel {
  bool? status;
  List<ActivityType>? activityType;

  ActivityTypeListModel({this.status, this.activityType});

  ActivityTypeListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['activity_type'] != null) {
      activityType = <ActivityType>[];
      json['activity_type'].forEach((v) {
        activityType!.add(new ActivityType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.activityType != null) {
      data['activity_type'] =
          this.activityType!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ActivityType {
  String? type;

  ActivityType({this.type});

  ActivityType.fromJson(Map<String, dynamic> json) {
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    return data;
  }
}

class CropTypeModel {
  bool? status;
  List<Croptype>? croptype;

  CropTypeModel({this.status, this.croptype});

  CropTypeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['croptype'] != null) {
      croptype = <Croptype>[];
      json['croptype'].forEach((v) {
        croptype!.add(new Croptype.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.croptype != null) {
      data['croptype'] = this.croptype!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Croptype {
  String? name;

  Croptype({this.name});

  Croptype.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class PlantingMethodModel {
  bool? status;
  List<PlantingMethod>? plantingMethod;

  PlantingMethodModel({this.status, this.plantingMethod});

  PlantingMethodModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['plantingMethod'] != null) {
      plantingMethod = <PlantingMethod>[];
      json['plantingMethod'].forEach((v) {
        plantingMethod!.add(new PlantingMethod.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.plantingMethod != null) {
      data['plantingMethod'] =
          this.plantingMethod!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PlantingMethod {
  String? method;

  PlantingMethod({this.method});

  PlantingMethod.fromJson(Map<String, dynamic> json) {
    method = json['method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['method'] = this.method;
    return data;
  }
}

class CheckModel {
  bool? status;
  List<Data1>? data;

  CheckModel({this.status, this.data});

  CheckModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data1>[];
      json['data'].forEach((v) {
        data!.add(new Data1.fromJson(v));
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

class Data1 {
  String? code;
  String? codeName;

  Data1({this.code, this.codeName});

  Data1.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    codeName = json['code_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['code_name'] = this.codeName;
    return data;
  }
}

class GrowerListModel {
  bool? status;
  List<GrowerData>? data;

  GrowerListModel({this.status, this.data});

  GrowerListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <GrowerData>[];
      json['data'].forEach((v) {
        data!.add(new GrowerData.fromJson(v));
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

class GrowerData {
  String? growerName;
  String? growerFatherName;

  GrowerData({this.growerName, this.growerFatherName});

  GrowerData.fromJson(Map<String, dynamic> json) {
    growerName = json['growerName'];
    growerFatherName = json['growerFatherName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['growerName'] = this.growerName;
    data['growerFatherName'] = this.growerFatherName;
    return data;
  }
}

class VarietyListModel {
  bool? status;
  List<VarietyData>? data;

  VarietyListModel({this.status, this.data});

  VarietyListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <VarietyData>[];
      json['data'].forEach((v) {
        data!.add(new VarietyData.fromJson(v));
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

class VarietyData {
  String? varietyCode;
  String? varietyName;

  VarietyData({this.varietyCode, this.varietyName});

  VarietyData.fromJson(Map<String, dynamic> json) {
    varietyCode = json['varietyCode'];
    varietyName = json['varietyName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['varietyCode'] = this.varietyCode;
    data['varietyName'] = this.varietyName;
    return data;
  }
}
