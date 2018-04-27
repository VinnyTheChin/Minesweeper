//
//  Scene.pde
//  Minesweeper
//
//  Created by David Moore on 4/26/18.
//

public class Scene extends Node {
	// MARK: - Instance Variables

	/// The point in the view’s frame that corresponds to the scene’s origin.
	private Point _anchorPoint;

	/// The background color of the scene.
	private color _backgroundColor;

	// MARK: - Properties

	/// The point in the view’s frame that corresponds to the scene’s origin.
	public Point anchorPoint() { return _anchorPoint; }

	/// Sets the point in the view’s frame that corresponds to the scene’s origin.
	public void setAnchorPoint(Point anchorPoint) { _anchorPoint = anchorPoint; }

	/// The background color of the scene.
	public color backgroundColor() { return _backgroundColor; }

	/// Sets the background color of the scene.
	public void setBackgroundColor(color backgroundColor) { _backgroundColor = backgroundColor; }

	public void setFrame(Rect frame) {
		super.setFrame(frame);
		didChangeFrame(frame);
	}

	// MARK: - Initialization

	/// Creates a new Scene with the provided frame.
	public Scene(Rect frame) {
		super();

		// Configure some important properties.
		setFrame(frame);

		// Default the
		setBackgroundColor(255);
	}

	// MARK: - Prototype Methods

	/// Called whenever the scene’s frame changes.
	public void didChangeFrame(Rect frame) {}

	/// Called immediately after the scene has been initialized.
	public void sceneDidLoad() {}

	/// Performs any scene-specific updates that need to occur before scene actions are evaluated.
	///
	/// - Parameter currentTime: The time since starting the program in milliseconds.
	public void update(int currentTime) {
		super.update(currentTime);
	}

	/// Called after the scene has finished all of the steps required to process animations.
	public void didFinishUpdate() {}

	/// Performs any drawing operations the node might need to occur; called after actions have been evaluated.
	///
	/// Parameter currentTime: Time since starting the program in milliseconds.
	public void draw(int currentTime) {
		// Draw the background with the provided color.
		background(backgroundColor());

		super.draw(currentTime);
	}
}
