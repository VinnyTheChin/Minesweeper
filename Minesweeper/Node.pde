//
//  Node.pde
//  Minesweeper
//
//  Created by David Moore on 4/26/18.
//

import java.util.List;
import java.util.Map;
import java.util.UUID;

public class Node {
	// MARK - Instance Variables

	/// A rectangle in the parent’s coordinate system that contains the node’s content, ignoring the node’s children.
	private Rect _frame;

	/// The height of the node relative to its parent.
	private float _zPosition;

	/// A scaling factor that multiplies the width of a node and its children.
	private float _xScale;

	/// A scaling factor that multiplies the height of a node and its children.
	private float _yScale;

	/// The transparency value applied to the node’s contents.
	private float _alpha;

	/// A Boolean value that determines whether a node and its descendants are rendered.
	private boolean _isHidden;

	/// The node’s children.
	private ArrayList<Node> _children;

	/// Collection of the children that are to be removed when possible.
	private ArrayList<Node> _childrenToRemove;

	/// Collection of the children that are to be added when possible.
	private ArrayList<Node> _childrenToAdd;

	/// The node’s parent node.
	private Node _parent;

	/// The node’s assignable name.
	private String _name;

	/// Collection of all actions for the node.
	private Map<String, Action> _actionsByName;

	/// Collection of the start times of all actions.
	private Map<String, Float> _actionStartTimesByName;

	/// A speed modifier applied to all actions executed by a node and its descendants.
	private float _speed;

	/// A Boolean value that determines whether actions on the node and its descendants are processed.
	private boolean _isPaused;

	/// Marks the last time the receiver's 'update:' method was called, in milliseconds.
	private int _lastUpdateTime;

	// MARK: - Properties

	/// A rectangle in the parent’s coordinate system that contains the node’s content, ignoring the node’s children.
	public Rect frame() { return _frame; }

	/// Setter for frame.
	public void setFrame(Rect frame) { _frame = frame; }

	/// The position of the node in its parent's coordinate system.
	public Point position() { return _frame.origin; }

	/// Setter for position.
	public void setPosition(Point position) { _frame.origin = position; }

	/// The height of the node relative to its parent.
	public float zPosition() { return _zPosition; }

	/// The height of the node relative to its parent.
	public void setZPosition(float zPosition) { _zPosition = zPosition; }

	/// A scaling factor that multiplies the width of a node and its children.
	public float xScale() { return _xScale; }

	/// A scaling factor that multiplies the height of a node and its children.
	public float yScale() { return _yScale; }

	/// Sets the xScale and yScale properties of the node.
	public void setScale(float xScale, float yScale) {
		_xScale = xScale;
		_yScale = yScale;
	}

	/// The transparency value applied to the node’s contents.
	public float alpha() { return _alpha; }

	/// Sets the alpha value.
	public void setAlpha(float alpha) { _alpha = alpha; }

	/// A Boolean value that determines whether a node and its descendants are rendered.
	public boolean isHidden() { return _isHidden; }

	/// Sets isHidden.
	public void setIsHidden(boolean isHidden) { _isHidden = isHidden; }

	/// The node’s children. Mutation of this array should be avoided.
	public ArrayList<Node> children() { return _children; }

	/// The node’s parent node.
	public Node parent() { return _parent; }

	/// The scene node that contains the node.
	public Scene scene() {
		if (parent() instanceof Scene) {
			return (Scene)(parent());
			} else {
				return null;
			}
		}

		/// The node’s assignable name.
		public String name() { return _name; }

		/// Sets the node's assignable name.
		public void setName(String name) { _name = name; }

		/// Returns a Boolean value that indicates whether the node is executing actions.
		public boolean hasActions() { return !_actionsByName.isEmpty(); }

		/// A speed modifier applied to all actions executed by a node and its descendants.
		public float speed() {
			// If there is no parent, then just return speed.
			if (parent() == null) {
				return _speed;
				} else {
					// Since there is a parent, we will compute the speed recursively.
					return parent().speed() * _speed;
				}
			}

