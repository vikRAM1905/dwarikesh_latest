class FertiliserCalculatorModel {
  bool? status;
  List<Data>? data;

  FertiliserCalculatorModel({this.status, this.data});

  FertiliserCalculatorModel.fromJson(Map<String, dynamic> json) {
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
  String? sourceOfNutrients;
  String? quantityOfFertilizerPerAcre;
  String? unit;

  Data({this.sourceOfNutrients, this.quantityOfFertilizerPerAcre, this.unit});

  Data.fromJson(Map<String, dynamic> json) {
    sourceOfNutrients = json['source_of_nutrients'];
    quantityOfFertilizerPerAcre = json['Quantity of fertilizer per acre'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['source_of_nutrients'] = this.sourceOfNutrients;
    data['Quantity of fertilizer per acre'] = this.quantityOfFertilizerPerAcre;
    data['unit'] = this.unit;
    return data;
  }
}
