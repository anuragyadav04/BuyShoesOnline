import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/product/product.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference productCollection;

  TextEditingController productNameCtrl = TextEditingController();
  TextEditingController productDescriptionCtrl = TextEditingController();
  TextEditingController productImgCtrl = TextEditingController();
  TextEditingController productPriceCtrl = TextEditingController();

  String category = 'general';
  String brand = 'un branded';
  bool offer = false;

  List<Product> products = [];

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    productCollection = firestore.collection('products');
    await fetchProduct();
    super.onInit();
  }

  addProduct() {
    try {
      DocumentReference doc = productCollection.doc();
      Product product = Product(
        id: doc.id,
        name: productNameCtrl.text,
        category: category,
        description: productDescriptionCtrl.text,
        price: double.tryParse(productPriceCtrl.text),
        brand: brand,
        image: productImgCtrl.text,
        offer: offer,
      );

      final productJson = product.toJson();
      doc.set(productJson);
      Get.snackbar('Success', 'Product Added Successfully',
          colorText: Colors.green);
      setValuesDefault();
    } on Exception catch (e) {
      // TODO
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
    }
  }

  fetchProduct() async {
    try {
      QuerySnapshot productSnapshot = await productCollection.get();
      final List<Product> retrivedProducts = productSnapshot.docs
          .map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      products.clear();
      products.assignAll(retrivedProducts);
      Get.snackbar("Success", "Product Fetch Successfully",
          colorText: Colors.green);
    } on Exception catch (e) {
      // TODO
      Get.snackbar("Error", e.toString(), colorText: Colors.red);
      print(e);
    }
  }

  deleteProduct(String id) async {
    try {
      await productCollection.doc(id).delete();
      fetchProduct();
    } on Exception catch (e) {
      // TODO
      Get.snackbar("Error", e.toString(), colorText: Colors.red);
      print(e);
    } finally {
      update();
    }
  }

  setValuesDefault() {
    productNameCtrl.clear();
    productImgCtrl.clear();
    productPriceCtrl.clear();
    productDescriptionCtrl.clear();
    category = 'general';
    brand = ' un branded';
    offer = false;
    update();
  }
}
