import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final List<String> addressList = ['新竹縣竹北市自強三路55號5樓', '桃園市平鎮區廣東路20巷22號', '桃園市平鎮區廣東路20巷24號'];
  final List<String> imageList = [
    'assets/appleid/imac_left.jpeg',
    'assets/appleid/imac.jpeg',
    'assets/appleid/ipad.jpeg',
    'assets/appleid/ipad.jpeg',
    'assets/appleid/imac_left.jpeg',
    'assets/appleid/imac.jpeg',
    'assets/appleid/ipad.jpeg',
    'assets/appleid/ipad9th.jpeg',
    'assets/appleid/ipad10th.jpeg',
    'assets/appleid/ipadair.jpeg',
    'assets/appleid/ipadmini.jpeg',
    'assets/appleid/ipadpro.jpeg',
    'assets/appleid/iphone13.jpeg',
    'assets/appleid/iphone14.jpeg',
    'assets/appleid/iphonese.jpeg',
    'assets/appleid/macair.jpeg',
    'assets/appleid/macbookpro.jpeg',
    'assets/appleid/macbookpro13.jpeg',
    'assets/appleid/macmini.jpeg',
    'assets/appleid/macpro.jpeg',
    'assets/appleid/macstudio.jpeg',
  ];  
  int currentPage = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4CAD73),
      //KingsChun團購網
      appBar: AppBar(
        title: Text('KingsChun團購網', style: TextStyle(color: Colors.white)), // 字串顏色為白色
        backgroundColor: Color(0xFF4CAD73),  // 背景顏色與 product_list_page.dart 一致
        elevation: 0,
      ),
      body: Column(
        children: [
          // 搜索框和图标
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: '搜尋...',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.mail_outline),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.notifications_none_outlined),
                onPressed: () {},
              ),
            ],
          ),
          // 定位和下拉選單
          Row(
            children: [
              Expanded(
                flex: 1, // 25%
                child: Icon(Icons.location_on),
              ),
              Expanded(
                flex: 1, // 25%
                child: Text('送去'),
              ),
              Expanded(
                flex: 2, // 50%
                child: DropdownButton<String>(
                  isExpanded: true,
                  items: addressList.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (_) {},
                ),
              ),
            ],
          ),
          // 商品圖片
          Container(
            height: 200,
            child: PageView.builder(
              controller: _pageController,
              itemCount: imageList.length,
              onPageChanged: (int page) {
                setState(() {
                  currentPage = page;
                });
              },
              itemBuilder: (BuildContext context, int index) {
                return Image.asset(imageList[index]);
              },
            ),
          ),          
          // Download the image and the information from storage and firestore database
          /*
          Container(
            height: 200,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('products').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('錯誤: ${snapshot.error}'),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final docs = snapshot.data!.docs;

                // 重要：只在有新數據時更新 PageView
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  _pageController.jumpToPage(currentPage);
                });
                
                return PageView.builder(
                  controller: _pageController,
                  itemCount: docs.length,
                  onPageChanged: (int page) {
                    setState(() {
                      currentPage = page;
                    });
                  },
                  itemBuilder: (BuildContext context, int index) {
                    Map<String, dynamic> data = docs[index].data()! as Map<String, dynamic>;
                    return Image.network(data['photo']);
                  },
                );
              },
            ),
          ),
          */
          /*
          // 商品進度條
          LinearProgressIndicator(
            value: (currentPage + 1) / 10, // 這裡我用了固定數量，您可能想根據實際數量進行更改
          ),
          */
          Row(
            mainAxisAlignment: MainAxisAlignment.start,  // 將內容置於行的起始處
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '產品列表',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          // 產品列表
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('products').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('錯誤: ${snapshot.error}'),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView(
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                    return ListTile(
                      title: Text(data['name']),
                      subtitle: Text(data['description']),
                      leading: Image.network(data['photo']),
                      trailing: Text('\$${data['price']}'),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
