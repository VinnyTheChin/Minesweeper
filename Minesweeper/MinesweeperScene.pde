//
//  MinesweeperScene.pde
//  Minesweeper
//
//  Created by David Moore on 4/26/18.
//

public class MinesweeperScene extends Scene {
	
	// MARK: - Instance Variables

	// MARK: - Properties

	// MARK: - Initialization

	public MinesweeperScene(Rect frame) {
		super(frame);
	}

	// MARK: - Lifecycle

	/// Called immediately after the scene has been initialized.
	public void sceneDidLoad() {
		super.sceneDidLoad();
	}

	/// Performs any scene-specific updates that need to occur before scene actions are evaluated.
	///
	/// - Parameter currentTime: The time since starting the program in milliseconds.
	public void update(int currentTime) {
		super.update(currentTime);
	}

	// MARK: - User Interaction

	/// Informs the receiver that the user has pressed a key.
	public void keyDownWithEvent(KeyEvent event) {
		super.keyDownWithEvent(event);
	}

	/// Informs the receiver that the user has released a key.
	public void keyUpWithEvent(KeyEvent event) {
		super.keyUpWithEvent(event);
	}
}
