import 'package:projects/models/source_entity.dart';

sourceEntityFromJson(SourceEntity data, Map<String, dynamic> json) {
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['country'] != null) {
		data.country = json['country'].toString();
	}
	if (json['latitude'] != null) {
		data.latitude = json['latitude'] is String
				? double.tryParse(json['latitude'])
				: json['latitude'].toDouble();
	}
	if (json['lat'] != null) {
		data.latitude = json['lat'] is String
				? double.tryParse(json['lat'])
				: json['lat'].toDouble();
	}
	if (json['longitude'] != null) {
		data.longitude = json['longitude'] is String
				? double.tryParse(json['longitude'])
				: json['longitude'].toDouble();
	}
	if (json['lng'] != null) {
		data.longitude = json['lng'] is String
				? double.tryParse(json['lng'])
				: json['lng'].toDouble();
	}
	return data;
}

Map<String, dynamic> sourceEntityToJson(SourceEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['country'] = entity.name;
	data['name'] = entity.name;
	data['latitude'] = entity.latitude;
	data['longitude'] = entity.longitude;
	return data;
}