import 'dart:math';

class ColorGenerator {
  static const List<String> accessibleColors = [
    // List of accessible colors
    '#FF5733', // Example color
    '#33FF57', // Example color
    '#3357FF', // Example color
    // Add more colors as needed
  ];

  // Generate a color from a given string input
  String generateColor(String input) {
    // Improved hash generation for better distribution
    int hash = input.hashCode;
    Random random = Random(hash);
    
    // Generate a color
    int r = random.nextInt(256);
    int g = random.nextInt(256);
    int b = random.nextInt(256);
    
    String color = '#${r.toRadixString(16).padLeft(2, '0')}${g.toRadixString(16).padLeft(2, '0')}${b.toRadixString(16).padLeft(2, '0')}';

    // Ensure color is accessible by checking against a set of accessible colors
    while (!isColorAccessible(color)) {
      r = random.nextInt(256);
      g = random.nextInt(256);
      b = random.nextInt(256);
      color = '#${r.toRadixString(16).padLeft(2, '0')}${g.toRadixString(16).padLeft(2, '0')}${b.toRadixString(16).padLeft(2, '0')}';
    }
    
    return color;
  }

  // Check if the color is accessible (e.g., sufficient contrast)
  bool isColorAccessible(String color) {
    // Implement accessibility checks
    // For now, simply return true if the color is in the accessibleColors list
    return accessibleColors.contains(color);
  }
}