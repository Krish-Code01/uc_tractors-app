import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uc_tractors/provider/cart.dart';

class CartTile extends StatelessWidget {
  const CartTile({super.key});

  @override
  Widget build(BuildContext context) {
    List<CartItem> _item = Provider.of<Cart>(context).items;
    String formatNumberAsINR(double amount) {
      var formatter = NumberFormat.currency(locale: 'en_IN', symbol: '₹');
      return formatter.format(amount);
    }

    return Expanded(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: _item.length,
        itemBuilder: ((context, index) {
          return Column(
            children: [
              ListTile(
                leading: Container(
                  width: MediaQuery.of(context).size.width / 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      _item[index].imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(_item[index].title),
                subtitle: Text(
                  formatNumberAsINR(
                    double.parse("${_item[index].price}"),
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {
                    Provider.of<Cart>(context, listen: false)
                        .removeItem(_item[index].id);
                  },
                  icon: Icon(
                    Icons.cancel,
                  ),
                ),
              ),
              Divider(
                thickness: 1,
                indent: 10,
                endIndent: 10,
              )
            ],
          );
        }),
      ),
    );
  }
}
