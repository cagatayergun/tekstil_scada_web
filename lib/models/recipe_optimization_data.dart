class RecipeOptimizationData {
  final String recipeName;
  final double currentCost;
  final double optimizedCost;
  final String savings;

  RecipeOptimizationData({
    required this.recipeName,
    required this.currentCost,
    required this.optimizedCost,
    required this.savings,
  });

  factory RecipeOptimizationData.fromJson(Map<String, dynamic> json) {
    return RecipeOptimizationData(
      recipeName: json['recipeName'],
      currentCost: json['currentCost'].toDouble(),
      optimizedCost: json['optimizedCost'].toDouble(),
      savings: json['savings'],
    );
  }
}
