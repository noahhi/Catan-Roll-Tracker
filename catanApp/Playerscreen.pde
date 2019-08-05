class Playerscreen extends Screen{
  Button openKeyboardButton;
  Button doneButton;
  String name;
  
  Playerscreen(){
    openKeyboardButton = new Button(width/2, (height/8)*2, 250, 60, "player 1");
    doneButton = new Button(width/2, (height/8)*3, 250, 60, "Done");
    name = "player 1";
  }

  void updateName(String newName){
    name = newName;
  }

  String getName(){
    return name;
  }
  
  void show(){
    openKeyboardButton.display();
    text("Name:", width/2, (height/8)*1);
    //text(name, width/2, (height/8)*4);
    doneButton.display();
  }
  
  Button getDoneButton(){
    return doneButton;
  }

  Button getOpenKeyboardButton(){
    return openKeyboardButton;
  }
}
