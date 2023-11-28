import 'dart:convert';

class BaapModel {
    String? name;
    String? qualification;
    String? id;

    BaapModel({
         this.name,
         this.qualification,
         this.id,
    });

    factory BaapModel.fromRawJson(String str) => BaapModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory BaapModel.fromJson(Map<String, dynamic> json) => BaapModel(
        name: json["Name"] ,
        qualification: json["Qualification"] ,
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "Name": name,
        "Qualification": qualification,
        "id": id,
    };
}