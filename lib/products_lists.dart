import 'package:flutter/material.dart';
import 'package:eshop/data.dart';
import 'package:eshop/products.dart';
import 'package:eshop/products_details.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<String> brands = const [
    'All',
    'Puma',
    'Addidas',
    'Craft',
    'sands',
    'sapatu',
    'macbook'
  ];

  late String selectedBrands = brands[0];

  @override
  void initState() {
    super.initState();
    selectedBrands = brands[0];
  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
        borderSide: BorderSide(
          color: Color.fromRGBO(225, 225, 225, 1),
        ),
        borderRadius: BorderRadius.horizontal(left: Radius.circular(50)));

    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Shoe\nCollection',
                  style: Theme.of(context).textTheme.titleLarge,
                  // style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                ),
              ),
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(fontWeight: FontWeight.bold),
                      prefixIcon: Icon(Icons.search),
                      border: border,
                      enabledBorder: border,
                      focusedBorder: border),
                  keyboardType: TextInputType.text,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: brands.length,
              itemBuilder: (context, index) {
                final filiers = brands[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedBrands = filiers;
                      });
                    },
                    child: Chip(
                      backgroundColor: selectedBrands == filiers
                          ? Theme.of(context).colorScheme.primary
                          : const Color.fromRGBO(245, 247, 249, 1),
                      side: const BorderSide(
                          color: Color.fromRGBO(245, 247, 249, 1)),
                      label: Text(filiers),
                      labelStyle: const TextStyle(fontSize: 16),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductsDetailsPage(
                            data: product,
                          ),
                        ),
                      );
                    },
                    child: ProductsCard(
                        title: product['title'] as String,
                        price: product['price'] as double,
                        image: product['imageUrl'] as String,
                        backgrundColor: index.isEven
                            ? const Color.fromRGBO(216, 240, 253, 1)
                            : const Color.fromRGBO(245, 247, 249, 1)),
                  );
                }),
          )
        ],
      ),
    );
  }
}
