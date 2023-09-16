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

	@override
		Widget build(BuildContext context) {
			return Scaffold(
					backgroundColor: Color(0xFF4CAD73),
					appBar: AppBar(
						backgroundColor: Color(0xFF4CAD73),
						title: Text('File Upload App'),
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
										child: Text('拍照', style: TextStyle(fontSize: 20)),
										onPressed: () {
										getImage(true);
										},
										),
									ElevatedButton(
										style: ElevatedButton.styleFrom(primary: Color(0xFF4CAD73)),
										child: Text('選擇圖片', style: TextStyle(fontSize: 20)),
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
            child: Text('商品標題', style: TextStyle(fontSize: 20, color: Colors.white)),
          ),
					TextField(
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
					  child: Text('商品描述', style: TextStyle(fontSize: 20, color: Colors.white)),
          ),
          TextField(
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
            child: Text('數量', style: TextStyle(fontSize: 20, color: Colors.white)),
          ),
          Container(
							height: 100.0,
							child: CupertinoPicker(
								backgroundColor: Color(0xFF4CAD73),
								itemExtent: 32.0,
								onSelectedItemChanged: (int index) {
								// Implement logic for quantity selection
							 	},
                children: List<Widget>.generate(100, (int index) {
		              return Text('$index', style: TextStyle(color: Colors.white, fontSize: 20.0));
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
                child: Text('價格', style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
              SizedBox(width: 16),  // 提供一些間距
              Expanded(  // 使用 Expanded 讓 TextField 可以佔用 Row 中剩餘的空間
                child: TextField(
                  keyboardType: TextInputType.number,  // 設定鍵盤類型為數字
                  decoration: InputDecoration(
                    hintText: '輸入價格',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
					SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft,
					  child: Text('分類', style: TextStyle(fontSize: 20, color: Colors.white)),
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
Text('macbook pro', style: TextStyle(color: Colors.white, fontSize: 32.0)),
Text('macbook air', style: TextStyle(color: Colors.white, fontSize: 32.0)),
Text('ipad', style: TextStyle(color: Colors.white, fontSize: 32.0)),
Text('iphone', style: TextStyle(color: Colors.white, fontSize: 32.0)),
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
									// Implement upload functionality
									},
									),
								),
							],
							),
							);
		}
}
