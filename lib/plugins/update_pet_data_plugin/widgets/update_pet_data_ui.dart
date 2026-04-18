import 'package:flutter/material.dart';

class UpdatePetDataUI extends StatefulWidget {
  final Color accentColor;


  const UpdatePetDataUI({super.key, required this.accentColor, });

  @override
  State<UpdatePetDataUI> createState() => _UpdatePetDataUIState();
}

class _UpdatePetDataUIState extends State<UpdatePetDataUI> {
    @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "这是一个更新精灵数据的插件界面，后续会添加从网络获取数据并更新本地数据库的功能",
        style: TextStyle(fontSize: 18, color: widget.accentColor),
        textAlign: TextAlign.center,
      ),
    );
  }





}