/**
	*  cameCase transform
	*
	* Copyright: © 2016 David Monagle
	* License: Subject to the terms of the MIT license, as written in the included LICENSE.txt file.
	* Authors: David Monagle
*/
module transforms.camel;

import std.uni;
import std.algorithm;


/// Returns the camelcased version of the input string. 
/// The `upper` parameter specifies whether to uppercase the first character
string camelCase(const string input, bool upper = false, dchar[] separaters = ['_']) {
	string output;
	bool upcaseNext = upper;
	foreach(c; input) {
		if (!separaters.canFind(c)) {
			if (upcaseNext) {
				output ~= c.toUpper;
				upcaseNext = false;
			}
			else
				output ~= c.toLower;
		}
		else {
			upcaseNext = true;
		}
	}
	
	return output;
}

string camelCaseUpper(const string input) {
	return camelCase(input, true);
}

string camelCaseLower(const string input) {
	return camelCase(input, false);
}

unittest {
	assert("c".camelCase == "c");
	assert("c".camelCase(true) == "C");
	assert("c_a".camelCase == "cA");
	assert("ca".camelCase(true) == "Ca");
	assert("camel".camelCase(true) == "Camel");
	assert("Camel".camelCase(false) == "camel");
	assert("camel_case".camelCase(true) == "CamelCase");
	assert("camel_camel_case".camelCase(true) == "CamelCamelCase");
	assert("caMel_caMel_caSe".camelCase(true) == "CamelCamelCase");
	assert("camel2_camel2_case".camelCase(true) == "Camel2Camel2Case");
	assert("get_http_response_code".camelCase == "getHttpResponseCode");
	assert("get2_http_response_code".camelCase == "get2HttpResponseCode");
	assert("http_response_code".camelCase(true) == "HttpResponseCode");
	assert("http_response_code_xyz".camelCase(true) == "HttpResponseCodeXyz");
}
