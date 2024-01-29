import 'package:model_develop/features/create_files.dart';
/// Choose "-h" to get help on how to use the package
///
/// The body of the file at the base, in the same location as the .yaml, should be like this:
/// 
/// void main(List<String> args) {
/// 
///   ControllerModelDeveloper.init(args);
/// 
/// }
class ControllerModelDeveloper{
/// There are only two commands, "-h" and "-create", remembering that always after "-create"
/// 
/// "dart base_archive_name.dart -create "
///

  static init(List<String> args){
    if(args.first == "-create"){
      CreateFiles.meet();
    }
    if(args.first == "-h"){
      CreateFiles.help();
    }
  }
}