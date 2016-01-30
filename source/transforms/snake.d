/**
	* snake_case transform
	*
	* Copyright: © 2016 David Monagle
	* License: Subject to the terms of the MIT license, as written in the included LICENSE.txt file.
	* Authors: David Monagle
*/
module transforms.snake;

import std.uni;
import std.algorithm;
import std.regex;

/// Transforms the given `input` into snake_case
/// This precomiled regex version does not work at compile time as regex uses malloc
string snakeCase(const string input) {
	static auto firstCapRE = ctRegex!(`(.)([A-Z][a-z]+)`);
	static auto allCapRE = ctRegex!(`([a-z0-9])([A-Z])`, "g");
	
	string output = input.replace(firstCapRE, `$1_$2`);
	output = output.replace(allCapRE, `$1_$2`);
	
	return output.toLower;
}

unittest {
	assert("C".snakeCase == "c");
	assert("cA".snakeCase == "c_a");
	assert("Ca".snakeCase == "ca");
	assert("Camel".snakeCase == "camel");
	assert("CamelCase".snakeCase == "camel_case");
	assert("CamelCamelCase".snakeCase == "camel_camel_case");
	assert("Camel2Camel2Case".snakeCase == "camel2_camel2_case");
	assert("getHTTPResponseCode".snakeCase == "get_http_response_code");
	assert("getHttpResponseCode".snakeCase == "get_http_response_code");
	assert("get2HTTPResponseCode".snakeCase == "get2_http_response_code");
	assert("HTTPResponseCode".snakeCase == "http_response_code");
	assert("HTTPResponseCodeXYZ".snakeCase == "http_response_code_xyz");
}

/// Transforms the given `input` into snake_case
/// Works at compile time
string snakeCaseCT(const string input) {
	string firstPass(const string input) {
		if (input.length < 3) return input;
		
		string output;
		for(auto index = 2; index < input.length; index++) {
			output ~= input[index - 2];
			if (input[index - 1].isUpper && input[index].isLower)
				output ~= "_";
		}
		
		return output ~ input[$-2..$];
	}
	
	string secondPass(const string input) {
		if (input.length < 2) return input;
		
		string output;
		for(auto index = 1; index < input.length; index++) {
			output ~= input[index - 1];
			if (input[index].isUpper && (input[index-1].isLower || input[index-1].isNumber))
				output ~= "_";
		}
		
		return output ~ input[$-1..$];
	}
	
	if (input.length < 2) return input.toLower;
	
	string output = firstPass(input);
	output = secondPass(output);
	
	return output.toLower;
}


unittest {
	assert("C".snakeCaseCT == "c");
	assert("cA".snakeCaseCT == "c_a");
	assert("Ca".snakeCaseCT == "ca");
	assert("Camel".snakeCaseCT == "camel");
	assert("CamelCase".snakeCaseCT == "camel_case");
	assert("CamelCamelCase".snakeCaseCT == "camel_camel_case");
	assert("Camel2Camel2Case".snakeCaseCT == "camel2_camel2_case");
	assert("getHTTPResponseCode".snakeCaseCT == "get_http_response_code");
	assert("get2HTTPResponseCode".snakeCaseCT == "get2_http_response_code");
	assert("HTTPResponseCode".snakeCaseCT == "http_response_code");
	assert("HTTPResponseCodeXYZ".snakeCaseCT == "http_response_code_xyz");
}
