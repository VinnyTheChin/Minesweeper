//
//  Minesweeper.pde
//  Minesweeper
//
//  Created by David Moore on 4/26/18.
//

import java.util.Collections;
import java.util.Comparator;

public static String kScoreDataFilePath = "Data/Scores.json";
public static String kCoderScoresArray = "scores";

// Create a new scene.
MainScene scene = new MainScene(new Rect(0, 0, 600, 700));

// Declare a boolean value representing if the
boolean isPaused = true;

// Boolean value indicating if the scene is displaying high scores.
boolean isDisplayingHighScores = false;

// Boolean value indicating if the scene should be reset.
boolean shouldResetScene = false;

// Declare a high scores array.
ArrayList<Score> highScores;

void settings() {
	// Configure the size.
	size((int)(scene.frame().width() + 0.5), (int)(scene.frame().height() + 0.5));
}

void setup() {
	// Set the frame rate.
	frameRate(60);

	// Notify the scene that it has been loaded.
	scene.sceneDidLoad();

  // Decode the high scores.
  Coder aCoder = new Coder(kScoreDataFilePath);
  highScores = aCoder.decodeArrayForKey(kCoderScoresArray);
}

/// Sorts the high scores from high to low values.
void sortHighScores() {
  // Use the Collections static sort method with a custom Comparator.
  Collections.sort(highScores, new Comparator<Score>() {
    public int compare(Score lhs, Score rhs) {
        // The values produced are the following: '<' -> -1, '>' -> 1, '==' -> 0.
        return lhs.value() > rhs.value() ? -1 : (lhs.value() < rhs.value()) ? 1 : 0;
    }
  });
}

/// Saves the high scores.
void saveHighScores() {
  // Create a new Coder.
  Coder aCoder = new Coder();

  // Encode the array.
  aCoder.encodeArrayForKey(highScores, kCoderScoresArray);

  // Write to the file path.
  aCoder.writeToFilePath(kScoreDataFilePath);
}

void draw() {
	// Retrieve the current time for synchronization.
	int currentTime = millis();

  if (isDisplayingHighScores) {
    // Paint a dark background.
    background(0);

    // Set fill and text size.
    fill(255);
    textSize(20);

    // Print the title.
    text("*** High Scores (Press Tab to Continue) ***", 12, 20);

    // Go through each score and print it.
    for (int i = 0; i < highScores.size(); i++) {
      // Retrieve the particular score.
      Score highScore = highScores.get(i);

      // Draw the player's name and the corresponding score.
      text("Player: " + highScore.name() + " -> " + (int)(highScore.value() + 0.5), 12, (i + 2) * 20);
    }

    return;
  }

  // Do some special things if the scene 'isPaused'.
  if (isPaused) {
    background(100);

    // Use a white fill and print out some stats for the user.
    fill(255);
    textSize(20);
    text("Press Enter to Begin!\n Arrow Keys for Movement and Space Bar For Shooting", 20, height / 2);

    return;
  }

	// Call the scene's update method so it may draw itself.
	scene.update(currentTime);
	scene.didFinishUpdate();
	scene.draw(currentTime);

  // Draw the top stack.
  fill(0);
  rect(0, 0, width, 40);

  // Write in the top stack.
  textSize(16);
  fill(255);
  text("Health: " + (int)((scene.player().health()) + 0.5), 12, 24);
  text("Level: " + (scene.currentLevel()), 120, 24);
  text("Score: " + (int)(scene.score() + 0.5), 200, 24);

  // Kill the game if the player's health is too low.
  if (scene.player().health() <= 0) {
    // Configure these booleans.
    isDisplayingHighScores = true;
    shouldResetScene = true;
    isPaused = true;

    // Add the user's score to the array.
    highScores.add(new Score("Player " + highScores.size() + 1, scene.score()));

    // Call for the scores to be sorted.
    sortHighScores();

    // Save the scores.
    saveHighScores();
  }
}

void keyPressed() {
  // Check if the high scores are being displayed, and use the TAB key to get rid of them.
  if (isDisplayingHighScores && keyCode == TAB) {
    // Stop displaying them.
    isDisplayingHighScores = false;
  }

  // Un-pause the scene if the keyCode is
  if (isPaused && keyCode == ENTER) {
    // Continue if the scene should be reset.
    if (!shouldResetScene) {
      isPaused = false;
      return;
    }

    // Create a new scene.
    scene = new MainScene(new Rect(0, 0, 600, 700));

    // Notify the scene that it has been loaded.
    scene.sceneDidLoad();

    // Un-pause the scene.
    isPaused = false;
  }

  if (isPaused)
    return;

	// Call the scene's key down event.
	scene.keyDownWithEvent(new KeyEvent());
}

void keyReleased() {
	// Call the scene's key up event.
	scene.keyUpWithEvent(new KeyEvent());
}