			/// Sets the speed modifier applied to all actions executed by a node and its descendants.
			public void setSpeed(float speed) { _speed = speed; }

			/// A Boolean value that determines whether actions on the node and its descendants are processed.
			public boolean isPaused() { return _isPaused; }

			/// Sets the boolean value that determines whether actions on the node and its descendants are processed.
			public void setIsPaused(boolean isPaused) { _isPaused = isPaused; }

			/// The amount of time (ms) that has elapsed from the last update until the current time.
			///
			/// Parameter currentTime: The current time passed to 'update:' in milliseconds.
			public int elapsedTimeSinceLastUpdate(int currentTime) {
				return abs(currentTime - _lastUpdateTime);
			}

			// MARK: - Initialization

			public Node() {
				_frame = new Rect(0, 0, 0, 0);
				_zPosition = 0.0;
				_xScale = 1.0;
				_yScale = 1.0;
				_alpha = 1.0;
				_isHidden = false;
				_children = new ArrayList<Node>();
				_childrenToRemove = new ArrayList<Node>();
				_childrenToAdd = new ArrayList<Node>();
				_name = "";
				_actionsByName = new HashMap<String, Action>();
				_actionStartTimesByName = new HashMap<String, Float>();
				_speed = 1.0;
				_isPaused = false;
				_lastUpdateTime = millis();
			}

			// MARK: - Working with Node Trees

			/// Adds a node to the end of the receiver’s list of child nodes.
			public void addChild(Node node) {
				_childrenToAdd.add(node);
			}

			/// Inserts a child into a specific position in the receiver’s list of child nodes.
			public void insertChildAtIndex(Node node, int index) {
				node._parent = this;
				_children.add(index, node);
			}

			/// Moves the node to a new parent node in the scene.
			public void moveToParent(Node parent) {
				removeFromParent();
				parent.addChild(this);
			}

			/// Removes the receiving node from its parent.
			public void removeFromParent() {
				_parent._childrenToRemove.add(this);
			}

			/// Removes all of the node’s children.
			public void removeAllChildren() {
				// Enumerate the children array and call them to perform the action.
				for (Node child : _children) {
					child.removeFromParent();
				}
			}

			/// Removes a list of children from the receiving node.
			public void removeChildrenInArray(ArrayList<Node> nodes) {
				for (Node child : nodes) {
					// Ensure the child's parent is this node before removing it.
					if (child.parent() == this)
					child.removeFromParent();
				}
			}

			/// Compares the parameter node to the receiving node.
			public boolean isEqualToNode(Node node) {
				return _frame.isEqualToRect(node._frame) && _zPosition == node._zPosition && _xScale == node._xScale && _yScale == node._yScale && _alpha == node._alpha && _isHidden == node._isHidden && _children == node._children && _parent == node._parent && _name == node._name;
			}

			// MARK: - Naming Nodes

			/// Searches the children of the receiving node for a node with a specific name.
			public Node childNodeWithName(String name) {
				// Retrieve the list of all matching children.
				ArrayList<Node> matchingChildren = childNodesWithName(name);

				// Make sure it isn't empty.
				if (matchingChildren.size() > 0) {
					// Return the first match.
					return matchingChildren.get(0);
					} else {
						return null;
					}
				}

				/// Searches the children of the receiving node for nodes with a specific name.
				public ArrayList<Node> childNodesWithName(String name) {
					// Create a new array.
					ArrayList<Node> matchingChildren = new ArrayList<Node>();

					// Enumerate the children array.
					for (Node child : children()) {
						// If the name matches, we've found a match so add it to the array.
						if (child.name() == name) {
							matchingChildren.add(child);
						}
					}

					return matchingChildren;
				}

				// MARK: - Running Actions

