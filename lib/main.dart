import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int total = 0;
  final List<GlobalKey<_ShoppingItemState>> _itemKeys = [
    GlobalKey<_ShoppingItemState>(),
    GlobalKey<_ShoppingItemState>(),
    GlobalKey<_ShoppingItemState>(),
    GlobalKey<_ShoppingItemState>(),
  ];

  void updateTotal(int price, int count) {
    setState(() {
      total += price * count;
    });
  }

  void clearAll() {
    setState(() {
      total = 0;
    });
    for (var key in _itemKeys) {
      key.currentState?.resetCount();
    }
  }

  String formatNumber(int number) {
    return number
        .toString()
        .replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => ',');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Shopping Cart"),
          backgroundColor: Colors.deepOrange,
        ),
        body: Column(children: [
          Expanded(
              child: Column(children: [
            ShoppingItem(
              key: _itemKeys[0],
              title: "iPad Pro",
              price: 32000,
              onUpdateTotal: updateTotal,
            ),
            ShoppingItem(
              key: _itemKeys[1],
              title: "iPad Mini",
              price: 25000,
              onUpdateTotal: updateTotal,
            ),
            ShoppingItem(
              key: _itemKeys[2],
              title: "iPad Air",
              price: 29000,
              onUpdateTotal: updateTotal,
            ),
            ShoppingItem(
              key: _itemKeys[3],
              title: "iPad Pro",
              price: 39000,
              onUpdateTotal: updateTotal,
            ),
          ])),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                "Total",
                style: TextStyle(fontSize: 30),
              ),
              Text(
                '${formatNumber(total)} ฿',
                style: const TextStyle(fontSize: 30),
              ),
              ElevatedButton(
                onPressed: clearAll,
                child: const Text(
                  "Clear",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          )
        ]),
      ),
    );
  }
}

class ShoppingItem extends StatefulWidget {
  final String title;
  final int price;
  final Function(int price, int count) onUpdateTotal;

  ShoppingItem({
    required Key key,
    required this.title,
    required this.price,
    required this.onUpdateTotal,
  }) : super(key: key);

  @override
  State<ShoppingItem> createState() => _ShoppingItemState();
}

class _ShoppingItemState extends State<ShoppingItem> {
  int count = 0;

  void _incrementCount() {
    setState(() {
      count++;
    });
    widget.onUpdateTotal(widget.price, 1);
  }

  void _decrementCount() {
    if (count > 0) {
      setState(() {
        count--;
      });
      widget.onUpdateTotal(widget.price, -1);
    }
  }

  void resetCount() {
    setState(() {
      count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: const TextStyle(fontSize: 28),
              ),
              Text("${widget.price} ฿")
            ],
          ),
        ),
        Row(
          children: [
            IconButton(
                onPressed: _decrementCount, icon: const Icon(Icons.remove)),
            const SizedBox(
              width: 10,
            ),
            Text(
              count.toString(),
              style: const TextStyle(fontSize: 28),
            ),
            const SizedBox(
              width: 10,
            ),
            IconButton(onPressed: _incrementCount, icon: const Icon(Icons.add))
          ],
        )
      ],
    );
  }
}
