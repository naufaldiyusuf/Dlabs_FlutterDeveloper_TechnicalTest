part of '../views.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final titleField = TextEditingController();
  final descriptionField = TextEditingController();

  bool isLoading = false;
  bool isError = true;
  String? title;
  String? description;
  File? poster;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Create Movie"),
      ),
      body: BlocListener<CreateBloc, CreateState>(
        listener: (_, state) {
          if (state is CreateLoading) {
            isLoading = true;
            setState(() {});
          } else if (state is CreateSuccess) {
            isLoading = false;
            setState(() {});
            showAlertDialogError(context, "Movie submitted successfully");
          } else if (state is CreateError) {
            isLoading = false;
            setState(() {});
            showAlertDialogError(context, "There's something wrong, please try again");
          }
        },
        child: Stack(
          children: [
            Opacity(
                opacity: isLoading ? 0.5 : 1,
              child: AbsorbPointer(
                absorbing: isLoading,
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Movie Title"),
                            Text("*", style: TextStyle(color: Colors.red),)
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextField(
                          controller: titleField,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Write title here..."
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Movie Description"),
                            Text("*", style: TextStyle(color: Colors.red),)
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextField(
                          maxLines: 6,
                          controller: descriptionField,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Write description here..."
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Text("Movie Poster"),
                      ),
                      GestureDetector(
                        onTap: () {
                          getFromGallery((file) {
                            poster = file;
                            setState(() {});
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(),
                          ),
                          margin: EdgeInsets.only(top: 10),
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 100,
                                child: Text(
                                  poster == null ? "Select File Here" : poster!.path,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Icon(
                                  Icons.upload
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (poster != null)
                        GestureDetector(
                          onTap: () {
                            poster = null;
                            setState(() {});
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text("Delete poster"),
                          ),
                        ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 50,
                        margin: EdgeInsets.only(top: 50),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              primary: Colors.blueAccent),
                          child: Text(
                            "Submit",
                            style: TextStyle(
                                fontSize: 14),
                          ),
                          onPressed: () {
                            if (titleField.text.isEmpty) {
                              showAlertDialogError(context, "title cannot be empty");
                            } else if (descriptionField.text.isEmpty) {
                              showAlertDialogError(context, "description cannot be empty");
                            } else {
                              context.read<CreateBloc>().add(CreateNewMovies(titleField.text, descriptionField.text, poster));
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: Opacity(
                opacity: isLoading ? 1.0 : 0,
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
