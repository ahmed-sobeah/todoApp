
import 'package:intl/intl.dart';

extension DateEx on DateTime{
  String get toFormattedDate =>'$day/$month/$year';
  String getDayName(DateTime date){
    DateFormat formatter = DateFormat('E');
    return formatter.format(this);
  }
}