ArrayList<Game> games;
Homescreen homescreen;
Rollscreen rollscreen;
Gamescreen gamescreen;
Playerscreen playerscreen;
ChoosePlayerscreen choosePlayerscreen;
ChooseSettlementscreen chooseSettlementscreen;
Statsscreen statsscreen;
boolean keyboard = false;
boolean movingRobber = false;


boolean PHONE = false;

/*
DIFFERENCES BETWEEN COMP & PHONE VERSIONS:
 
 PHONE: set PHONE = true (above)
 COMP:: set PHONE = false (above)
 
 PHONE: call fullscreen() 
 COMP: call size(360,640)
 
 PHONE: uncomment openKeyboard()/closeKeyboard() functions 
 
 */
void setup() {
  //fullScreen();
  size(360, 640); //16*9 aspect ratio
  if (PHONE) {
    textSize(64); //32 for comp, 64 for phone
  } else {
    textSize(32);
  }
  textAlign(CENTER, CENTER);
  homescreen = new Homescreen();
  homescreen.activate();
  rollscreen = new Rollscreen();
  gamescreen = new Gamescreen();
  playerscreen = new Playerscreen();
  choosePlayerscreen = new ChoosePlayerscreen();
  chooseSettlementscreen = new ChooseSettlementscreen();
  statsscreen = new Statsscreen();
  games = new ArrayList<Game>();
}

void draw() {
  background(100, 100, 150);
  if (homescreen.isActive()) {
    homescreen.show();
  } else if (rollscreen.isActive()) {
    rollscreen.show();
    rollscreen.showLiveDistribution(getCurrentGame());
  } else if (gamescreen.isActive()) {
    gamescreen.show();
  } else if (playerscreen.isActive()) {
    playerscreen.show();
  } else if (choosePlayerscreen.isActive()) {
    choosePlayerscreen.show();
  } else if (chooseSettlementscreen.isActive()) {
    chooseSettlementscreen.show();
  } else if (statsscreen.isActive()) {
    statsscreen.show(getCurrentGame());
  }
}

void mousePressed() {
  if (homescreen.isActive()) {
    homescreenPressed();
  } else if (rollscreen.isActive()) {
    rollscreenPressed();
  } else if (gamescreen.isActive()) {
    gamescreenPressed();
  } else if (playerscreen.isActive()) {
    playerscreenPressed();
  } else if (choosePlayerscreen.isActive()) {
    choosePlayerscreenPressed();
  } else if (chooseSettlementscreen.isActive()) {
    chooseSettlementscreenPressed();
  } else if (statsscreen.isActive()) {
    statsscreenPressed();
  }
}

void keyPressed() {
  if (playerscreen.isActive()) {
    String name = playerscreen.getOpenKeyboardButton().getPrompt();
    if (keyCode == BACKSPACE) {
      if (name.length() > 0) {
        name = name.substring(0, name.length()-1);
      }
    } else if (keyCode == DELETE) {
      name = "";
    } else if (keyCode != SHIFT) {
      name = name + key;
    }
    playerscreen.updateName(name);
    playerscreen.getOpenKeyboardButton().updatePrompt(name);
  }
}

void playerscreenPressed() {
  Button openKeyboardButton = playerscreen.getOpenKeyboardButton();
  if (openKeyboardButton.mouseOver()) {
    if (!keyboard) {
      //openKeyboard();
      keyboard = true;
    } else {
      //closeKeyboard();
      keyboard = false;
    }
  }
  Button doneButton = playerscreen.getDoneButton();
  if (doneButton.mouseOver()) {
    String playerName = playerscreen.getName();
    Player newPlayer = new Player(playerName);
    getCurrentGame().addPlayer(newPlayer);
    playerscreen.deactivate();
    gamescreen.activate();
  }
}


void homescreenPressed() {
  Button newGameButton = homescreen.getNewGameButton();
  if (newGameButton.mouseOver()) {
    Game game = new Game();
    games.add(game);
    rollscreen.reset();
    homescreen.deactivate();
    gamescreen.activate();
  } else {
    Button continueGameButton = homescreen.getContinueGameButton();
    if (continueGameButton.mouseOver()) {
      homescreen.deactivate();
      gamescreen.activate();
    }
  }
}

