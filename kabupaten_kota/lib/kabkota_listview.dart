import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'kabkota.dart';
import 'detail_kabkota.dart';
import 'about_developer.dart';

class KabKotaListView extends StatefulWidget {
  const KabKotaListView({super.key});

  @override
  KabKotaListViewState createState() => KabKotaListViewState();
}

class KabKotaListViewState extends State<KabKotaListView> {
  static const String URL = 'http://192.168.1.190:8080/kabupaten-kota';
  late Future<List<KabKota>> resultData;

  @override
  void initState() {
    super.initState();
    resultData = _fetchKabKota();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kabupaten/Kota App'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return AboutDeveloper();
                  },
                ),
              );
            },
          ),
        ],
      ),

      body: FutureBuilder<List<KabKota>>(
        future: resultData,
        builder: (context, snapshot) {
          return RefreshIndicator(
            onRefresh: _pullRefresh,
            child: Center(
              child: _listView(snapshot),
            ),
          );
        },
      ),
    );
  }

  Future<void> _pullRefresh() async {
    setState(() {
      resultData = _fetchKabKota();
    });
  }

  Widget _listView(AsyncSnapshot<List<KabKota>> snapshot) {
    if (snapshot.hasData) {
      List<KabKota>? data = snapshot.data;
      return _kabKotaListView(data!);
    } else if (snapshot.hasError) {
      return Text("${snapshot.error}");
    }
    return const CircularProgressIndicator();
  }

  Future<List<KabKota>> _fetchKabKota() async {
    var uri = Uri.parse('$URL/api/read_kabkota.php');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      List jsonData = jsonResponse['data'];
      return jsonData.map((kabKota) => KabKota.fromJson(kabKota)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  ListView _kabKotaListView(List<KabKota> data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return _tile(context, data[index]);
      },
    );
  }

  ListTile _tile(BuildContext context, KabKota data) {
    return ListTile(
      title: Text(
        data.kabupaten_kota,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20,
        ),
      ),
      subtitle: Text("Pusat Pemerintahan: ${data.pusat_pemerintahan}"),
      leading: Image.network(
        "$URL/image/logo/${data.logo}", // Replace 'https://example.com' with the actual URL
        width: 50,
        height: 100,
      ),
      onTap: () {
        final snackBar = SnackBar(
          duration: const Duration(seconds: 1),
          content: Text("Anda memilih ${data.kabupaten_kota}!"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return DetailKabKota(data: data);
            },
          ),
        );
      },
    );
  }

}
