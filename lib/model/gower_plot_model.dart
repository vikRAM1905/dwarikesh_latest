class UserPlotList {
  bool? status;
  List<Data>? data;

  UserPlotList({this.status, this.data});

  UserPlotList.fromJson(Map<String, dynamic> json) {
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
  int? plotId;
  String? plotName;

  Data({this.plotId, this.plotName});

  Data.fromJson(Map<String, dynamic> json) {
    plotId = json['plot_id'];
    plotName = json['plot_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['plot_id'] = this.plotId;
    data['plot_name'] = this.plotName;
    return data;
  }
}
