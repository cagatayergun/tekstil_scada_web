class ProcessControlCommand {
  final int machineId;
  final String commandType;
  final Map<String, dynamic> parameters;

  ProcessControlCommand({
    required this.machineId,
    required this.commandType,
    required this.parameters,
  });

  Map<String, dynamic> toJson() {
    return {
      'machineId': machineId,
      'commandType': commandType,
      'parameters': parameters,
    };
  }
}
