//
//  Size.pde
//  Minesweeper
//
//  Created by David Moore on 4/26/18.
//

public class Size {
	// MARK: - Properties

	/// A width value.
	public float width;

	/// A height value.
	public float height;

	// MARK: - Initialization

	/// Creates a new receiver with the specified `width` and `height`.
	public Size(float width, float height) {
		this.width = width;
		this.height = height;
	}

	// MARK: - Comparing Sizes

	/// Returns whether two sizes are equal.
	public boolean isEqualToSize(Size size) {
		return width == size.width && height == size.height;
	}
}
