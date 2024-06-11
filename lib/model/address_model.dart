class AddressModel {
  String? id;
  String? fullname;
  String? pincode;
  String? city;
  String? state;
  String? phone;
  String? house;
  String? area;

  AddressModel(
      {this.id,
      this.fullname,
      this.pincode,
      this.city,
      this.state,
      this.phone,
      this.house,
      this.area});

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    pincode = json['pincode'];
    city = json['city'];
    state = json['state'];
    phone = json['phone'];
    house = json['house'];
    area = json['area'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fullname'] = fullname;
    data['pincode'] = pincode;
    data['city'] = city;
    data['state'] = state;
    data['phone'] = phone;
    data['house'] = house;
    data['area'] = area;
    return data;
  }
}
