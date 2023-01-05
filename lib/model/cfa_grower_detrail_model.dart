class CfaReportGrowerDetailModel {
  bool? status;
  String? name;
  String? phonenumber;
  String? fname;
  String? points;
  String? aadhar;
  String? bankAccount;
  List<Menu>? menu;
  List<Plotdata>? plotdata;

  CfaReportGrowerDetailModel(
      {this.status,
      this.name,
      this.phonenumber,
      this.fname,
      this.points,
      this.menu,
      this.aadhar,
      this.bankAccount,
      this.plotdata});

  CfaReportGrowerDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    name = json['name'];
    phonenumber = json['phonenumber'];
    fname = json['fname'];
    points = json['points'];
    aadhar = json['aadhar_number'];
    bankAccount = json['account_number'];
    if (json['menu'] != null) {
      menu = <Menu>[];
      json['menu'].forEach((v) {
        menu!.add(new Menu.fromJson(v));
      });
    }
    if (json['plotdata'] != null) {
      plotdata = <Plotdata>[];
      json['plotdata'].forEach((v) {
        plotdata!.add(new Plotdata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['name'] = this.name;
    data['phonenumber'] = this.phonenumber;
    data['fname'] = this.fname;
    data['points'] = this.points;
    if (this.menu != null) {
      data['menu'] = this.menu!.map((v) => v.toJson()).toList();
    }
    if (this.plotdata != null) {
      data['plotdata'] = this.plotdata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Menu {
  String? title;
  String? icon;
  String? type;
  int? count;

  Menu({this.title, this.icon, this.count, this.type});

  Menu.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    icon = json['icon'];
    count = json['count'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['icon'] = this.icon;
    data['count'] = this.count;
    data['type'] = this.type;
    return data;
  }
}

class Plotdata {
  int? plotid;
  String? croptype;
  String? plationdate;
  String? canearea;
  String? canevarity;
  String? cfaname;
  String? cfphone;

  Plotdata(
      {this.plotid,
      this.croptype,
      this.plationdate,
      this.canearea,
      this.canevarity,
      this.cfaname,
      this.cfphone});

  Plotdata.fromJson(Map<String, dynamic> json) {
    plotid = json['plotid'];
    croptype = json['croptype'];
    plationdate = json['plationdate'];
    canearea = json['canearea'];
    canevarity = json['canevarity'];
    cfaname = json['cfaname'];
    cfphone = json['cfphone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['plotid'] = this.plotid;
    data['croptype'] = this.croptype;
    data['plationdate'] = this.plationdate;
    data['canearea'] = this.canearea;
    data['canevarity'] = this.canevarity;
    data['cfaname'] = this.cfaname;
    data['cfphone'] = this.cfphone;
    return data;
  }
}
