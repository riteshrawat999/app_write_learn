class EmployeeModel {

   String? name;
   String? department;
   String? createdBy;
   String? image;
   String? createdAt;
   String? documentId;

  EmployeeModel.fromMap(Map<String,dynamic> map) {
    name  = map['name'];
    department  = map['department'];
    createdBy  = map['createdBy'];
    image  = map['image'];
    createdAt  = map['createdAt'];
    documentId  = map['\$id'];
  }

  Map<String,dynamic> toMap () {
    return {
    'name'  : name,
    'department'  : department,
    'createdBy'  : createdBy,
    'image'  : image,
    'createdAt'  :createdAt,
    'documentId'  :documentId
    };
  }

}