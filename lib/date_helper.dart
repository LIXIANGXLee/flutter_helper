import 'package:flutter/material.dart';

enum DateType {
  ///'yyyy-MM-dd HH:mm:ss';
  ymd_hms_1,

  ///'yyyyy年MM月dd日 HH:mm:ss';
  ymd_hms_2,

  ///'yyyyy/MM/dd HH:mm:ss';
  ymd_hms_3,

  /// 'MM-dd HH:mm:ss';
  md_hms_1,

  /// 'MM月dd日 HH:mm:ss';
  md_hms_2,

  /// 'MM-dd HH:mm';
  md_hm_1,

  /// 'MM月dd日 HH:mm';
  md_hm_2,

  /// 'MM-dd';
  md1,

  /// 'MM月dd日';
  md2,

  /// 'HH:mm:ss';
  hms,

  /// 'HH:mm';
  hm,

  /// 'mm:ss';
  ms,
}

class DateHelper {
  /// 时间戳转化为日期 time 豪秒
  static DateTime transformDate(int timeStamp) {
    assert(timeStamp != null);

    return DateTime.fromMillisecondsSinceEpoch(timeStamp);
  }

  /// 日期转化为时间戳 毫秒
  static int transformTimeStamp(DateTime date) {
    assert(date != null);

    return date.microsecondsSinceEpoch;
  }

  ///计算月份的天数
  static int calculateDays({int year, int month}) {
    if (year == null || year == 0) {
      year = DateTime.now().year;
    }

    if (month == null || month == 0) {
      month = DateTime.now().month;
    }

    if ([1, 3, 5, 7, 8, 10, 12].contains(month)) {
      return 31;
    } else if (month == 2) {
      if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
        return 29;
      }
      return 28;
    }
    return 30;
  }

  ///日期转成字符串显示
  static String transformDateString(DateTime date,
      {DateType type = DateType.ymd_hms_1}) {
    if (date == null) {
      date = DateTime.now();
    }
    if (type == DateType.ymd_hms_1) {
      return '${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}:${date.second}';
    } else if (type == DateType.ymd_hms_2) {
      return '${date.year}年${date.month}月${date.day}日 ${date.hour}:${date.minute}:${date.second}';
    } else if (type == DateType.ymd_hms_3) {
      return '${date.year}/${date.month}/${date.day} ${date.hour}:${date.minute}:${date.second}';
    } else if (type == DateType.md_hms_1) {
      return '${date.month}-${date.day} ${date.hour}:${date.minute}:${date.second}';
    } else if (type == DateType.md_hms_2) {
      return '${date.month}月${date.day}日 ${date.hour}:${date.minute}:${date.second}';
    } else if (type == DateType.md_hm_1) {
      return '${date.month}-${date.day} ${date.hour}:${date.minute}';
    } else if (type == DateType.md_hm_2) {
      return '${date.month}月${date.day}日 ${date.hour}:${date.minute}';
    } else if (type == DateType.md1) {
      return '${date.month}-${date.day}';
    } else if (type == DateType.md2) {
      return '${date.month}月${date.day}日';
    } else if (type == DateType.hms) {
      return '${date.hour}:${date.minute}:${date.second}';
    } else if (type == DateType.hm) {
      return '${date.hour}:${date.minute}';
    } else if (type == DateType.ms) {
      return '${date.minute}:${date.second}';
    }
  }

  /// 日期转个性化字符串
  String transformCustomDateString(DateTime date) {
    assert(date != null);

    int minute = 60;
    int hour = minute * 60;
    int day = hour * 24;
    int week = day * 7;
    int month = day * 30;

    var nowTime = DateTime.now().millisecondsSinceEpoch / 1000; //到秒
    var createTime = date.millisecondsSinceEpoch / 1000; //到秒
    var leftTime = nowTime - createTime;

    String duration;
    if (leftTime / month > 6) {
      duration = transformDateString(date, type: DateType.ymd_hms_1);
    } else if (leftTime / month >= 1) {
      duration = (leftTime / month).floor().toString() + '月前';
    } else if (leftTime / week >= 1) {
      duration = (leftTime / week).floor().toString() + '周前';
    } else if (leftTime / day >= 1) {
      duration = (leftTime / day).floor().toString() + '天前';
    } else if (leftTime / hour >= 1) {
      duration = (leftTime / hour).floor().toString() + '小时前';
    } else if (leftTime / minute >= 1) {
      duration = (leftTime / minute).floor().toString() + '分钟前';
    } else {
      duration = '刚刚';
    }
    return duration;
  }
}
