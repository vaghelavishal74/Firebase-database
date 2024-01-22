
class StatetModel{
  late String? id;
  late String state;

  StatetModel(this.id, this.state
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['state_id'] = id;
    map['state'] = state;

    return map;
  }

  StatetModel.fromJson(dynamic json) {
    id = json['state_id'];
    state = json['state'];

  }

/*  Map<String,dynamic> toMap(){
    var map=<String,dynamic>{
      'id':id,
      'state':name
    };
    return map;
  }
  CityModel.fromMap( Map<String, dynamic> map){

    id=map['Id'];
    name=map['Name'];
  }*/


}