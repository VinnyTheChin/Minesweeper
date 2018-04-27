//
//  Action.pde
//  Minesweeper
//
//  Created by David Moore on 4/26/18.
//

public interface ActionDelegate {
	public void actionDidFinishWithNode(Action action, Node node);
}

public class Action {

	// MARK: - Instance Variables

	/// Duration of the action in milliseconds.
	private float _duration;

	/// Delegate for the receiver; used to report status.
	private ActionDelegate _delegate;

	/// Vector to move by.
	private Vector movementVector;

	/// Target location to move towards.
	private Point location;

	/// Array of all actions that must be performed.
	private List<Action> actionsToPerform;

	// MARK: - Properties

	/// Duration of the action in milliseconds.
	public float duration() { return abs(_duration); }

	/// Sets the duration of the action in milliseconds.
	public void setDuration(int duration) { _duration = (float)duration; }

	/// Sets the duration of the action in milliseconds.
	public void setDuration(float duration) { _duration = duration; }

	/// Boolean value indicating if the action repeats forever.
	public boolean isRepeating() { return _duration < 0.0; }

	/// Completion handler for the receiver; called when the action completes.
	public ActionDelegate delegate() { return _delegate; }

	/// Sets the ompletion handler for the receiver which called when the action completes.
	public void setDelegate(ActionDelegate delegate) { _delegate = delegate; }

	// public Point finalLocation() { return _finalLocation; }

	// MARK: - Initialization

	public Action(int duration) {
		setDuration(duration);
		movementVector = null;
		location = null;
	}

	// MARK: - Helper Methods

	/// Returns a new value that applies the slope between the value and duration.
	private float changeForValueWithNode(float value, Node node, int currentTime) {
		// Retrieve the elapsed time since the last update.
		int elapsedTime = node.elapsedTimeSinceLastUpdate(currentTime);
		return (value / duration()) * elapsedTime * node.speed();
	}

	// MARK: - Node Action

	/// Performs the action on a specific node, given the start time in milliseconds and the current time in milliseconds.
	public void performWithNode(Node node, int startTime, int currentTime) {
		// Retrieve the elapsed time since the last update.
		int elapsedTime = node.elapsedTimeSinceLastUpdate(currentTime);

		// Evaluate the actions to perform if the array is non-null.
		if (actionsToPerform != null && actionsToPerform.size() > 0) {
			// Calculate the current duration value.
			int currentDuration = abs(currentTime - startTime);

			// Enumerate the actions to perform.
			for (Action action : actionsToPerform) {
				// Adjust the current duration.
				currentDuration -= action.duration();

				// If the current duration is negative it is given that the action still has time left.
				if (currentDuration < 0) {
					// Perform it.
					action.performWithNode(node, startTime, currentTime);
					break;
					} else {
						// Move onto the next action case.
						continue;
					}
				}
			}

			// Apply the movement vector.
			if (movementVector != null) {
				node.frame().origin.x += changeForValueWithNode(movementVector.dx, node, currentTime);
				node.frame().origin.y += changeForValueWithNode(movementVector.dy, node, currentTime);
			}

			// Move towards the location.
			if (location != null) {
				// Calculate the change in x and y for the entire duration.
				float dx = location.x - node.frame().x();
				float dy = location.x - node.frame().y();

				// Print out a no-implementation error.
				println("location movement is not yet implemented");
			}
		}

		/// Called when the action has finished.
		public void completeWithNode(Node node) {
			if (delegate() != null) {
				// Call the handler.
				delegate().actionDidFinishWithNode(this, node);
			}
		}
	}

	/// Creates an action that move by a particular vector.
	public Action ActionMoveByVectorWithDuration(Vector movementVector, int duration) {
		// Create the action.
		Action action = new Action(duration);
		action.movementVector = movementVector;

		return action;
	}

	/// Creates an action that runs a given collection of actions.
	public Action ActionWithActions(List<Action> actions) {
		// Calculate the total duration by adding each of the actions durations.
		int totalDuration = 0;
		for (Action action : actions) {
			totalDuration += (int)action.duration();
		}

		// Create the action.
		Action action = new Action(totalDuration);
		action.actionsToPerform = actions;

		return action;
	}

	/// Creates an action that repeats a given collection of actions.
	/* public Action ActionRepeatingAction(Action action) {
	Action repeatingAction = new A
	} */

	/// Creates an action that moves a node to a new position.
	///
	/// - Parameter location: The coordinates for the node’s new position.
	/// - Parameter duration: The duration of the animation in milliseconds.
	public Action ActionMoveToLocationWithDuration(Point location, int duration) {
		Action action = new Action(duration);
		action.location = location;

		return action;
	}
