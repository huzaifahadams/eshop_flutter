import 'package:eshop/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsDetailsPage extends StatefulWidget {
  final Map<String, dynamic> data;

  const ProductsDetailsPage({Key? key, required this.data}) : super(key: key);

  @override
  State<ProductsDetailsPage> createState() => _ProductsDetailsPageState();
}

class _ProductsDetailsPageState extends State<ProductsDetailsPage> {
  int selectedsizes = 0;
  void onTap() {
    if (selectedsizes != 0) {
      Provider.of<CartProvider>(context, listen: false).addProduct({
        'id': widget.data['id'],
        'company': widget.data['company'],
        'title': widget.data['title'],
        'price': widget.data['price'],
        'size': selectedsizes,
        'imageUrl': widget.data['imageUrl'],
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Product ${widget.data['title']} added to cart')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
        'Select the size',
        style: TextStyle(color: Colors.red),
      )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          color: Colors.black,
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        title: const Text(
          'Details',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Column(children: [
        Center(
          child: Text(
            widget.data['title'],
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Image.asset(widget.data['imageUrl']),
        ),
        const Spacer(
          flex: 2,
        ),
        Container(
          height: 250,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(245, 246, 247, 1),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '\$${widget.data['price'].toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: (widget.data['sizes'] as List<int>).length,
                    itemBuilder: (context, index) {
                      final size = (widget.data['sizes'] as List<int>)[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedsizes = size;
                            });
                          },
                          child: Chip(
                            backgroundColor: selectedsizes == size
                                ? Theme.of(context).colorScheme.primary
                                : null,
                            label: Text(size.toString()),
                          ),
                        ),
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                    onPressed: onTap,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        minimumSize: const Size(double.infinity, 50)),
                    child: const Text(
                      'Add to cart',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    )),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
