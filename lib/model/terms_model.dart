class TermsModel {
  bool? status;
  String? termscondition;
  String? aboutus;

  TermsModel({this.status, this.termscondition, this.aboutus});

  TermsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    termscondition = json['termscondition'];
    aboutus = json['aboutus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['termscondition'] = this.termscondition;
    data['aboutus'] = this.aboutus;
    return data;
  }
}
