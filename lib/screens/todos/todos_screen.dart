import 'package:flutter/material.dart';
import 'package:frmproject/apis/todos_api.dart';
import 'package:frmproject/data/TodoDTO.dart';
import 'dart:convert';

class ToDosScreen extends StatefulWidget {
  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<ToDosScreen> {
  var todos = new List<TodosDTO>();

  _getTodos() {
    TodosApi.getTodos().then((response) {
      setState(() {
        Iterable lista = json.decode(response.body);
        todos = lista.map((model) => TodosDTO.fromJson(model)).toList();
      });
    });
  }

  _FirstState() {
    _getTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: _buildTodoList(),
    );
  }

  _buildTodoList() {
    if(todos.isEmpty) {
      return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white),));
    } else {
      return ListView.builder(
          itemCount: todos.length,
          itemBuilder: (_, index) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
              child: Card(
                elevation: 10.0,
                child: Container(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(padding: new EdgeInsets.symmetric(vertical: 3.0)),
                      Text(
                        '${todos[index].id}'
                            ': ${todos[index].title.toUpperCase()}.',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 3.0)),
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(0),
                              color: Colors.white,
                            ),
                            child: Container(
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: todos[index].completed
                                    ? completed()
                                    : notCompleted(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    }
  }

  completed() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          'assets/images/ic-check.png',
          height: 20,
        ),
        SizedBox(width: 6),
        Text(
          'Done',
          style: TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  notCompleted() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          'assets/images/ic-x.png',
          height: 20,
        ),
        SizedBox(width: 6),
        Text(
          'Not completed',
          style: TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
