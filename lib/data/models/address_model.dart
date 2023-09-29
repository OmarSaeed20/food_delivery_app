class AddressModel {
  int? id;
  String? addressType;
  String? contactPersonName;
  String? contactPersonNumber;
  String? address;
  String? latitude;
  String? longitude;

  AddressModel({
    this.id,
    this.addressType,
    this.contactPersonName,
    this.contactPersonNumber,
    this.address,
    this.latitude,
    this.longitude,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'],
      addressType: json['address_type'],
      contactPersonName: json['contact_person_name'],
      contactPersonNumber: json['contact_person_number'],
      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'address_type': addressType,
      'contact_person_name': contactPersonName,
      'contact_person_number': contactPersonNumber,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
