class InfoCenterModel {
  bool? status;
  List<Data>? data;

  InfoCenterModel({this.status, this.data});

  InfoCenterModel.fromJson(Map<String, dynamic> json) {
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
  String? language;
  String? langtype;
  String? topicNumber;
  String? topic;
  List<Subtopic>? subtopic;

  Data({this.language, this.topicNumber, this.topic, this.subtopic});

  Data.fromJson(Map<String, dynamic> json) {
    language = json['language'];
    langtype = json['langtype'];
    topicNumber = json['topic_number'];
    topic = json['topic'];
    if (json['subtopic'] != null) {
      subtopic = <Subtopic>[];
      json['subtopic'].forEach((v) {
        subtopic!.add(new Subtopic.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['language'] = this.language;
    data['langtype'] = this.langtype;
    data['topic_number'] = this.topicNumber;
    data['topic'] = this.topic;
    if (this.subtopic != null) {
      data['subtopic'] = this.subtopic!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subtopic {
  String? questionNum;
  String? question;
  String? answer;
  String? color;
  List<Picture>? picture;

  Subtopic({this.questionNum, this.question, this.answer, this.picture});

  Subtopic.fromJson(Map<String, dynamic> json) {
    questionNum = json['question_num'];
    question = json['question'];
    answer = json['answer'];
    color = json['color'];
    if (json['picture'] != null) {
      picture = <Picture>[];
      json['picture'].forEach((v) {
        picture!.add(new Picture.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question_num'] = this.questionNum;
    data['question'] = this.question;
    data['color'] = this.color;
    data['answer'] = this.answer;
    if (this.picture != null) {
      data['picture'] = this.picture!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Picture {
  String? image;
  String? title;

  Picture({this.image, this.title});

  Picture.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['title'] = this.title;
    return data;
  }
}
