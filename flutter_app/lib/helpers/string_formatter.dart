import 'package:intl/intl.dart';

String priceBr(double price) {
  final formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');
  final priceFormatted = formatter.format(price);
  return priceFormatted;
}
