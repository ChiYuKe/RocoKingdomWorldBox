import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/pet_model.dart';

class SettingsProvider with ChangeNotifier {
  static const _defaultColorIntensity = 0.9;
  static const _defaultSelectedType = PetType.cute;

  late SharedPreferences _prefs;

  // 默认值
  bool _isColorLocked = false; // 是否锁定颜色
  PetType _selectedType = _defaultSelectedType; // 默认宠物类型
  double _colorIntensity = _defaultColorIntensity; // 颜色强度，范围0.0-1.0
  bool _hdPortrait = true; // 是否使用高清头像

  // Getter
  bool get isColorLocked => _isColorLocked; // 是否锁定颜色
  PetType get selectedType => _selectedType; // 当前选择的宠物类型
  double get colorIntensity => _colorIntensity; //  颜色强度
  bool get hdPortrait => _hdPortrait; //  是否使用高清头像

  // 从本地磁盘加载数据
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _isColorLocked = _prefs.getBool('isColorLocked') ?? false;
    _colorIntensity =
        (_prefs.getDouble('colorIntensity') ?? _defaultColorIntensity).clamp(
          0.0,
          1.0,
        );
    _hdPortrait = _prefs.getBool('hdPortrait') ?? true;

    // 加载 PetType (存储其 index)
    final typeIndex =
        _prefs.getInt('selectedTypeIndex') ?? _defaultSelectedType.index;
    _selectedType = _typeFromIndex(typeIndex);

    notifyListeners();
  }

  // Setter & 持久化
  void setColorLocked(bool value) {
    _isColorLocked = value;
    _prefs.setBool('isColorLocked', value);
    notifyListeners();
  }

  void setSelectedType(PetType type) {
    _selectedType = type;
    _prefs.setInt('selectedTypeIndex', type.index);
    notifyListeners();
  }

  void setColorIntensity(double value) {
    _colorIntensity = value.clamp(0.0, 1.0);
    _prefs.setDouble('colorIntensity', _colorIntensity);
    notifyListeners();
  }

  void setHdPortrait(bool value) {
    _hdPortrait = value;
    _prefs.setBool('hdPortrait', value);
    notifyListeners();
  }

  // 清理方法
  Future<void> resetSettings() async {
    await _prefs.clear();
    await init();
  }

  PetType _typeFromIndex(int index) {
    if (index < 0 || index >= PetType.values.length) {
      return _defaultSelectedType;
    }

    return PetType.values[index];
  }
}
