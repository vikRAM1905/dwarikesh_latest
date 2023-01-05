class NewExpanseModel {
  bool? status;
  String? caneArea;
  String? culturableArea;
  String? title;
  String? unit;
  List<Data>? data;

  NewExpanseModel(
      {this.status,
      this.caneArea,
      this.culturableArea,
      this.unit,
      this.data,
      this.title});

  NewExpanseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    caneArea = json['caneArea'];
    culturableArea = json['culturableArea'];
    unit = json['unit'];
    title = json['title'];
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
    data['caneArea'] = this.caneArea;
    data['culturableArea'] = this.culturableArea;
    data['unit'] = this.unit;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? category;
  String? type;
  List<Particulars>? particulars;

  Data({this.category, this.type, this.particulars});

  Data.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    type = json['type'];
    if (json['particulars'] != null) {
      particulars = <Particulars>[];
      json['particulars'].forEach((v) {
        particulars!.add(new Particulars.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['type'] = this.type;
    if (this.particulars != null) {
      data['particulars'] = this.particulars!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Particulars {
  int? id;
  String? categoryName;
  String? productTitle;
  String? productUnit;
  String? ratePerUnit;
  String? rateCalculate;
  String? subTitle;
  String? alert;
  String? rangePerHecMin;
  String? rangePerHecMax;
  bool? radioButton = false;
  bool? checkbox = false;

  Particulars(
      {this.id,
      this.categoryName,
      this.productTitle,
      this.productUnit,
      this.ratePerUnit,
      this.rateCalculate,
      this.subTitle,
      this.alert,
      this.rangePerHecMin,
      this.rangePerHecMax,
      this.radioButton,
      this.checkbox});

  Particulars.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['categoryName'];
    productTitle = json['productTitle'];
    productUnit = json['productUnit'];
    ratePerUnit = json['ratePerUnit'];
    rateCalculate = json['rateCalculate'];
    subTitle = json['subTitle'];
    alert = json['alert'];
    rangePerHecMin = json['rangePerHecMin'];
    rangePerHecMax = json['rangePerHecMax'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categoryName'] = this.categoryName;
    data['productTitle'] = this.productTitle;
    data['productUnit'] = this.productUnit;
    data['ratePerUnit'] = this.ratePerUnit;
    data['rateCalculate'] = this.rateCalculate;
    data['subTitle'] = this.subTitle;
    data['alert'] = this.alert;
    data['rangePerHecMin'] = this.rangePerHecMin;
    data['rangePerHecMax'] = this.rangePerHecMax;
    return data;
  }

  bool get getRadioButton {
    return radioButton!;
  }

  set setRadioButton(bool value) {
    radioButton = value;
  }

  bool get getCheckboxButton {
    return checkbox!;
  }

  set setCheckboxButton(bool value) {
    checkbox = value;
  }
}
