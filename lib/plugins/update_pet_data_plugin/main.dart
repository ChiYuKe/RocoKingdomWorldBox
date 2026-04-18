import 'package:flutter/material.dart';
import '../../models/plugin_interface.dart';
import '../../widgets/plugin_page_template.dart'; // 引入模板
import 'widgets/update_pet_data_ui.dart';

class CalcPlugin implements RocoPlugin {


  @override
  String get id => "com.roco.plugin.calc";
  @override
  String get name => "更新精灵数据";
  @override
  String get description => "从wiki获取最新的精灵数据，并更新本地数据库，保持数据的准确性和完整性";
  @override
  String get version => "V 1.0.0";
  @override
  String get author => "ChiYuKe";

  @override
  Widget buildIcon(BuildContext context, Color accentColor) {
    return Icon(Icons.analytics_rounded, color: accentColor);
  }

  @override
  Widget buildEntryPage(BuildContext context, Color accentColor) {
    // 使用通用模板包装私有 UI
    return PluginPageTemplate(
      title: name,
      subTitle: description, 
      accentColor: accentColor,
      body: UpdatePetDataUI(
        accentColor: accentColor,
      ),
    );
  }
}