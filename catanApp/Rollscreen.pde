public class Rollscreen extends Screen {
  Button[] rollButtons;
  Button homeButton;
  Button chooseRollButton;
  PImage catanBoard;

  int buttonX;
  int buttonWidth;
  int buttonHeight;

  boolean rollSelected;
  Button selectedRoll;

  Rollscreen() {
    catanBoard = loadImage("backgroundIMG2.jpg");
    rollSelected = false;
    if (PHONE) {
      buttonWidth = 100*2;
    } else {
      buttonWidth = 100;
    }
    buttonHeight = height/15;
    buttonX = width/4;
    homeButton = new Button(width/6, height/13, 90, 60, "Back");
    rollButtons = new Button[11];
    for (int i=0; i<rollButtons.length; i++) {
      rollButtons[i] = new Button(buttonX, (buttonHeight*i)+i+(buttonHeight*3), buttonWidth, buttonHeight, Integer.toString(i+2)+": (0)", false);
    }
    chooseRollButton = new Button((width/6)*4, height/13, 190, 60, "Choose Roll");
  }

  void reset() {
    for (Button button : rollButtons) {
      button.updatePrompt(button.getVal()+": (0)");
    }
  }

  void show() {
    if (!active) {
      System.out.println("trying to show rollscreen but not active");
    }

    //image(catanBoard, 0, 0, width, height);

    if (rollSelected) {
      chooseRollButton.display();
    }

    homeButton.display();
    for (Button button : rollButtons) {
      button.display();
    }
  }

  void selectRoll(Button button) {
    if (button == null) {
      selectedRoll = null;
      rollSelected = false;
      for (Button butt : rollButtons) {
        butt.unhighlight();
      }
    } else {
      selectedRoll = button;
      rollSelected = true;
    }
  }

  Button getSelectedRoll() {
    return selectedRoll;
  }

  boolean rollChoosen() {
    return rollSelected;
  }
  
  void showLiveDistribution(Game game) {
    int[] counts = game.getCounts();
    float max = 0;
    for (int count : counts) {
      if (count > max){
        max = count;
      }
    }
    int num = 0;
    for (int count : counts) {
      rectMode(CORNER);
      rect(buttonX+(buttonWidth/2), (buttonHeight*num)+num+(buttonHeight*3)-(buttonHeight/3), ((width/20)*11)*(count/max), buttonHeight*0.66);
      num += 1;
    }
  }

  void showDistribution(Game game) {
    int[] counts = game.getCounts();
    int num = 0;
    for (int count : counts) {
      rectMode(CORNER);
      rect(buttonX+(buttonWidth/2), (buttonHeight*num)+num+(buttonHeight*3)-(buttonHeight/3), count*30, buttonHeight*0.66);
      num += 1;
    }
  }

  Button[] getButtons() {
    return rollButtons;
  }

  Button getHomeButton() {
    return homeButton;
  }

  Button getChooseRollButton() {
    return chooseRollButton;
  }
}
