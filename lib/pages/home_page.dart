import 'package:buy_shoes_online/controller/home_controller.dart';
import 'package:buy_shoes_online/pages/add_product_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Footware Admin')),
        ),
        body: ListView.builder(
            itemCount: ctrl.products.length,
            itemBuilder: (context, int index) {
              return ListTile(
                title: Text(ctrl.products[index].name ?? ' '),
                subtitle: Text((ctrl.products[index].price ?? 0).toString()),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    ctrl.deleteProduct(ctrl.products[index].id ?? '');
                  },
                ),
              );
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(AddProductPage());
          },
          child: const Icon(Icons.add),
        ),
      );
    });
  }
}
