import 'package:image_picker/image_picker.dart';


class Upload{

  //store image in database


  Future  uploadpic(ImageSource source)async {
    final ImagePicker _imagepicker= ImagePicker();
    XFile? file=await _imagepicker.pickImage(source: source);

    if(file != null){
      return  file.readAsBytes();

    }else{

    }
  }


}
