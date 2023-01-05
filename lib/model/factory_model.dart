import 'package:flutter/src/material/dropdown.dart';
import 'package:get/get.dart';

class FactoryListModel {
  bool? status;
  List<Data>? data;

  FactoryListModel({this.status, this.data});

  FactoryListModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? name;
  String? code;

  Data({this.id, this.name, this.code});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    return data;
  }
}

class Factory {
  String? factoryName;
  String? factoryCode;

  Factory(
    this.factoryName,
    this.factoryCode,
  );

  Factory.fromJson(Map<String, dynamic> json) {
    factoryName = json['factoryName'];
    factoryCode = json['factoryCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['factoryName'] = this.factoryName;
    data['factoryCode'] = this.factoryCode;
    return data;
  }

  static List<Factory> factoryList() {
    return <Factory>[
      Factory("balrampur_chini_mill".tr, "BCM"),
      Factory("babhnan_chini_mill".tr, "BBN"),
      Factory("tulsipur_chini_mill".tr, "TLP"),
      Factory("haidergarh_chini_mill".tr, "HCM"),
      Factory("akbarpur_chini_mill".tr, "ACM"),
      Factory("mankapur_chini_mill".tr, "MCM"),
      Factory("rauzagaon_chini_mill".tr, "RCM"),
      Factory("kumbhi_chini_mill".tr, "KCM"),
      Factory("gularia_chini_mill".tr, "GCM"),
      Factory("maizapur_chini_mill".tr, "MZP"),
    ];
  }
}
