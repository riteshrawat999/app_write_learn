import 'package:app_write_learn/app/data/provider/appwrite_provider.dart';
import 'package:appwrite/models.dart' as models;

class AuthRepository {

  final AppWriteProvider appWriteProvider;

  AuthRepository(this.appWriteProvider);

  Future<models.Model> signup(Map map) => appWriteProvider.signup(map);

  Future<models.Session> login(Map map) => appWriteProvider.login(map);

  Future<dynamic> logout(String sessionId) => appWriteProvider.logout(sessionId);

  Future<models.File> uploadEmployeeImage(String imagePath) => appWriteProvider.uploadEmployeeImage(imagePath);

  Future<dynamic> deleteEmployeeImage(String fileId) => appWriteProvider.deleteEmployeeImage(fileId);

  Future<models.Document> createEmployee(Map map) => appWriteProvider.createEmployee(map);

  Future<models.DocumentList> getEmployees() => appWriteProvider.getEmployees();

  Future<models.Document> updateEmployee(Map map) => appWriteProvider.updateEmployee(map);
}