				/// Adds an action to the list of actions executed by the node.
				public void runAction(Action action) {
					// Generate a UUID.
					final String uuid = UUID.randomUUID().toString();

					// Run the action under that UUID.
					runActionWithKey(action, uuid);
				}

				/// Adds an identifiable action to the list of actions executed by the node.
				public void runActionWithKey(Action action, String key) {
					_actionsByName.put(key, action);
				}

				/// Returns an action associated with a specific key.
				public Action actionForKey(String key) {
					return _actionsByName.get(key);
				}

				/// Ends and removes all actions from the node.
				public void removeAllActions() {
					_actionsByName.clear();
					_actionStartTimesByName.clear();
				}

				/// Removes an action associated with a specific key.
				public void removeActionForKey(String key) {
					_actionsByName.remove(key);
					_actionStartTimesByName.remove(key);
				}

				// MARK: - Interaction

				/// Called when a mouse clicks down at a specific point.
				public void mouseDownAtPoint(Point point) {}

				/// Called when a mouse moves to a particular point.
				public void mouseMovedAtPoint(Point point) {}

				/// Called when a mouse click lifts up at a point.
				public void mouseUpAtPoint(Point point) {}

				/// Informs the receiver that the user has pressed a key.
				public void keyDownWithEvent(KeyEvent event) {}

				/// Informs the receiver that the user has released a key.
				public void keyUpWithEvent(KeyEvent event) {}

				// MARK: - Drawing

				/// Performs any node-specific updates that need to occur before actions are evaluated.
				///
				/// - Parameter currentTime: The time since starting the program in milliseconds.
				public void update(int currentTime) {
					// Remove all children that are designated as to remove.
					for (Node childToRemove : _childrenToRemove) {
						// Nullfy the relationship.
						childToRemove._parent = null;
						_children.remove(childToRemove);
					}

					// Clear the children to remove array, since we just removed them all.
					_childrenToRemove.clear();

					// Remove all children that are designated as to remove.
					for (Node childToAdd : _childrenToAdd) {
						// Create a relationship.
						childToAdd._parent = this;
						_children.add(childToAdd);
					}

					// Clear the children to add array, since we just added them all.
					_childrenToAdd.clear();

					// Call 'update:' on every child node.
					for (Node child : children()) {
						child.update(currentTime);
					}

					// Define an array to store keys that must be removed from '_actionByName'.
					ArrayList<String> keysToRemove = new ArrayList<String>();

					// Perform the actions.
					for (String key : _actionsByName.keySet()) {
						// Retrieve the action for the key.
						Action action = _actionsByName.get(key);

						// The start time should be equal to the first update of the action.
						if (!_actionStartTimesByName.containsKey(key)) {
							_actionStartTimesByName.put(key, new Float(millis()));
						}

						// Retrieve the time the action started.
						float startTime = _actionStartTimesByName.get(key).floatValue();

						// If the start time in addition to the duration is greater than the current time, the action should be complete. Also make sure the action has a finite duration.
						if (!action.isRepeating() && startTime + action.duration() <= (float)millis()) {
							// Add the key to an array so we can remove it later, as the key-value pair cannot be removed while iterating the dictionary.
							keysToRemove.add(key);

							// Notify the action that it's done.
							action.completeWithNode(this);

							continue;
						}

						// Perform the action.
						action.performWithNode(this, (int)startTime, currentTime);
					}

					// Enumerate the array to remove any key-value pairs that are complete.
					for (String key : keysToRemove) {
						_actionStartTimesByName.remove(key);
						_actionsByName.remove(key);
					}

					// Update the last update time, since we're done the update.
					_lastUpdateTime = currentTime;
				}

				/// Performs any drawing operations the node might need to occur; called after actions have been evaluated.
				///
				/// Parameter currentTime: Time since starting the program in milliseconds.
				public void draw(int currentTime) {
					// Call 'draw:' on every child.
					for (Node child : children()) {
						child.draw(currentTime);
					}
				}
			}
