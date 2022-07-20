class Pengajuan {
  int? id;
  int? userId;
  int? plafon;
  int? tenor;
  String? timeCreate;
  String? timeUpdate;

  Pengajuan(
      {this.id,
        this.userId,
        this.plafon,
        this.tenor,
        this.timeCreate,
        this.timeUpdate});

  Pengajuan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    plafon = json['plafon'];
    tenor = json['tenor'];
    timeCreate = json['time_create'];
    timeUpdate = json['time_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['plafon'] = this.plafon;
    data['tenor'] = this.tenor;
    data['time_create'] = this.timeCreate;
    data['time_update'] = this.timeUpdate;
    return data;
  }
}