class AgriImplementsModel {
  bool? status;
  List<Data>? data;

  AgriImplementsModel({this.status, this.data});

  AgriImplementsModel.fromJson(Map<String, dynamic> json) {
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
  String? productName;
  String? productImage;
  List<Vendordata>? vendordata;

  Data({this.productName, this.productImage, this.vendordata});

  Data.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    productImage = json['product_image'];
    if (json['vendordata'] != null) {
      vendordata = <Vendordata>[];
      json['vendordata'].forEach((v) {
        vendordata!.add(new Vendordata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_name'] = this.productName;
    data['product_image'] = this.productImage;
    if (this.vendordata != null) {
      data['vendordata'] = this.vendordata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Vendordata {
  String? vendorName;
  String? vendorPhoneNumber;
  String? productServiceCost;
  String? vendorAddress;

  Vendordata(
      {this.vendorName,
      this.vendorPhoneNumber,
      this.productServiceCost,
      this.vendorAddress});

  Vendordata.fromJson(Map<String, dynamic> json) {
    vendorName = json['vendor_name'];
    vendorPhoneNumber = json['vendor_phone_number'];
    productServiceCost = json['product_service_cost'];
    vendorAddress = json['vendor_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendor_name'] = this.vendorName;
    data['vendor_phone_number'] = this.vendorPhoneNumber;
    data['product_service_cost'] = this.productServiceCost;
    data['vendor_address'] = this.vendorAddress;
    return data;
  }
}