void rollscreenPressed() {
  Button homeButton = rollscreen.getHomeButton();
  if (homeButton.mouseOver()) {
    rollscreen.selectRoll(null);
    rollscreen.deactivate();
    gamescreen.activate();
  } else {
    Button chooseRollButton = rollscreen.getChooseRollButton();
    if (chooseRollButton.mouseOver() && rollscreen.rollChoosen()) {
      Game game = games.get(games.size()-1);
      Button highlighted = rollscreen.getSelectedRoll();
      int roll = highlighted.getVal();
      game.addRoll(roll);
      int newCount = game.getCounts()[highlighted.getVal()-2];
      highlighted.updatePrompt(highlighted.getVal()+": ("+newCount+")");
      highlighted.unhighlight();
      rollscreen.selectRoll(null);
      for (Player player : game.getPlayers()) {
        player.calculateExpectedResourceGain();
        player.actualResourceGain(roll);
        player.calcLuck();
      }
    } else {
      Button[] rollButtons = rollscreen.getButtons();
      for (Button button : rollButtons) {
        if (button.mouseOver()) {
          if (rollscreen.getSelectedRoll() != null) {
            rollscreen.getSelectedRoll().unhighlight();
          }
          button.highlight();
          rollscreen.selectRoll(button);
          break;
        }
      }
    }
  }
}


void gamescreenPressed() {
  Button homeButton = gamescreen.getHomeButton();
  if (homeButton.mouseOver()) {
    gamescreen.deactivate();
    homescreen.activate();
  } else {
    Button addPlayerButton = gamescreen.getAddPlayerButton();
    if (addPlayerButton.mouseOver()) {
      gamescreen.deactivate();
      playerscreen.activate();
    } else {
      Button rollButton = gamescreen.getRollButton();
      if (rollButton.mouseOver()) {
        gamescreen.deactivate();
        rollscreen.activate();
      } else {
        Button settlementButton = gamescreen.getSettlementButton();
        if (settlementButton.mouseOver()) {
          gamescreen.deactivate();
          choosePlayerscreen.activate();
          choosePlayerscreen.update(getCurrentGame());
        } else {
          Button statsButton = gamescreen.getStatsButton();
          if (statsButton.mouseOver()) {
            gamescreen.deactivate();
            statsscreen.activate();
          } else {
            Button robberButton = gamescreen.getMoveRobberButton();
            if (robberButton.mouseOver()) {
              gamescreen.deactivate();
              movingRobber = true;
              choosePlayerscreen.activate();
            }
          }
        }
      }
    }
  }
}



void choosePlayerscreenPressed() {
  Button[] players = choosePlayerscreen.getButtons();
  for (Button button : players) {
    if (button.mouseOver()) {
      String name = button.getPrompt();
      Player selected = getCurrentGame().getPlayer(name);
      choosePlayerscreen.selectPlayer(selected);
      choosePlayerscreen.deactivate();
      chooseSettlementscreen.activate();
      break;
    }
  }
}

void chooseSettlementscreenPressed() {
  Button doneButton = chooseSettlementscreen.getDoneButton();
  if (doneButton.mouseOver() && chooseSettlementscreen.numSelected() && chooseSettlementscreen.resourceSelected()) {
    //unhighlight both buttons and set vals to null.
    Button resourceButton = chooseSettlementscreen.getSelectedResource();
    resourceButton.unhighlight();
    Button numButton = chooseSettlementscreen.getSelectedNum();
    numButton.unhighlight();
    chooseSettlementscreen.selectResource(null);
    chooseSettlementscreen.selectRoll(null);

    Player player = choosePlayerscreen.getSelectedPlayer();
    String resource = resourceButton.getPrompt();
    int num = Integer.parseInt(numButton.getPrompt());

    if (movingRobber) {
      for (Player others : getCurrentGame().getPlayers()) {
        others.unblockExcept(num, resource);
      }
      player.blockSettlement(num, resource);
      movingRobber = false;
    } else {
      //create new settlement object and add to player's settlements
      Settlement newSettlement = new Settlement(resource, num);
      player.addSettlement(newSettlement);
    }

    //deactivate this screen and return to game screen
    chooseSettlementscreen.deactivate();
    gamescreen.activate();
  }

  // handle resource button selection
  Button[] resourceButtons = chooseSettlementscreen.getResourceButtons();
  for (Button button : resourceButtons) {
    if (button.mouseOver()) {
      if (chooseSettlementscreen.getSelectedResource() != null) {
        chooseSettlementscreen.getSelectedResource().unhighlight();
      }
      button.highlight();
      chooseSettlementscreen.selectResource(button);
      break;
    }
  }

  // handle tile number selection
  Button[] numButtons = chooseSettlementscreen.getNumButtons();
  for (Button button : numButtons) {
    if (button.mouseOver()) {
      if (chooseSettlementscreen.getSelectedNum() != null) {
        chooseSettlementscreen.getSelectedNum().unhighlight();
      }
      button.highlight();
      chooseSettlementscreen.selectRoll(button);
      break;
    }
  }
}

void statsscreenPressed() {
  Button homeButton = statsscreen.getHomeButton();
  if (homeButton.mouseOver()) {
    statsscreen.deactivate();
    gamescreen.activate();
  }
}

Game getCurrentGame() {
  return games.get(games.size()-1);
}
