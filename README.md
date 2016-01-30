# String Transforms D

Basic inflection and pluralization libarary for D

Currently includes only English for pluralization but is enough of a framework to add other languages easily enough.

## Case Example

```D
import transforms.camel;
import transforms.snake;

auto camel = "get_http_response_code".camelCase;
assert (camel == "getHttpResponseCode");

auto snake = camel.snakeCase;
assert (snake == "get_http_response_code");

```

## Pluralization Example

```D
import inflections.en;

assert("apple".pluralize == "apples");
assert("apples".singularize == "apple");

```