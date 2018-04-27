//
//  Minesweeper.pde
//  Minesweeper
//
//  Created by David Moore on 4/26/18.
//

// Create a new scene.
MinesweeperScene scene = new MinesweeperScene(new Rect(0, 0, 600, 400));

void settings() {
	// Configure the size.
	size((int)(scene.frame().width() + 0.5), (int)(scene.frame().height() + 0.5));
}

void setup() {
	// Set the frame rate.
	frameRate(60);

	// Notify the scene that it has been loaded.
	scene.sceneDidLoad();
}

void draw() {
	// Retrieve the current time for synchronization.
	int currentTime = millis();

	// Call the scene's update method so it may draw itself.
	scene.update(currentTime);
	scene.didFinishUpdate();
	scene.draw(currentTime);
}

void keyPressed() {
	// Call the scene's key down event.
	scene.keyDownWithEvent(new KeyEvent());
}

void keyReleased() {
	// Call the scene's key up event.
	scene.keyUpWithEvent(new KeyEvent());
}
