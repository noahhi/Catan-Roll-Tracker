public class Player {
  String name;
  int[] numCounts;
  int[] blockedCounts;
  ArrayList<Settlement> settlements;
  float[] probabilities;

  int totalResourceGain;
  float totalExpectedResourceGain;
  int totalRobbed;

  boolean blocked;
  int numBlocked;

  public Player(String name) {
    this.name = name;
    numCounts = new int[13];
    blockedCounts = new int[13];
    probabilities = new float[13];
    blocked = false;
    numBlocked = -1; 
    settlements = new ArrayList<Settlement>();

    // odds of rolling each number on 2 dice
    probabilities[0] = 0;
    probabilities[1] = 0;
    probabilities[2] = 1.0/36;
    probabilities[3] = 2.0/36;
    probabilities[4] = 3.0/36;
    probabilities[5] = 4.0/36;
    probabilities[6] = 5.0/36;
    probabilities[7] = 6.0/36;
    probabilities[8] = 5.0/36;
    probabilities[9] = 4.0/36;
    probabilities[10] = 3.0/36;
    probabilities[11] = 2.0/36;
    probabilities[12] = 1.0/36;
  }

  // unblock everything except the specified settlement. (issues when there are identical tiles)
  void unblockExcept(int tile, String resource) {
    int i = 0;
    while (i < settlements.size()) {
      Settlement settlement = settlements.get(i);
      if (settlement.getTileNumber() == tile) {
        if (settlement.getType() == resource) {
          i++;
          continue;
        }
      }
      if (settlement.blocked()) {
        blocked = false;
        blockedCounts[settlement.getTileNumber()] -= 1;
        settlement.unblock();
      }
      i++;
    }
  }

  void unblockSettlement(int tile, String resource) {
    int i = 0;
    while (i < settlements.size()) {
      Settlement settlement = settlements.get(i);
      if (settlement.getTileNumber() == tile) {
        if (settlement.getType() == resource) {
          if (settlement.blocked()) {
            settlement.unblock();
            blockedCounts[settlement.getTileNumber()] -= 1;
            blocked = false;
            break;
          } else {
            System.out.println("not blocked");
          }
        }
      } 
      i++;
    }
  }

  void blockSettlement(int tile, String resource) {
    int i = 0;
    while (i < settlements.size()) {
      Settlement settlement = settlements.get(i);
      if (settlement.getTileNumber() == tile) {
        if (settlement.getType() == resource) {
          if (settlement.blocked()) {
            System.out.println("already blocked");
          } else {
            settlement.block();
            blockedCounts[settlement.getTileNumber()] += 1;
            blocked = true;
            numBlocked = settlement.getTileNumber();
            break;
          }
        }
      } 
      i++;
    }
  }

  float getExpectedTotal() {
    return totalExpectedResourceGain;
  }

  int getActualTotal() {
    return totalResourceGain;
  }

  int getTotalRobbed() {
    return totalRobbed;
  }

  String getName() {
    return name;
  }

  void addSettlement(Settlement settlement) {
    int num = settlement.getTileNumber();
    numCounts[num] += 1;
    settlements.add(settlement);
  }

  float calculateExpectedResourceGain() {
    float totalExpected = 0;
    for (int i = 2; i<=12; i++) {
      int count = numCounts[i] - blockedCounts[i];
      float probability = probabilities[i];
      float expected = count * probability;
      totalExpected += expected;
    }
    totalExpectedResourceGain += totalExpected;
    return totalExpected;
  }

  float actualResourceGain(int roll) {
    int robbed = blockedCounts[roll];
    System.out.println(robbed);
    totalRobbed += robbed;
    int gained = numCounts[roll] - robbed;
    totalResourceGain += gained;
    return gained;
  }

  float calcLuck() {
    float luck = totalResourceGain - totalExpectedResourceGain;
    System.out.println("Player: " + name);
    System.out.println("total expected : " + totalExpectedResourceGain);
    System.out.println("actual : " + totalResourceGain);
    System.out.println("");
    return luck;
  }
}
