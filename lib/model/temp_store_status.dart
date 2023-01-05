class sendJsonData {
  String? id;
  String? status;

  sendJsonData({this.id, this.status});

  sendJsonData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['"id"'] = this.id;
    data['"status"'] = this.status;
    return data;
  }
}
