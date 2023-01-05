class TransactionListModel {
  bool? status;
  List<Data>? data;

  TransactionListModel({this.status, this.data});

  TransactionListModel.fromJson(Map<String, dynamic> json) {
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
  int? tabType;
  String? tabName;
  List<Values>? values;

  Data({this.tabType, this.tabName, this.values});

  Data.fromJson(Map<String, dynamic> json) {
    tabType = json['tab_type'];
    tabName = json['tab_name'];
    if (json['values'] != null) {
      values = <Values>[];
      json['values'].forEach((v) {
        values!.add(new Values.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tab_type'] = this.tabType;
    data['tab_name'] = this.tabName;
    if (this.values != null) {
      data['values'] = this.values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Values {
  String? centreCode;
  String? centerName;
  String? villageCode;
  String? growerCode;
  String? deliveryDate;
  String? ftnCol;
  String? purchyNumber;
  String? status;
  String? type;
  String? supplyDate;
  String? mPurchiNo;
  String? indentNo;
  String? cropType;
  String? varietyName;
  String? netWeight;
  String? amount;
  String? plotVillageCode;
  String? growerVillageCode;
  String? dIM1;
  String? dIM2;
  String? dIM3;
  String? dIM4;
  String? sharepercentage;
  String? plotserial;
  String? areaHa;
  String? millPurchyNumber;
  String? paymentdate;
  String? dueAmount;
  String? loanDeduction;
  String? paidAmount;

  Values(
      {this.centreCode,
      this.centerName,
      this.villageCode,
      this.growerCode,
      this.deliveryDate,
      this.ftnCol,
      this.purchyNumber,
      this.status,
      this.type,
      this.supplyDate,
      this.mPurchiNo,
      this.indentNo,
      this.cropType,
      this.varietyName,
      this.netWeight,
      this.amount,
      this.plotVillageCode,
      this.growerVillageCode,
      this.dIM1,
      this.dIM2,
      this.dIM3,
      this.dIM4,
      this.sharepercentage,
      this.plotserial,
      this.areaHa,
      this.millPurchyNumber,
      this.paymentdate,
      this.dueAmount,
      this.loanDeduction,
      this.paidAmount});

  Values.fromJson(Map<String, dynamic> json) {
    centreCode = json['centreCode'];
    centerName = json['centerName'];
    villageCode = json['villageCode'];
    growerCode = json['growerCode'];
    deliveryDate = json['deliveryDate'];
    ftnCol = json['ftnCol'];
    purchyNumber = json['purchyNumber'];
    status = json['status'];
    type = json['type'];
    supplyDate = json['supplyDate'];
    mPurchiNo = json['mPurchiNo'];
    indentNo = json['indentNo'];
    cropType = json['cropType'];
    varietyName = json['varietyName'];
    netWeight = json['netWeight'];
    amount = json['amount'];
    plotVillageCode = json['plotVillageCode'];
    growerVillageCode = json['growerVillageCode'];
    dIM1 = json['DIM1'];
    dIM2 = json['DIM2'];
    dIM3 = json['DIM3'];
    dIM4 = json['DIM4'];
    sharepercentage = json['Sharepercentage'];
    plotserial = json['plotserial'];
    areaHa = json['AreaHa'];
    millPurchyNumber = json['millPurchyNumber'];
    paymentdate = json['paymentdate'];
    dueAmount = json['dueAmount'];
    loanDeduction = json['loanDeduction'];
    paidAmount = json['paidAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['centreCode'] = this.centreCode;
    data['centerName'] = this.centerName;
    data['villageCode'] = this.villageCode;
    data['growerCode'] = this.growerCode;
    data['deliveryDate'] = this.deliveryDate;
    data['ftnCol'] = this.ftnCol;
    data['purchyNumber'] = this.purchyNumber;
    data['status'] = this.status;
    data['type'] = this.type;
    data['supplyDate'] = this.supplyDate;
    data['mPurchiNo'] = this.mPurchiNo;
    data['indentNo'] = this.indentNo;
    data['cropType'] = this.cropType;
    data['varietyName'] = this.varietyName;
    data['netWeight'] = this.netWeight;
    data['amount'] = this.amount;
    data['plotVillageCode'] = this.plotVillageCode;
    data['growerVillageCode'] = this.growerVillageCode;
    data['DIM1'] = this.dIM1;
    data['DIM2'] = this.dIM2;
    data['DIM3'] = this.dIM3;
    data['DIM4'] = this.dIM4;
    data['Sharepercentage'] = this.sharepercentage;
    data['plotserial'] = this.plotserial;
    data['AreaHa'] = this.areaHa;
    data['millPurchyNumber'] = this.millPurchyNumber;
    data['paymentdate'] = this.paymentdate;
    data['dueAmount'] = this.dueAmount;
    data['loanDeduction'] = this.loanDeduction;
    data['paidAmount'] = this.paidAmount;
    return data;
  }
}
