class ValueStringModel {
  bool? status;
  List<Data>? data;

  ValueStringModel({this.status, this.data});

  ValueStringModel.fromJson(Map<String, dynamic> json) {
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
  String? code;
  String? string;

  Data({this.code, this.string});

  Data.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    string = json['string'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['string'] = this.string;
    return data;
  }
}

class UnitMeasuresModel {
  bool? status;
  List<Units>? units;

  UnitMeasuresModel({this.status, this.units});

  UnitMeasuresModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['units'] != null) {
      units = <Units>[];
      json['units'].forEach((v) {
        units!.add(new Units.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.units != null) {
      data['units'] = this.units!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Units {
  String? name;

  Units({this.name});

  Units.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class ActivityCodeListModel {
  bool? status;
  List<CodeData>? data;

  ActivityCodeListModel({this.status, this.data});

  ActivityCodeListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <CodeData>[];
      json['data'].forEach((v) {
        data!.add(new CodeData.fromJson(v));
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

class CodeData {
  String? code;
  String? codeName;

  CodeData({this.code, this.codeName});

  CodeData.fromJson(Map<String, dynamic> json) {
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
