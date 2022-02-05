import 'package:projects/generated/json/base/json_convert_content.dart';

class SourceEntity with JsonConvert<SourceEntity> {
	String? name;
	String? country;
	double? latitude;
	double? longitude;
}
