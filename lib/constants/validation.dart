import 'package:form_field_validator/form_field_validator.dart';

final passwordValidator= MultiValidator([
  RequiredValidator(errorText: "Password Is Required"),
  MinLengthValidator(6, errorText: "Password Should be of at least 6 character"),
]);
final nameValidator= MultiValidator([
  RequiredValidator(errorText: "Name Is Required"),
  MinLengthValidator(3, errorText: "name Should be of at least 6 character"),
]);

final searchValidator= MultiValidator([
  RequiredValidator(errorText: "Name Is Required"),
]);
