import 'package:app_write_learn/app/utils/appwrite_constant.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

class AppWriteProvider {
  Client client = Client();

  Account? account;

  Storage? storage;
  Databases? databases;

  AppWriteProvider() {
    client
        .setEndpoint(AppwriteConstant.endPoint)
        .setProject(AppwriteConstant.projectId)
        .setSelfSigned(status: true);
    account = Account(client);
    storage = Storage(client);
    databases = Databases(client);
  }

  Future<models.Model> signup(Map map) async {
    final response = account!.create(
        userId: map['userId'],
        email: map['email'],
        password: map['password'],
        name: map['name']);
    return response;
  }

  Future<models.Session> login(Map map) async {
    final response = account!.createEmailPasswordSession(
        email: map['email'], password: map['password']);
    return response;
  }

  Future<dynamic> logout(String sessionId) async {
    final response = account!.deleteSession(sessionId: sessionId);
    return response;
  }

  Future<models.File> uploadEmployeeImage(String imagePath) async {
    String fileName =
        "${DateTime.now().microsecondsSinceEpoch}.${imagePath.split('.').last}";
    final response = storage!.createFile(
        bucketId: AppwriteConstant.employeeBucketsId,
        fileId: ID.unique(),
        file: InputFile.fromPath(path: imagePath, filename: fileName));
    return response;
  }

  Future<dynamic> deleteEmployeeImage(String fileId) async {
    final response = storage!.deleteFile(
      bucketId: AppwriteConstant.employeeBucketsId,
      fileId: fileId,
    );
    return response;
  }

  Future<models.Document> createEmployee(Map map) async {
    final response = databases!.createDocument(
        databaseId: AppwriteConstant.dbId,
        collectionId: AppwriteConstant.employeeCollectionId,
        documentId: ID.unique(),
        data: {
          'name': map['name'],
          'department': map['department'],
          'createdBy': map['createdBy'],
          'image': map['image'],
          'createdAt': map['createdAt'],
        });
    return response;
  }

 Future<models.DocumentList> getEmployees() async {
    final response = databases!.listDocuments(
        databaseId: AppwriteConstant.dbId,
        collectionId: AppwriteConstant.employeeCollectionId
    );
    return response;
  }

  Future<models.Document> updateEmployee(Map map) async{
    final response = databases!.updateDocument(databaseId: AppwriteConstant.dbId,
        collectionId: AppwriteConstant.employeeCollectionId,
        documentId: map['documentId'],
        data: {
          'name' : map['name'],
          'department' : map['department'],
          'createdBy' : map['createdBy'],
          'image' : map['image']
        }
    );
    return response;
  }


}
