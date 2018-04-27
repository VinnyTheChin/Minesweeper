//
//  KeyEvent.pde
//  Minesweeper
//
//  Created by David Moore on 4/26/18.
//

public class KeyEvent {

	// MARK: - Instance Variables

	/// Character associated with the pressed key.
	private char _character;

	/// Code associated with the pressed key.
	private int _code;

	// MARK: - Properties

	/// Character associated with the pressed key.
	public char character() { return _character; }

	/// Sets the character associated with the pressed key.
	public void setCharacter(char character) { _character = character; }

	/// Code associated with the pressed key.
	public int code() { return _code; }

	/// Sets the code associated with the pressed key.
	public void setCode(int code) { _code = code; }

	// MARK: - Initialization

	public KeyEvent() {
		this(key, keyCode);
	}

	public KeyEvent(char character) {
		setCharacter(character);
	}

	public KeyEvent(int code) {
		setCode(code);
	}

	public KeyEvent(char character, int code) {
		setCharacter(character);
		setCode(code);
	}
}
