import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4CAD73),
      appBar: AppBar(
        title: Text('KingsChun團購網', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF4CAD73),
        elevation: 0,
      ),
      body: Column(
        children: [
          SearchAndIconsRow(),
          AddressRow(),
          Expanded(child: ImageSlider()),
          ProductTitleRow(),
          Expanded(child: ProductList()),
        ],
      ),
    );
  }
}

class SearchAndIconsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}

class AddressRow extends StatefulWidget {
  @override
  _AddressRowState createState() => _AddressRowState();
}

class _AddressRowState extends State<AddressRow> {
  final List<String> addressList = ['新竹縣竹北市自強三路55號5樓', '桃園市平鎮區廣東路20巷22號', '桃園市平鎮區廣東路20巷24號'];
  String? selectedAddress;

  @override
  void initState() {
    super.initState();
    selectedAddress = addressList.first;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Icon(Icons.location_on),
        ),
        Expanded(
          flex: 1,
          child: Text('送去此處'),
        ),
        Expanded(
          flex: 2,
          child: DropdownButton<String>(
            isExpanded: true,
            items: addressList.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedAddress = newValue!;
              });
            },
          ),
        ),
      ],
    );
  }
}

class ImageSlider extends StatefulWidget {
  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
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
    return Container(
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
    );
  }
}

class ProductTitleRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
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
    );
  }
}

class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
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
    );
  }
}
