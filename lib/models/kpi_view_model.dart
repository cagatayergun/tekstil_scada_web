class KpiViewModel {
  final String title;
  final String value;
  final String unit;

  KpiViewModel({required this.title, required this.value, required this.unit});

  // JSON'dan KpiViewModel oluşturmak için fabrika metodu
  factory KpiViewModel.fromJson(Map<String, dynamic> json) {
    return KpiViewModel(
      title: json['title'],
      value: json['value'],
      unit: json['unit'],
    );
  }
}
