/*
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 *
 * Author: Nelson Chung
 * Creation Date: September 16, 2023
 */

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'database_helper.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const double title_fontsize = 16.0;

class Product {
	final String? name;
	final String? description;
	final int price;
	final int quantity;
	final String? photo;
	final String? shop;

	Product({
			this.name,
			this.description,
			required this.price,
			required this.quantity,
			this.photo,
			this.shop,
			});

	Map<String, dynamic> toMap() {
		return {
			'name': name,
				'description': description,
				'price': price,
				'quantity': quantity,
				'photo': photo,
				'shop': shop,
		};
	}
}

class AddProductPgae extends StatefulWidget {
	@override
		_AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPgae> {
	File? _image;
	final picker = ImagePicker();
	String dropdownValue = 'macbook pro';
	TextEditingController nameController = TextEditingController();
	TextEditingController descriptionController = TextEditingController();
	TextEditingController priceController = TextEditingController();
	int selectedQuantity=0;


	Future getImage(bool isCamera) async {
		final pickedFile = await picker.pickImage(
				source: isCamera ? ImageSource.camera : ImageSource.gallery);

		setState(() {
				if (pickedFile != null) {
				_image = File(pickedFile.path);
				} else {
				print('No image selected.');
				}
				});
	}

	Future<void> uploadProductToFirebase() async {
		try {
			if (_image != null) {
				// 上傳圖片到 Firebase Storage
				final FirebaseStorage storage = FirebaseStorage.instanceFor(bucket: 'gs://groupbuying-9d07b.appspot.com');
				Reference storageReference = storage.ref().child('products/${DateTime.now().toIso8601String()}.png');
				UploadTask uploadTask = storageReference.putFile(_image!);

				try {
					await uploadTask.whenComplete(() {});
				} catch (e) {
					print("上傳圖片錯誤: $e");
					return; // 如果上傳圖片失敗，則返回以避免進一步的操作
				}

				// 獲取上傳圖片的 URL
				String imageUrl;
				try {
					imageUrl = await storageReference.getDownloadURL();
				} catch (e) {
					print("獲取圖片 URL 錯誤: $e");
					return;
				}

				// 使用 imageUrl 和其他資訊存儲資料到 Cloud Firestore
				try {
					CollectionReference products = FirebaseFirestore.instance.collection('products');
					Map<String, dynamic> productData = {
						'name': nameController.text,
						'description': descriptionController.text,
						'price': int.parse(priceController.text),
						'quantity': selectedQuantity,
						'photo': imageUrl,
						'shop': 'KingsChun',
						'category': dropdownValue,
					};
					await products.add(productData);

					// 打印產品資料
					print("已添加的產品資料: $productData");

					// 顯示成功的 SnackBar
					ScaffoldMessenger.of(context).showSnackBar(
						SnackBar(
						content: Text('商品成功上架！'),
						backgroundColor: Colors.green,
						),
					);
				} catch (e) {
					print("寫入 Firestore 錯誤: $e");

					// 顯示失敗的 SnackBar
					ScaffoldMessenger.of(context).showSnackBar(
						SnackBar(
						content: Text('商品上架失敗: $e'),
						backgroundColor: Colors.red,
						),
					);
				}
			}
		} catch (e) {
			print("未預期的錯誤: $e");
			// 顯示失敗的 SnackBar
			ScaffoldMessenger.of(context).showSnackBar(
				SnackBar(
					content: Text('未預期的錯誤: $e'),
					backgroundColor: Colors.red,
				),
			);
		}
	}


	@override
		Widget build(BuildContext context) {
			return Scaffold(
					backgroundColor: Color(0xFF4CAD73),
					appBar: AppBar(
						backgroundColor: Color(0xFF4CAD73),
						title: Text('新增商品'),
						),
					body: Padding(
						padding: const EdgeInsets.all(16.0),
						child: SingleChildScrollView(
							child: Column(
								children: <Widget>[
								// 拍照與選擇圖片按鈕
								Row(
									mainAxisAlignment: MainAxisAlignment.spaceAround,
									children: [
									ElevatedButton(
										style: ElevatedButton.styleFrom(primary: Color(0xFF4CAD73)),
										child: Text('拍照', style: TextStyle(fontSize: 18)),
										onPressed: () {
										getImage(true);
										},
										),
									ElevatedButton(
										style: ElevatedButton.styleFrom(primary: Color(0xFF4CAD73)),
										child: Text('選擇圖片', style: TextStyle(fontSize: 18)),
										onPressed: () {
										getImage(false);
										},
										),
									],
								   ),
					SizedBox(height: 16),
					_image == null
						? Text('No image selected.')
						: Image.file(_image!, height: 200, width: 200),
					SizedBox(height: 16),
					const Divider(
							//height: 20,
							thickness: 5,
							//indent: 20,
							endIndent: 0,
							color: Color(0xFF4CAD25),
						     ),
					Align(
							alignment: Alignment.centerLeft,          
							child: Text('商品標題', style: TextStyle(fontSize: title_fontsize, color: Colors.white)),
					     ),
					TextField(
							controller: nameController,
							maxLength: 50,
							decoration: InputDecoration(
								labelText: '商品標題',
								border: OutlineInputBorder(),
								),
						 ),
					SizedBox(height: 16),
					const Divider(
							//height: 20,
							thickness: 5,
							//indent: 20,
							endIndent: 0,
							color: Color(0xFF4CAD25),
						     ),
					Align(
							alignment: Alignment.centerLeft,
							child: Text('商品描述', style: TextStyle(fontSize: title_fontsize, color: Colors.white)),
					     ),
					TextField(
							controller: descriptionController,
							maxLines: 4,
							maxLength: 200,
							decoration: InputDecoration(
								labelText: '商品描述',
								border: OutlineInputBorder(),
								),
						 ),
					SizedBox(height: 16),
					const Divider(
							//height: 20,
							thickness: 5,
							//indent: 20,
							endIndent: 0,
							color: Color(0xFF4CAD25),
						     ),
					// 數量的CupertinoPicker
					Align(
							alignment: Alignment.centerLeft,
							child: Text('數量', style: TextStyle(fontSize: title_fontsize, color: Colors.white)),
					     ),
					Container(
							height: 100.0,
							child: CupertinoPicker(
								backgroundColor: Color(0xFF4CAD73),
								itemExtent: 32.0,
								onSelectedItemChanged: (int index) {
								setState(() {
										selectedQuantity = index + 1;  // 加1來獲取正確的數量
										});
								},
								children: List<Widget>.generate(99, (int index) {
										return Text('${index + 1}', style: TextStyle(color: Colors.white, fontSize: title_fontsize));
								}),
							),
						 ),
					SizedBox(height: 16),
					const Divider(
							//height: 20,
							thickness: 5,
							//indent: 20,
							endIndent: 0,
							color: Color(0xFF4CAD25),
						     ),
					// 價格的CupertinoPicker
					Row(
							children: <Widget>[
							Align(
								alignment: Alignment.centerLeft,
								child: Text('價格', style: TextStyle(fontSize: title_fontsize, color: Colors.white)),
							),
							SizedBox(width: 16),  // 提供一些間距
									      //
							Expanded(
								child: TextField(
									controller: priceController,  // 指定 controller
									decoration: InputDecoration(
									hintText: '輸入價格...',
									//prefixIcon: Icon(Icons.search),
									),
									keyboardType: TextInputType.number,  // 增加這一行，只允許數字輸入
								),
								),
							/*
							   Expanded(  // 使用 Expanded 讓 TextField 可以佔用 Row 中剩餘的空間
							   child: TextField(
							   controller: priceController,
							   keyboardType: TextInputType.number,  // 設定鍵盤類型為數字
							   decoration: InputDecoration(
							   hintText: '輸入價格',
							   filled: true,
							   fillColor: Colors.white,
							   border: OutlineInputBorder(),
							   ),
							   ),
							   ),
							 */
							],
							),
							SizedBox(height: 16),
							Align(
									alignment: Alignment.centerLeft,
									child: Text('分類', style: TextStyle(fontSize: title_fontsize, color: Colors.white)),
							     ),
							Container(
									height: 200.0,
									child: CupertinoPicker(
										backgroundColor: Color(0xFF4CAD73),
										itemExtent: 52.0,
										onSelectedItemChanged: (int index) {
										setState(() {
												dropdownValue = ['macbook pro', 'macbook air', 'ipad', 'iphone'][index];
												});
										},
										children: const [
										Text('macbook pro', style: TextStyle(color: Colors.white, fontSize: title_fontsize)),
										Text('macbook air', style: TextStyle(color: Colors.white, fontSize: title_fontsize)),
										Text('ipad', style: TextStyle(color: Colors.white, fontSize: title_fontsize)),
										Text('iphone', style: TextStyle(color: Colors.white, fontSize: title_fontsize)),
										],
									),
								 ),
							],
							),
							),
							),
							// 儲存與上架按鈕
							bottomNavigationBar: Row(
									mainAxisAlignment: MainAxisAlignment.spaceEvenly,
									children: [
									Expanded(
										child: ElevatedButton(
											style: ElevatedButton.styleFrom(primary: Color(0xFF4CAD73)),
											child: Text('儲存', style: TextStyle(fontSize: 20)),
											onPressed: () {
											// Implement save functionality
											},
											),
										),
									Expanded(
										child: ElevatedButton(
											style: ElevatedButton.styleFrom(primary: Color(0xFF4CAD73)),
											child: Text('上架', style: TextStyle(fontSize: 20)),
											onPressed: () {
											uploadProductToFirebase();
											},
											),
										),
									],
									),
									);
		}
}
