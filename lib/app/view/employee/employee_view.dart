import 'dart:io';

import 'package:app_write_learn/app/view/employee/employee_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeView extends StatelessWidget {
  EmployeeView({super.key});

  final EmployeeController _controller = Get.find<EmployeeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          return _controller.isEdit.value == false ? const Text(
            'Create Employee',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ) : const Text('Edit Employee',
            style: TextStyle(color: Colors.white, fontSize: 18),);
        }),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: SingleChildScrollView(
          child: Form(
              key: _controller.formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  // name text form field
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Name',
                    ),
                    keyboardType: TextInputType.text,
                    controller: _controller.nameController,
                    validator: (value) {
                      return _controller.validateName(value!);
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  // department text form field
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Department',
                    ),
                    keyboardType: TextInputType.text,
                    controller: _controller.departmentController,
                    validator: (value) {
                      return _controller.validateDepartment(value!);
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(() =>
                      _controller.imagePath.value == ''
                          ? const Text(
                        'Select image form gallery',
                        style: TextStyle(fontSize: 20),
                      )
                          : CircleAvatar(
                        radius: 80,
                        backgroundImage: _controller.isEdit.value == false
                            ? FileImage(File(_controller.imagePath.value))
                            : NetworkImage(_controller.imagePath.value),
                      )),
                      IconButton(
                          onPressed: () {
                            _controller.selectImage();
                          },
                          icon: const Icon(Icons.image)
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(width: context.width),
                    child: Obx(() {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.all(14)),
                        child:  _controller.isEdit.value == false ?const Text(
                          'Create Employee',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ) :  const Text(
                          'Edit Employee',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                        onPressed: () {
                          if(!_controller.isEdit.value){
                            _controller.validateAndSave(
                                name: _controller.nameController.text,
                                department: _controller.departmentController.text
                                    );
                          }else{

                          }
                        },
                      );
                    }),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
