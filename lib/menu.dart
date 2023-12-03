import 'package:flutter/material.dart';

class ShopItem {
  final String name;
  final IconData icon;

  ShopItem(this.name, this.icon);
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  final List<ShopItem> items = [
    ShopItem("Lihat Produk", Icons.checklist),
    ShopItem("Tambah Produk", Icons.add_shopping_cart),
    ShopItem("Logout", Icons.logout),
    ShopItem("Logout", Icons.logout),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shopping List',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text(
                  'Our Book Collections',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GridView.count(
                primary: true,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 20,
                mainAxisSpacing: 50,
                crossAxisCount: 3,
                shrinkWrap: true,
                children: items.map((item) {
                  return ShopCard(item);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HoverText extends StatefulWidget {
  final String text;
  final Color defaultColor;
  final Color hoverColor;

  const HoverText({
    required this.text,
    required this.defaultColor,
    required this.hoverColor,
    Key? key,
  }) : super(key: key);

  @override
  _HoverTextState createState() => _HoverTextState();
}

class _HoverTextState extends State<HoverText> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _updateHover(true),
      onExit: (_) => _updateHover(false),
      child: Text(
        widget.text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: isHovered ? widget.hoverColor : widget.defaultColor,
        ),
      ),
    );
  }

  void _updateHover(bool hoverStatus) {
    if (isHovered != hoverStatus) {
      setState(() {
        isHovered = hoverStatus;
      });
    }
  }
}

class ShopCard extends StatelessWidget {
  final ShopItem item;

  const ShopCard(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 1000,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text("You pressed ${item.name}!"),
                      ),
                    );
                },
                child: Icon(
                  item.icon,
                  color: const Color.fromARGB(255, 4, 4, 4),
                  size: 30.0,
                ),
              ),
              BookName(),
            ],
          ),
        ),
      ),
    );
  }
}

class BookName extends StatelessWidget {
  const BookName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text("You clicked on Additional Text"),
            ),
          );
      },
      child: HoverText(
        text: 'Additional Text',
        defaultColor: Colors.black,
        hoverColor: Colors.blue,
      ),
    );
  }
}
