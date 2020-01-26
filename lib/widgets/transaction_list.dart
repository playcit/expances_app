import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactions;
  final Function _deleteTx;

  TransactionList(this._userTransactions, this._deleteTx);

  @override
  Widget build(BuildContext context) {
    return _userTransactions.isEmpty
        ? Column(
            children: <Widget>[
              Text(
                'No Transactions',
                style: Theme.of(context).textTheme.title,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 200,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              return Dismissible(
                direction: DismissDirection.endToStart,
                key: Key(_userTransactions[index].id),
                onDismissed: (direction) {
                  _deleteTx(_userTransactions[index].id);
                  Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(
                          "${_userTransactions[index].title} got deleted")));
                },
                background: Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: ListTile(
                      trailing: Icon(
                        Icons.delete,
                        color: Theme.of(context).errorColor,
                        size: 40,
                      ),
                    ),
                  ),
                ),
                child: Card(
                  margin: EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 5,
                  ),
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Theme.of(context).primaryColorLight,
                      child: FittedBox(
                        child: Text('\$${_userTransactions[index].amount}'),
                      ),
                    ),
                    title: Text(
                      _userTransactions[index].title,
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(_userTransactions[index].date),
                    ),
                    // trailing: IconButton(
                    //   icon: Icon(Icons.delete),
                    //   color: Theme.of(context).errorColor,
                    //   //splashColor: Colors.red,
                    //   onPressed: () => _deleteTx(_userTransactions[index].id),
                    // ),
                  ),
                ),
              );
            },
            itemCount: _userTransactions.length,
          );
  }
}
