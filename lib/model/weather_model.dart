class WeatherModel {
  bool? status;
  String? city;
  double? lat;
  double? long;
  String? sunrise;
  String? sunset;
  int? temperature;
  String? temptype;
  int? maxtemp;
  int? mintemp;
  int? pressure;
  int? huminity;
  String? icondata;
  String? main;
  String? description;
  String? windspeed;
  String? windunit;
  List<Data>? data;

  WeatherModel(
      {this.status,
      this.city,
      this.lat,
      this.long,
      this.sunrise,
      this.sunset,
      this.temperature,
      this.temptype,
      this.maxtemp,
      this.mintemp,
      this.pressure,
      this.huminity,
      this.icondata,
      this.main,
      this.description,
      this.windspeed,
      this.windunit,
      this.data});

  WeatherModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    city = json['city'];
    lat = json['lat'];
    long = json['long'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    temperature = json['temperature'];
    temptype = json['temptype'];
    maxtemp = json['maxtemp'];
    mintemp = json['mintemp'];
    pressure = json['pressure'];
    huminity = json['huminity'];
    icondata = json['icondata'];
    main = json['main'];
    description = json['description'];
    windspeed = json['windspeed'];
    windunit = json['windunit'];
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
    data['city'] = this.city;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['sunrise'] = this.sunrise;
    data['sunset'] = this.sunset;
    data['temperature'] = this.temperature;
    data['temptype'] = this.temptype;
    data['maxtemp'] = this.maxtemp;
    data['mintemp'] = this.mintemp;
    data['pressure'] = this.pressure;
    data['huminity'] = this.huminity;
    data['icondata'] = this.icondata;
    data['main'] = this.main;
    data['description'] = this.description;
    data['windspeed'] = this.windspeed;
    data['windunit'] = this.windunit;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static String getIconcode(String code) {
    switch (code) {
      case '01d':
        return 'assets/svg_images/clear_day.svg';
      case '01n':
        return 'assets/svg_images/clear_night.svg';
      case '02d':
        return 'assets/svg_images/few_clouds_day.svg';
      case '02n':
        return 'assets/svg_images/few_clouds_night.svg';
      case '03d':
        return 'assets/svg_images/clouds_day.svg';
      case '03n':
        return 'assets/svg_images/clouds_day.svg';
      case '04d':
        return 'assets/svg_images/clouds_day.svg';
      case '04n':
        return 'assets/svg_images/clouds_day.svg';
      case '09d':
        return 'assets/svg_images/shower_rain_day.svg';
      case '09n':
        return 'assets/svg_images/shower_rain_night.svg';
      case '10d':
        return 'assets/svg_images/rain.svg';
      case '10n':
        return 'assets/svg_images/rain.svg';
      case '11d':
        return 'assets/svg_images/thunder_storm_day.svg';
      case '11n':
        return 'assets/svg_images/thunder_storm_night.svg';
      case '13d':
        return 'assets/svg_images/snow_day.svg';
      case '13n':
        return 'assets/svg_images/snow_night.svg';
      case '50d':
        return 'assets/svg_images/mist_day.svg';
      case '50n':
        return 'assets/svg_images/mist_day.svg';
      default:
        return 'assets/svg_images/clear_day.svg';
    }
  }
}

class Data {
  String? title;
  List<Report>? report;

  Data({this.title, this.report});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['report'] != null) {
      report = <Report>[];
      json['report'].forEach((v) {
        report!.add(new Report.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.report != null) {
      data['report'] = this.report!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Report {
  String? icon;
  int? temp;
  String? tempType;
  String? zone;
  String? date;

  Report({this.icon, this.temp, this.tempType, this.zone, this.date});

  Report.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    temp = json['temp'];
    tempType = json['temp_type'];
    zone = json['zone'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = this.icon;
    data['temp'] = this.temp;
    data['temp_type'] = this.tempType;
    data['zone'] = this.zone;
    data['date'] = this.date;
    return data;
  }
}
