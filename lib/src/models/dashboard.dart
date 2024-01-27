class Dashboard {
  final double sales;
  final double purchases;
  final double expenses;
  final int stock;
  final double total;

  Dashboard({
    required this.sales,
    required this.purchases,
    required this.expenses,
    required this.stock,
  }) : total = expenses + purchases + sales;

  @override
  String toString() {
    return "{'sales':$sales, 'purchases':$purchases, 'expenses':$expenses, 'stock':$stock, 'total':$total}";
  }
}

final data = Dashboard(
  sales: 560,
  purchases: 400,
  expenses: 128,
  stock: 234,
);
