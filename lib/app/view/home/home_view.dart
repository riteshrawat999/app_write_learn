import 'package:app_write_learn/app/utils/appwrite_constant.dart';
import 'package:app_write_learn/app/view/home/home_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends  StatelessWidget{
    HomeView({super.key});
   final HomeController controller = Get.find<HomeController>();
   @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Home View",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(onPressed: (){
            controller.logout();
          }, icon: const Icon(Icons.logout,color: Colors.white,))
        ],
      ),
      body: Padding(padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 10),
        child: Obx(() =>
            ListView.separated(
          padding: const EdgeInsets.only(top: 8,bottom: 8),
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              height: 10,
              color: Colors.grey,
            );
          },
          physics:const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return ListTile(
              leading: SizedBox(
                height: 100,
                width: 100,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage('${AppwriteConstant.endPoint}/storage/buckets/${AppwriteConstant.employeeBucketsId}/files/${controller.employeeList[index].image}/view?project=${AppwriteConstant.projectId}'),
                ),
              ),
              title: Text(
                controller.employeeList[index].name ?? 'Nothing',
                style: const TextStyle(fontSize: 16),
              ),
              subtitle: Text(
                controller.employeeList[index].department?? 'Default',
                style:const TextStyle(fontSize: 14),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: (){
                    controller.moveToEditEmployee(controller.employeeList[index]);
                  } , icon: const Icon(Icons.edit,color: Colors.blue,)),
                  IconButton(onPressed: (){

                  }, icon: const Icon(Icons.delete,color: Colors.red,)),
                ],
              ),
            );
          },
          itemCount: controller.employeeList.length,
        ),
      ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        controller.moveToEmployee();
      },backgroundColor: Colors.blue,child:const Icon(Icons.add,color: Colors.white,),),
    );
  }
}
