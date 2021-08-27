# flutter-web-example project

## Architecture
Bloc architecture is used for flutter-web-example. Bloc architecture separates the view (main_page.dart) from the business logic (model/letter_creator.dart) through a bloc class (bloc/letter_bloc.dart) that is inherited in child widgets through a provider pattern. A stream and function call to update the printed letters is exposed to the view by the bloc, and by using a StreamBuilder widget, only the text widget is rebuilt on each update call. This is done without any handlers or calls to setState() in the view class.

Fonts and icons are in the top level assets/ folder.

## Deployment
To deploy flutter-web-example, run the command "flutter build web", and host the contents of build/web/ on the platform of your choice.

## Dev
To run in debug mode, run the command "flutter run -d chrome". You can hot restart with "r" in the terminal.
