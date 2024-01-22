class CityModel{

  late String state_id;
  late String city_id;
  late String city;

  CityModel(this.state_id, this.city_id, this.city);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['city'] = city;
    map['city_id']=city_id;
    map['state_id'] = state_id;

    return map;
  }
  CityModel.fromJson(dynamic json) {
    city = json['city'];
    city_id= json['city_id'];
    state_id = json['state_id'];

  }
}