import 'package:flutter/material.dart';

class HelperIcons {
  static Map<String, IconData> materialIcons = {
    '三餐': Icons.restaurant,
    '零食': Icons.icecream,
    '衣服': Icons.checkroom,
    '交通': Icons.directions_bus,
    '旅行': Icons.flight,
    '孩子': Icons.child_friendly,
    '宠物': Icons.pets,
    '通讯费用': Icons.stay_current_portrait,
    '烟酒': Icons.smoking_rooms,
    '学习': Icons.auto_stories,
    '日用品': Icons.umbrella,
    '住房': Icons.house,
    '美妆': Icons.sanitizer,
    '医疗': Icons.medical_services,
    '红包': Icons.attach_money,
    '汽车': Icons.directions_car,
    '娱乐': Icons.celebration,
    '请客送礼': Icons.card_giftcard,
    '电器数码': Icons.photo_camera,
    '运动': Icons.directions_run,
    '水电': Icons.ev_station,
    '其他': Icons.help,
  };

  static IconData getIconData(String iconName) {
    iconName = iconName is String ? iconName.toLowerCase().trim() : null;

    if (iconName == null || iconName.isEmpty) {
      return null;
    }
    if (materialIcons.containsKey(iconName)) {
      return materialIcons[iconName];
    }

    return null;
  }

  static bool isExistIcon(String iconName) {
    iconName = iconName is String ? iconName.toLowerCase().trim() : null;

    if (iconName == null || iconName.isEmpty) {
      return false;
    }

    if (materialIcons.containsKey(iconName)) {
      return true;
    }

    return false;
  }
}
