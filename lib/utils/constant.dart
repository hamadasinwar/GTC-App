class Constant{
  String baseUrl = "http://10.0.3.183/";

  String studentsUrl(){
    return "${baseUrl}GTC/getStudents.php";
  }

  String gradesUrl(){
    return "${baseUrl}GTC/getGrades.php";
  }
}