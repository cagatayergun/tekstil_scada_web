class ScadaRecipe {
  final int id;
  final String name;
  final String machineType;
  final List<ScadaRecipeStep> steps;

  ScadaRecipe({
    required this.id,
    required this.name,
    required this.machineType,
    required this.steps,
  });

  factory ScadaRecipe.fromJson(Map<String, dynamic> json) {
    var stepsJson = json['steps'] as List;
    List<ScadaRecipeStep> stepsList = stepsJson
        .map((step) => ScadaRecipeStep.fromJson(step))
        .toList();

    return ScadaRecipe(
      id: json['id'],
      name: json['name'],
      machineType: json['machineType'],
      steps: stepsList,
    );
  }
}

class ScadaRecipeStep {
  final int stepId;
  final String stepType;
  final Map<String, dynamic> parameters;

  ScadaRecipeStep({
    required this.stepId,
    required this.stepType,
    required this.parameters,
  });

  factory ScadaRecipeStep.fromJson(Map<String, dynamic> json) {
    return ScadaRecipeStep(
      stepId: json['stepId'],
      stepType: json['stepType'],
      parameters: json['parameters'],
    );
  }
}
