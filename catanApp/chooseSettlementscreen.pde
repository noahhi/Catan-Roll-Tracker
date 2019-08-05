class ChooseSettlementscreen extends Screen {
  Button[] nums;
  Button[] resourceTypes;
  PImage wood;
  PImage brick;
  PImage sheep;
  PImage wheat;
  PImage ore;
  Button doneButton;

  boolean rollSelected;
  Button selectedNum;
  
  boolean resourceSelected;
  Button selectedResource;

  ChooseSettlementscreen() {
    resourceTypes = new Button[5];

    resourceTypes[0] = new Button((width/6)+2, height/3, width/6, height/6, "wood", false);
    wood = loadImage("wood.jpg");
    resourceTypes[0].addImage(wood);

    resourceTypes[1] = new Button(((width/6)*2)+4, height/3, width/6, height/6, "brick", false);
    brick = loadImage("brick.jpg");
    resourceTypes[1].addImage(brick);

    resourceTypes[2] = new Button(((width/6)*3)+6, height/3, width/6, height/6, "sheep", false);
    sheep = loadImage("sheep.jpg");
    resourceTypes[2].addImage(sheep);

    resourceTypes[3] = new Button(((width/6)*4)+8, height/3, width/6, height/6, "wheat", false);
    wheat = loadImage("wheat.jpg");
    resourceTypes[3].addImage(wheat);

    resourceTypes[4] = new Button(((width/6)*5)+10, height/3, width/6, height/6, "ore", false);
    ore = loadImage("ore.jpg");
    resourceTypes[4].addImage(ore);

    nums = new Button[10];
    int buttonWidth = width/8;
    int buttonHeight = height/12;
    for (int i=0; i<=4; i++) {
      nums[i] = new Button((width/2+((i-2)*buttonWidth)), (height/8)*5, buttonWidth, buttonHeight, Integer.toString(i+2), false);
    }
    for (int i=5; i<=9; i++) {
      nums[i] = new Button(width/2+((i-7)*buttonWidth), ((height/8)*5)+buttonHeight, buttonWidth, buttonHeight, Integer.toString(i+3), false);
    }

    doneButton = new Button(width/2, (height/8)*7, 250, 60, "Add");
  }

  Button[] getNumButtons() {
    return nums;
  }

  Button[] getResourceButtons() {
    return resourceTypes;
  }

  Button getDoneButton() {
    return doneButton;
  }
  void show() {
    text("Select Resource Type", width/2, height/7);
    for (Button button : resourceTypes) {
      button.display();
    }
    text("Select Tile Number", width/2, height/2);
    for (Button button : nums) {
      button.display();
    }
    doneButton.display();
  }

  Button getSelectedNum() {
    return selectedNum;
  }
  
  Button getSelectedResource() {
    return selectedResource;
  }
  
  boolean numSelected(){
    return rollSelected;
  }
  
  boolean resourceSelected(){
    return resourceSelected;
  }

  void selectResource(Button button) {
    if (button == null) {
      selectedResource = null;
      resourceSelected = false;
      for (Button butt : resourceTypes) {
        butt.unhighlight();
      }
    } else {
      selectedResource = button;
      resourceSelected = true;
    }
  }

  void selectRoll(Button button) {
    if (button == null) {
      selectedNum = null;
      rollSelected = false;
      for (Button butt : nums) {
        butt.unhighlight();
      }
    } else {
      selectedNum = button;
      rollSelected = true;
    }
  }
}
