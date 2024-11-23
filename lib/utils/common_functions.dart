/// Converts a date string in the format 'YYYY-MM-DD' to an array of 
/// strings containing the day name, year, month name, day, and any 
/// additional information.
///
/// Throws a [FormatException] if the input date string does not 
/// contain exactly four parts when split by '-'.
///
/// Example:
/// ```dart
/// var result = convertDateToArray('2023-03-15-Event');
/// print(result); // Output: ['Wednesday', '2023', 'March', '15', 'Event']
/// ```
///
/// Parameters:
/// - [date]: A string representing the date in 'YYYY-MM-DD' format.
///
/// Returns:
/// A list of strings containing the day name, year, month name, day, 
/// and any additional information.
List<String> convertDateToArray(String date) {
  final dateParts = date.split('-');
  if (dateParts.length != 4) {
    throw const FormatException('Invalid date format');
  }

  final day =
      DateTime.parse('${dateParts[2]}-${dateParts[1]}-${dateParts[0]}').weekday;
  final dayNames = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  final dayName = dayNames[day - 1];

  final monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  final monthName = monthNames[int.parse(dateParts[1]) - 1];

  return [dayName, dateParts[0], monthName, dateParts[2], dateParts[3]];
}
