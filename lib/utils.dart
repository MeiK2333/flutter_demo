import 'package:flutter_app/data/bill.dart';

class Utils {
  static String yearMonthFmt(DateTime date) {
    return '${date.year}.${date.month.toString().padLeft(2, '0')}';
  }

  static String billsAmountSum(List<BillItem> billItems) {
    final double amount = billItems.fold(
        0, (previousValue, element) => previousValue + element.amount);
    return amount.toStringAsFixed(2);
  }
}
