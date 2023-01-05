part of '../views.dart';

class ListDetailScreen extends StatelessWidget {
  final String title;
  final String description;
  final String? poster;

  ListDetailScreen(this.title, this.description, this.poster);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Movie Detail"),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 10,
            ),
            alignment: Alignment.center,
            child: Text(
                title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Container(
            height: 350,
            alignment: Alignment.center,
            child: poster == null
                ? Icon(Icons.image, size: 150)
                : Image.network(
              poster!,
              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                return Icon(Icons.image, size: 150);
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 40,
              left: 10,
              right: 10
            ),
            child: Text("$description..."),
          )
        ],
      ),
    );
  }
}
