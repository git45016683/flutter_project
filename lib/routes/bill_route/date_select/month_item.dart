import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/common/toast.dart';
import 'package:flutterproject/config/application.dart';
import 'package:flutterproject/util/date_util.dart';

import 'modth_model.dart';

/*
* Date:2020/7/29
* author:lwb
* Desc:  选中月 pageview内容区域的12个文字
*/

const selectBg = Color.fromARGB(255, 82, 87, 101);

class MonthItem extends StatefulWidget {
  @override
  _MonthItemState createState() => _MonthItemState();

  final DateItemBean itemBean;
  int month;
  int year;
  var dateTime;

  MonthItem(this.itemBean) : assert(itemBean != null) {
    dateTime = new DateTime(itemBean.year, itemBean.month);
    this.month = itemBean.month;
    this.year = itemBean.year;
  }
}

class _MonthItemState extends State<MonthItem> {
  int currentMonth = DateUtil.MONTH;
  bool hasBg = false;

  @override
  void initState() {
    if (widget.month == billTopData["selectMonth"]) {
      hasBg = true;
    } else {
      hasBg = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onItemClick(),
      child: Container(
        color: Colors.white,
        child: Center(
          child: Container(
            alignment: Alignment.center,
            height: 30.0,
            width: 30.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: hasBg ? selectBg : Colors.white,
            ),
            child: Text(
              "${widget.month}",
              style: TextStyle(
                color: getItemTxColor(),
                fontSize: 12.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color getItemTxColor() {
    Color color = Colors.white;
    if (widget.month <= currentMonth) {
      if (widget.month == billTopData["selectMonth"]) {
        color = Colors.white;
      } else {
        color = Colors.black;
      }
    } else {
      color = Colors.grey;
    }
    return color;
  }

  void _onMonthSelect() {
    ToastUtil.show("${widget.month}");
    setState(() {
      billTopData["selectMonth"] = widget.month;
      if (widget.month <= currentMonth) {
        if (widget.month == billTopData["selectMonth"]) {
          hasBg = true;
        } else {
          hasBg = false;
        }
      } else {
        hasBg = false;
      }
      Application.router.pop(context);
    });
  }

  Function _onItemClick() {
    return null;
//  widget.month <= currentMonth ? _onMonthSelect : null
  }
}
