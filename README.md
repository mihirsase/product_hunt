# Product Hunt  
  
This is a flutter application for a demonstrating bloc pattern architecture along with usage of SQLITE.  
## APK Link 
[Android apk download link](https://drive.google.com/file/d/1LXxTMXHN1ysdNi83PD2O7QedUN5X2XP1/view?usp=sharing)


   
## Project Structure  
  
- **.screens** : All the main screens for the app goes into this package  
- **.blocs** : All business logic is inside these files 
- **.components** : All reusable widgets are stored in this package  
  - **.atoms** : Atoms are completely stateless reusable components.  
  - **.molecules** : Molecules are stateful reusable components.  
  - **.organisms** : Organisms have their own state,bloc and probably won't be used again.  
- **.models** : All the blueprint files for the app goes into this package  
- **.services** : All classes which provides additional help goes in this package  
- **.extensions** : Contains various object extension files  
- **.assets** : All external images and fonts are stored here 

## Unit Test
Unit test for mock api call can be bound inside test/unit_test.dart
Use the command [flutter test] to run the test cases
  
## Third party packages used in the project  
  
- **shared_preferences** : Used for storing the login status of the user  
- **flutter_bloc** : Used for separating business logic from ui code
- **intl** : Used to format date
- **sqflite** : Used to persist some user data
- **path** : Used to get the local database path
- **connectivity_plus** : Used to check device connectivity satus
- **dio** : Used for making REST API requests
- **flutter_search_bar** : Used for filtering posts
- **url_launcher** : Used to launch url on external browser