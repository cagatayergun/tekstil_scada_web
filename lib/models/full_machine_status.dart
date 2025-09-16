class FullMachineStatus {
  final int id;
  final String name;
  final String status;
  final double temperature;
  final int rpm;
  final String currentRecipe;
  final int currentStep;
  final double currentStepValue;
  final String imageUrl;

  FullMachineStatus({
    required this.id,
    required this.name,
    required this.status,
    required this.temperature,
    required this.rpm,
    required this.currentRecipe,
    required this.currentStep,
    required this.currentStepValue,
    required this.imageUrl,
  });

  factory FullMachineStatus.fromJson(Map<String, dynamic> json) {
    return FullMachineStatus(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      temperature: json['temperature']?.toDouble() ?? 0.0,
      rpm: json['rpm'] ?? 0,
      currentRecipe: json['currentRecipe'] ?? 'Belirtilmemiş',
      currentStep: json['currentStep'] ?? 0,
      currentStepValue: json['currentStepValue']?.toDouble() ?? 0.0,
      imageUrl: json['imageUrl'] ?? 'https://via.placeholder.com/150',
    );
  }
}
