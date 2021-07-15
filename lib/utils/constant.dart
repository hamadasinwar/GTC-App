class Constant{
  String baseUrl = "http://10.0.2.151/";

  String studentsUrl(){
    return "${baseUrl}GTC/getStudents.php";
  }

  String gradesUrl(){
    return "${baseUrl}GTC/getGrades.php";
  }
}