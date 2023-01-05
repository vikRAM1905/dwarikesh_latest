class AnnouncementsModel {
  bool? status;
  int? total;
  List<Data>? data;

  AnnouncementsModel({this.status, this.total, this.data});

  AnnouncementsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    total = json['total'];
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
    data['total'] = this.total;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? icon;
  String? villagename;
  String? title;
  String? description;
  String? image;
  String? subtitle;
  String? videoUrl;
  String? pdf;
  String? date;

  Data(
      {this.id,
      this.icon,
      this.villagename,
      this.title,
      this.description,
      this.image,
      this.videoUrl,
      this.pdf,
      this.date,
      this.subtitle});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    icon = json['icon'];
    villagename = json['villagename'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    videoUrl = json['video_url'];
    date = json['date'];
    pdf = json['pdf'];
    subtitle = json['subtype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['villagename'] = this.villagename;
    data['title'] = this.title;
    data['description'] = this.description;
    data['image'] = this.image;
    data['video_url'] = this.videoUrl;
    data['pdf'] = this.pdf;
    data['date'] = this.date;
    data['subtype'] = this.subtitle;
    return data;
  }
}
