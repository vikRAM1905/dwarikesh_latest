class FinanceListModel {
  bool? status;
  String? year;
  String? income;
  String? expense;
  List<Data>? data;

  FinanceListModel(
      {this.status, this.year, this.income, this.expense, this.data});

  FinanceListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    year = json['year'];
    income = json['income'];
    expense = json['expense'];
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
    data['year'] = this.year;
    data['income'] = this.income;
    data['expense'] = this.expense;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? area;
  String? createdDate;
  String? totalExpense;
  List<Particulars>? particulars;
  bool? view = false;

  Data({this.area, this.createdDate, this.totalExpense, this.particulars});

  Data.fromJson(Map<String, dynamic> json) {
    area = json['area'];
    createdDate = json['createdDate'];
    totalExpense = json['totalExpense'];
    if (json['particulars'] != null) {
      particulars = <Particulars>[];
      json['particulars'].forEach((v) {
        particulars!.add(new Particulars.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['area'] = this.area;
    data['createdDate'] = this.createdDate;
    data['totalExpense'] = this.totalExpense;
    if (this.particulars != null) {
      data['particulars'] = this.particulars!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  bool get getViewButton {
    return view!;
  }

  set setViewButton(bool value) {
    view = value;
  }
}

class Particulars {
  int? id;
  String? categoryName;
  String? productTitle;
  String? expense;

  Particulars({this.id, this.categoryName, this.productTitle, this.expense});

  Particulars.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['categoryName'];
    productTitle = json['productTitle'];
    expense = json['expense'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categoryName'] = this.categoryName;
    data['productTitle'] = this.productTitle;
    data['expense'] = this.expense;
    return data;
  }
}
