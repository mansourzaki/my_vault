import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../models/password.dart';
import '../provider/db_provider.dart';
import '../screens/add_password_screen.dart';
import '../shared.dart';

class PasswordListTile extends StatefulWidget {
  final Password password;
  const PasswordListTile({
    Key? key,
    required this.password,
  }) : super(key: key);

  @override
  State<PasswordListTile> createState() => _PasswordListTileState();
}

class _PasswordListTileState extends State<PasswordListTile> {
  late FToast fToast;
  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  _showToast() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.black,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
        
          SizedBox(
            width: 12.0,
          ),
          Text("Password Copied",style: TextStyle(color: Colors.white),),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(
        color: Colors.red,
        alignment: AlignmentDirectional.centerEnd,
        child: const Padding(
          padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (dir) {
        return confirmDismiss(context,'password');
      },
      onDismissed: (direction) {
        context.read<DbProvider>().deletePassword(widget.password.id!);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Password deleted'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ));
      },
      key: UniqueKey(),
      child: ListTile(
        title: Text(widget.password.title),
        subtitle: Text(widget.password.userName),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                AddPasswordScreen(isEdit: true, password: widget.password),
          ));
        },
        trailing: IconButton(
          onPressed: () async {
            Clipboard.setData(ClipboardData(text: widget.password.password));
            fToast.showToast(
              child: _showToast(),
              gravity: ToastGravity.BOTTOM,
              toastDuration: const Duration(seconds: 2),
            );
            // await Fluttertoast.showToast(
            //   msg: "Copied to clipboard",
            //   toastLength: Toast.LENGTH_SHORT,
            //   gravity: ToastGravity.CENTER,
            // );
          },
          color: Colors.black,
          iconSize: 26.w,
          icon: const FaIcon(
            FontAwesomeIcons.clone,
            color: Colors.black,
          ),
        ),
        leading: Container(
          width: 50.w,
          height: 51.h,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 229, 227, 227),
              borderRadius: BorderRadius.circular(9)),
          child: Center(
            child: Text(widget.password.title[0].toUpperCase()),
          ),
        ),
      ),
    );
  }
}
