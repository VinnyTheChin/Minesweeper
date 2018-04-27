//
//  Point.pde
//  1984
//
//  Created by David Moore on 3/18/18.
//

public class Point {
	// MARK: - Properties

	/// The x-coordinate of the point.
	public float x;

	/// The y-coordinate of the point.
	public float y;

	// MARK: - Initialization.

	/// Instantiates a new point with `x` and `y` values.
	public Point(float x, float y) {
		this.x = x;
		this.y = y;
	}

	// MARK: - Comparing Points

	/// Returns whether two points are equal.
	public boolean isEqualToPoint(Point point) {
		return x == point.x && y == point.y;
	}
}
