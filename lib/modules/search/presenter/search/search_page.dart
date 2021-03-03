import 'package:clean_architecture/modules/search/presenter/search/search_bloc.dart';
import 'package:clean_architecture/modules/search/presenter/search/states/state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final bloc = Modular.get<SearchBloc>();

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Github Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
            child: TextField(
              onChanged: bloc.add,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "search...",
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<Object>(
              stream: bloc,
              builder: (context, snapshot) {
                final state = bloc.state;

                if (state is SearchStart) {
                  return Center(
                    child: Text('Digite um texto'),
                  );
                }

                if (state is SearchError) {
                  return Center(
                    child: Text('Houve um erro'),
                  );
                }

                if (state is SearchLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final list = (state as SearchSuccess).list;
                return ListView.builder(
                  itemCount: list.length ?? 0,
                  itemBuilder: (_, id) {
                    final item = list[id];
                    return ListTile(
                      title: Text(item.title),
                      leading: item.img == null
                          ? Container()
                          : CircleAvatar(
                              backgroundImage: NetworkImage(item.img),
                            ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
