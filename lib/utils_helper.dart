import 'package:flutter/material.dart';

/// 工具辅助类
class UtilsHelper {
  ///value: 文本内容；
  ///style : 文字的样式；
  ///maxWidth：文本框的最大宽度；
  ///maxLines：文本支持最大多少行
  ///AUTO：华为手机如果不指定locale的时候，该方法算出来的文字高度是比系统计算偏小的。
  static double calculateTextHeight(
      {@required BuildContext context,
      @required String value,
      @required TextStyle style,
      @required double maxWidth,
      int maxLines}) {
    assert(context != null);
    assert(value != null && value.length != 0);
    assert(maxWidth != null);

    TextPainter painter = TextPainter(
        locale: Localizations.localeOf(context, nullOk: true),
        maxLines: maxLines,
        textDirection: TextDirection.ltr,
        text: TextSpan(text: value, style: style))
      ..layout(maxWidth: maxWidth);
    return painter.height;
  }
}
