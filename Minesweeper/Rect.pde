//
//  Rect.pde
//  Minesweeper
//
//  Created by David Moore on 4/26/18.
//

public class Rect {

	// MARK: - Properties

	/// The rectangle origin.
	public Point origin;

	/// The size of the rectangle.
	public Size size;

	/// The x-coordinate of the point.
	public float x() { return origin.x; }

	/// The y-coordinate of the point.
	public float y() { return origin.y; }

	/// A width value.
	public float width() { return size.width; }

	/// A height value.
	public float height() { return size.height; }

	// MARK: - Initialization

	/// Creates a new rectangle from an origin and size.
	public Rect(Point origin, Size size) {
		this.origin = origin;
		this.size = size;
	}

	/// Creates a new rectangle with an origin (x, y) and a size (width, height).
	public Rect(float x, float y, float width, float height) {
		this.origin = new Point(x, y);
		this.size = new Size(width, height);
	}

	// MARK: - Checking Characteristics

	/// Returns whether two rectangles intersect.
	public boolean intersectsRect(Rect rect) {
		if (rect.origin.x < origin.x + size.width && origin.x < rect.origin.x + rect.size.width && rect.origin.y < origin.y + size.height) {
			return origin.y < rect.origin.y + rect.size.height;
			} else {
				return false;
			}
		}

		/// Returns whether a rectangle contains a specified point.
		public boolean containsPoint(Point point) {
			return point.x > origin.x && point.x < origin.x + size.width && point.y > origin.y && point.y < origin.y + size.height;
		}

		/// Returns whether the first rectangle contains the second rectangle.
		public boolean containsRect(Rect rect) {
			if (containsPoint(rect.origin)) {
				float dx = rect.origin.x - origin.x;
				float dy = rect.origin.y - origin.y;
				return size.width > rect.size.width + dx && size.height > rect.size.height + dy;
				} else {
					return false;
				}
			}

			/// Returns whether a rectangle has zero width or height, or is a null rectangle.
			public boolean isEmpty() {
				return origin.isEqualToPoint(new Point(0, 0)) && size.isEqualToSize(new Size(0, 0));
			}

			// MARK: - Comparing Rectangles

			/// Returns whether two rectangles are equal in size and position.
			public boolean isEqualToRect(Rect rect) {
				return origin == rect.origin && size == rect.size;
			}
		}
