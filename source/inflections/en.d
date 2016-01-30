/**
	* English inflections
	*
	* Copyright: © 2016 David Monagle
	* License: Subject to the terms of the MIT license, as written in the included LICENSE.txt file.
	* Authors: David Monagle
*/
module inflections.en;

import inflections.Inflector;

class Inflector_EN : Inflector {
	static this() {
		plural!(`([^aeiouy])y$`, `$1ies`, "i");
		plural!(`([^aeiouy]o)$`, `$1es`, "i");
		plural!(`([sxz]|[cs]h)$`, `$1es`, "i");
		plural!(`(el)f$`, `$1ves`, "i");
		plural!(`$`, `s`);
		
		singular!(`([^aeiouy])ies$`, `$1y`, "i");
		singular!(`([^aeiouy]o)es$`, `$1`, "");
		singular!(`([sxz]|[cs]h)es$`, `$1`, "");
		singular!(`(el)ves$`, `$1f`, "i");
		singular!(`(ss)$`, `$1`, "i");
		singular!(`s$`, ``, "i");
		
		irregular("person", "people");
		irregular("child", "children");
		
		uncountable("series");
	}
}

unittest {
	void inflectorTest(string singular, string plural = "") {
		if (!plural.length) plural = singular;
		
		auto p = Inflector_EN.pluralize(singular);
		assert(p == plural, "Pluralization of '" ~ singular ~ "' yielded '" ~ p ~ "' rather than the expected '" ~ plural ~ "'");
		
		auto s = Inflector_EN.singularize(plural);
		assert(s == singular, "Singularization of '" ~ plural ~ "' yielded '" ~ s ~ "' rather than the expected '" ~ singular ~ "'");
	}
	
	inflectorTest("apple", "apples");
	inflectorTest("shelf", "shelves");
	inflectorTest("dress", "dresses");
	
	// Irregulars
	inflectorTest("person", "people");
	
	// Uncountable
	inflectorTest("series");
}

string pluralize(const string input) {
	return Inflector_EN.pluralize(input);
}

string singularize(const string input) {
	return Inflector_EN.singularize(input);
}

unittest {
	assert("apple".pluralize == "apples");
	assert("apples".singularize == "apple");
}