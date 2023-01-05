class RequestListModel {
  bool? success;
  int? total;
  List<Data>? data;

  RequestListModel({this.success, this.total, this.data});

  RequestListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
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
    data['success'] = this.success;
    data['total'] = this.total;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? plotid;
  String? village;
  String? canearea;
  String? canevariety;
  String? startdate;
  String? croptype;
  String? requesttype;
  String? subrequesttype;
  int? readstatus;
  int? overallstatus;
  String? growername;
  String? growercode;
  String? growerphone;
  String? requeststatus;
  String? query;
  List<Reqimage>? reqimage;
  String? date;
  List<Response>? response;
  String? activityStatus;
  List<Suggestion>? suggestion;

  Data(
      {this.id,
      this.plotid,
      this.canearea,
      this.village,
      this.canevariety,
      this.startdate,
      this.croptype,
      this.overallstatus,
      this.requesttype,
      this.subrequesttype,
      this.readstatus,
      this.growername,
      this.growercode,
      this.growerphone,
      this.requeststatus,
      this.query,
      this.reqimage,
      this.date,
      this.response,
      this.suggestion});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    plotid = json['plotid'];
    village = json['village'];
    canearea = json['canearea'];
    canevariety = json['canevariety'];
    startdate = json['startdate'];
    croptype = json['croptype'];
    overallstatus = json['overallstatus'];
    requesttype = json['requesttype'];
    subrequesttype = json['subrequesttype'];
    readstatus = json['readstatus'];
    growername = json['growername'];
    growercode = json['growercode'];
    growerphone = json['growerphone'];
    requeststatus = json['requeststatus'];
    query = json['query'];
    if (json['reqimage'] != null) {
      reqimage = <Reqimage>[];
      json['reqimage'].forEach((v) {
        reqimage!.add(new Reqimage.fromJson(v));
      });
    }
    date = json['date'];
    if (json['response'] != null) {
      response = <Response>[];
      json['response'].forEach((v) {
        response!.add(new Response.fromJson(v));
      });
    }
    if (json['suggestion'] != null) {
      suggestion = <Suggestion>[];
      json['suggestion'].forEach((v) {
        suggestion!.add(new Suggestion.fromJson(v));
      });
    }
    // } if (json['suggestion'] != null) {
    //   suggestion = new List<Suggestion>();
    //   json['suggestion'].forEach((v) {
    //     suggestion.add(new Suggestion.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['plotid'] = this.plotid;
    data['village'] = this.village;
    data['canearea'] = this.canearea;
    data['canevariety'] = this.canevariety;
    data['startdate'] = this.startdate;
    data['croptype'] = this.croptype;
    data['requesttype'] = this.requesttype;
    data['readstatus'] = this.readstatus;
    data['growername'] = this.growername;
    data['growercode'] = this.growercode;
    data['growerphone'] = this.growerphone;
    data['requeststatus'] = this.requeststatus;
    data['query'] = this.query;
    if (this.reqimage != null) {
      data['reqimage'] = this.reqimage!.map((v) => v.toJson()).toList();
    }
    data['date'] = this.date;
    if (this.response != null) {
      data['response'] = this.response!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  // Using the getter
  // method to take input
  String get get_status {
    return activityStatus!;
  }

  // Using the setter method
  // to set the input
  set set_status(String value) {
    this.activityStatus = value;
  }
}

class Reqimage {
  String? image;

  Reqimage({this.image});

  Reqimage.fromJson(Map<String, dynamic> json) {
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    return data;
  }
}

class Resimage {
  String? image;

  Resimage({this.image});

  Resimage.fromJson(Map<String, dynamic> json) {
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    return data;
  }
}

class Response {
  int? resid;
  String? resmsg;
  String? resname;
  String? code;
  String? resphone;
  List<Resimage>? resimage;
  String? role;
  bool? thumbs;
  bool? thumbsBtnunsatisfied;
  bool? escalate;
  int? tagstatus;
  String? date;

  Response(
      {this.resid,
      this.resmsg,
      this.resname,
      this.code,
      this.resphone,
      this.resimage,
      this.role,
      this.thumbs,
      this.thumbsBtnunsatisfied,
      this.escalate,
      this.tagstatus,
      this.date});

  Response.fromJson(Map<String, dynamic> json) {
    resid = json['resid'];
    resmsg = json['resmsg'];
    resname = json['resname'];
    code = json['code'];
    resphone = json['resphone'];
    if (json['resimage'] != null) {
      resimage = <Resimage>[];
      json['resimage'].forEach((v) {
        resimage!.add(new Resimage.fromJson(v));
      });
    }
    role = json['role'];
    thumbs = json['thumbs'];
    thumbsBtnunsatisfied = json['thumbsBtnunsatisfied'];
    tagstatus = json['tagstatus'];
    escalate = json['escalate'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resid'] = this.resid;
    data['resmsg'] = this.resmsg;
    data['resname'] = this.resname;
    data['code'] = this.code;
    data['resphone'] = this.resphone;
    if (this.resimage != null) {
      data['resimage'] = this.resimage!.map((v) => v.toJson()).toList();
    }
    data['role'] = this.role;
    data['thumbs'] = this.thumbs;
    data['escalate'] = this.escalate;
    data['date'] = this.date;
    return data;
  }
}

class Suggestion {
  String? bcm_answer;

  Suggestion({this.bcm_answer});

  Suggestion.fromJson(Map<String, dynamic> json) {
    bcm_answer = json['bcm_answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bcm_answer'] = this.bcm_answer;
    return data;
  }
}
