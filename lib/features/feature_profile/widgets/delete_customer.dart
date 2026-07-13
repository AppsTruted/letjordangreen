
import 'package:flutter/material.dart';
import 'package:letjordangreen/features/feature_profile/profile_provider.dart';
import 'package:provider/provider.dart';

class DeleteCustomerWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return PopupMenuButton<int>(
        icon: Icon(Icons.more_vert),
        onSelected:  (value){_showDialog(context);},
        itemBuilder: (context) => [
          PopupMenuItem(
            padding: EdgeInsets.all(8),
            value: 1,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.delete_outline_rounded,color: Colors.black,),
                SizedBox(
                  width: 8,
                ),
                Text("Delete account")
              ],
            ),
          )
        ]);
  }
  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Selector<ProfileProvider, bool>(
          selector: (context,listenTo) => listenTo.isDeleting,
          builder:  (context, profileProviderValue, child) {
            return AlertDialog(
              content:  profileProviderValue ? Text("Please wait until we clearing you account") :
              Text("Are you sure you want to delete your account? This action cannot be undone and all your data will be permanently lost."),
              actions: profileProviderValue ? [Row(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                ],
              )]: [

                MaterialButton(
                  child: Text("Cancel",style:  Theme.of(context).textTheme.bodyMedium?.copyWith(color:Colors.grey)),
                  onPressed: () {
                    Navigator.of(context).pop();

                  },
                ),


                MaterialButton(
                  child: Text("Yes, I'm sure",style: Theme.of(context).textTheme.bodyMedium,),
                  onPressed: () {
                  },
                ),
              ]  ,
            );
          }
        );
      },
    );
  }


  resetAllData(context){

      // SharedPreferenceClass sharedPreferenceClass = SharedPreferenceClass() ;
      // sharedPreferenceClass.setIsLoggedIn(true);
      //
      // showMessage("Your account has been deleted successfully", false);
      // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>  DrawerInitialize()), (route) => false);

  }
}