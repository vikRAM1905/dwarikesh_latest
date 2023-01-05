class FertilizerMenuModel {
  bool? status;
  List<Data>? data;

  FertilizerMenuModel({this.status, this.data});

  FertilizerMenuModel.fromJson(Map<String, dynamic> json) {
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
  String? croptype;
  List<Type>? type;
  bool? TypeclickPos = false;

  Data({this.croptype, this.type});

  Data.fromJson(Map<String, dynamic> json) {
    croptype = json['croptype'];
    if (json['type'] != null) {
      type = <Type>[];
      json['type'].forEach((v) {
        type!.add(new Type.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['croptype'] = this.croptype;
    if (this.type != null) {
      data['type'] = this.type!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  bool get getCropTypePosition {
    return TypeclickPos!;
  }

  set setCropTypePosition(bool value) {
    this.TypeclickPos = value;
  }
}

class Type {
  String? combination;
  bool? DataclickPos = false;
  List<Fertilizer>? fertilizer;

  Type({this.combination, this.fertilizer});

  Type.fromJson(Map<String, dynamic> json) {
    combination = json['combination'];
    if (json['fertilizer'] != null) {
      fertilizer = <Fertilizer>[];
      json['fertilizer'].forEach((v) {
        fertilizer!.add(new Fertilizer.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['combination'] = this.combination;
    if (this.fertilizer != null) {
      data['fertilizer'] = this.fertilizer!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  bool get getDataPosition {
    return DataclickPos!;
  }

  set setDataPosition(bool value) {
    this.DataclickPos = value;
  }
}

class Fertilizer {
  String? useoffertilizer;
  bool? fertilizerclickPos = false;
  Fertilizer({this.useoffertilizer});

  Fertilizer.fromJson(Map<String, dynamic> json) {
    useoffertilizer = json['useoffertilizer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['useoffertilizer'] = this.useoffertilizer;
    return data;
  }

  bool get getFertilizerTypePosition {
    return fertilizerclickPos!;
  }

  set setFertilizerTypePosition(bool value) {
    this.fertilizerclickPos = value;
  }
}
