part of '../views.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  bool isError = false;
  bool isNextProcess = false;
  List<ListModelData> data = [];
  int page = 1;
  bool isLoadingNext = false;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<ListBloc>().add(GetList(page, true));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (!isNextProcess) {
          isNextProcess = true;
          setState(() {});
          context.read<ListBloc>().add(GetList(page, false));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Movie List"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
      body: BlocListener<ListBloc, ListState>(
        listener: (_, state) {
          if (state is ListGetLoading) {
            isLoading = true;
            isError = false;
            setState(() {});
          } else if (state is ListGetSuccess) {
            isNextProcess = false;
            isError = false;
            isLoading = false;
            isLoadingNext = false;
            if (state.data.isNotEmpty) {
              state.data.forEach((e) {
                data.add(e);
              });
              page += 1;
            }
            setState(() {});
          } else if (state is ListGetError) {
            isLoading = false;
            isError = true;
            setState(() {});
          } else if (state is ListGetLoadingNext) {
            isLoadingNext = true;
            setState(() {});
          } else if (state is ListGetNextError) {
            isLoadingNext = false;
            setState(() {});
            showAlertDialogError(context, "There's something wrong, please try again");
          }
        },
        child: isLoading
            ? Center(
          child: CircularProgressIndicator(
            color: Colors.blue,
          ),
        )
            : (isError
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error, color: Colors.red, size: 150,),
              Text(
                  "There's something wrong",
                style: TextStyle(
                  fontSize: 18
                ),
              ),
              Container(
                width: 200,
                height: 50,
                margin: EdgeInsets.only(top: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      primary: Colors.blueAccent),
                  child: Text(
                    "Try again",
                    style: TextStyle(
                        fontSize: 14),
                  ),
                  onPressed: () => context.read<ListBloc>().add(GetList(page, true))
                  ,
                ),
              )
            ],
          ),
        )
            : Stack(
          children: [
            ListView(
              controller: _scrollController,
              padding: EdgeInsets.only(top: 20),
              children: data.map((e) => GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ListDetailScreen(e.title, e.description, e.poster)),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    color: Colors.transparent,
                  ),
                  margin: EdgeInsets.only(bottom: 20, left: 5, right: 5),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                    children: [
                      Container(
                        width: 120,
                        child: e.poster == null
                            ? Icon(Icons.image, size: 150)
                            : Image.network(
                          e.poster!,
                          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                            return Icon(Icons.image, size: 150);
                          },
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: 150,
                        child: Text(e.title),
                      )
                    ],
                  ),
                ),
              )).toList(),
            ),
            if (isLoadingNext)
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    height: 40,
                    width: 40,
                    child: CircularProgressIndicator()),
              )
          ],
        )),
      ),
    );
  }
}
