class Student {
  String name;
  String rollNo;
  String status;

  Student({
    required this.name,
    required this.rollNo,
    this.status = 'Active', // Default status
  });
}
