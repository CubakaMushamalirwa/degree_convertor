import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedTemp1Provider = StateProvider<String>((ref) {
  return 'Celsius';
});

final selectedTemp2Provider = StateProvider<String>((ref) {
  return 'Fahrenheit';
});

final enteredTempProvider = StateProvider<double>((ref) {
  return 0.0;
});

final tempProvider = StateProvider<String>((ref) {
  final enteredTemp = ref.watch(enteredTempProvider);
  final selectedDegree2 = ref.watch(selectedTemp2Provider);
  final selectedDegree1 = ref.watch(selectedTemp1Provider);
  if (selectedDegree1.toLowerCase() == 'celsius' &&
      selectedDegree2.toLowerCase() == 'fahrenheit') {
    final response = (enteredTemp * 9 / 5) + 32;
    return response.toString();
  } else if (selectedDegree1.toLowerCase() == 'fahrenheit' &&
      selectedDegree2.toLowerCase() == 'celsius') {
    final response = (enteredTemp - 32) * 5 / 9;
    return response.toString();
  } else if (selectedDegree1.toLowerCase() == 'kelvin' &&
      selectedDegree2.toLowerCase() == 'fahrenheit') {
    final response = (enteredTemp - 273.15) * (9 / 5) + 32;
    return response.toString();
  } else if (selectedDegree1.toLowerCase() == 'kelvin' &&
      selectedDegree2.toLowerCase() == 'celsius') {
    final response = (enteredTemp - 273.15);
    return response.toString();
  } else if (selectedDegree1.toLowerCase() == 'celsius' &&
      selectedDegree2.toLowerCase() == 'kelvin') {
    final response = (enteredTemp + 273.15);
    return response.toString();
  } else if (selectedDegree1.toLowerCase() == 'fahrenheit' &&
      selectedDegree2.toLowerCase() == 'kelvin') {
    final response = (enteredTemp - 32) * (5 / 9) + 273.15;
    return response.toString();
  } else {
    return enteredTemp.toString();
  }
});
