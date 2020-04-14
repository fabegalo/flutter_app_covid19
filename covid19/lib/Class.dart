class Corona {
  String name;
  String total;
  String totaldead;
  String totallive;
  String update;
  List<Area> areas;

  Corona({this.name, this.total, this.totaldead, this.totallive, this.update, this.areas});

  factory Corona.fromJson(Map<String, dynamic> json) {
    //var streetsFromJson  = json['areas'];
    //print(streetsFromJson.runtimeType);
    // List<String> streetsList = new List<String>.from(streetsFromJson);
    //List<String> streetsList = streetsFromJson.cast<String>();
    var list = json['areas'] as List;
    print(list.runtimeType);
    List<Area> areaList = list.map((i) => Area.fromJson(i)).toList();

    return Corona(
      name: json['name'] as String,
      total: json['total'] as String,
      totaldead: json['totaldead'] as String,
      totallive: json['totallive'] as String,
      update: json['update'] as String,
      areas: areaList
    );
  }
}

class Arg {
  String country;
  String update;
  List<Area> area;

  Arg({this.country, this.update, this.area});

}

class Area {
  String name;
  String total;
  String totaldead;
  String totallive;

  Area({this.name, this.total, this.totaldead, this.totallive});

  factory Area.fromJson(Map<String, dynamic> json) {
    return Area(
      name: json['name'] as String,
      total: json['total'] as String,
      totaldead: json['totaldead'] as String,
      totallive: json['totallive'] as String
    );
  }

}
