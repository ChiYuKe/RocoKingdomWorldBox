class JsonReader {
  const JsonReader._();

  static int asInt(dynamic value, {int defaultValue = 0}) {
    if (value == null) return defaultValue;
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value.trim()) ?? defaultValue;
    return defaultValue;
  }

  static double asDouble(dynamic value, {double defaultValue = 0.0}) {
    if (value == null) return defaultValue;
    if (value is num) return value.toDouble();
    if (value is String) {
      return double.tryParse(value.trim()) ?? defaultValue;
    }
    return defaultValue;
  }

  static String asString(dynamic value, {String defaultValue = ''}) {
    if (value == null) return defaultValue;
    return value.toString();
  }

  static Map<String, dynamic> asObject(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) return Map<String, dynamic>.from(value);
    return const <String, dynamic>{};
  }

  static List<int> asIntList(dynamic value) {
    if (value is! Iterable) return const <int>[];
    return value.map(asInt).toList(growable: false);
  }

  static List<double> asDoubleList(dynamic value) {
    if (value is! Iterable) return const <double>[];
    return value.map(asDouble).toList(growable: false);
  }

  static List<Map<String, dynamic>> asObjectList(dynamic value) {
    if (value is! Iterable) return const <Map<String, dynamic>>[];
    return value.map(asObject).where((item) => item.isNotEmpty).toList();
  }
}

extension JsonObjectReader on Map<String, dynamic> {
  int intValue(String key, {int defaultValue = 0}) {
    return JsonReader.asInt(this[key], defaultValue: defaultValue);
  }

  double doubleValue(String key, {double defaultValue = 0.0}) {
    return JsonReader.asDouble(this[key], defaultValue: defaultValue);
  }

  String stringValue(String key, {String defaultValue = ''}) {
    return JsonReader.asString(this[key], defaultValue: defaultValue);
  }

  List<int> intListValue(String key) {
    return JsonReader.asIntList(this[key]);
  }

  List<double> doubleListValue(String key) {
    return JsonReader.asDoubleList(this[key]);
  }

  List<Map<String, dynamic>> objectListValue(String key) {
    return JsonReader.asObjectList(this[key]);
  }
}

class VersionedJsonRecords {
  final int version;
  final Map<String, dynamic> records;

  const VersionedJsonRecords({required this.version, required this.records});

  factory VersionedJsonRecords.fromJson(dynamic decoded, {String? source}) {
    final root = JsonReader.asObject(decoded);
    if (root.isEmpty) {
      throw FormatException('JSON 根节点必须是对象', source);
    }

    final data = JsonReader.asObject(root['data']);
    if (data.isEmpty) {
      throw FormatException('JSON 缺少 data 对象或 data 为空', source);
    }

    return VersionedJsonRecords(
      version: root.intValue('version'),
      records: data,
    );
  }
}
