#define CATCH_CONFIG_MAIN
#include <catch2/catch.hpp>

TEST_CASE("Addition works correctly", "[math]") {
    REQUIRE(1 + 1 == 2);
    REQUIRE(2 + 2 == 4);
    REQUIRE(0 + 0 == 0);
}

TEST_CASE("Subtraction works correctly", "[math]") {
    REQUIRE(5 - 3 == 2);
    REQUIRE(10 - 7 == 3);
    REQUIRE(0 - 0 == 0);
}

TEST_CASE("Multiplication works correctly", "[math]") {
    REQUIRE(3 * 3 == 9);
    REQUIRE(0 * 5 == 0);
    REQUIRE(7 * 1 == 7);
}

TEST_CASE("Division works correctly", "[math]") {
    REQUIRE(10 / 2 == 5);
    REQUIRE(9 / 3 == 3);
    REQUIRE_THROWS_AS(10 / 0, std::logic_error); // Division by zero should throw
}

TEST_CASE("Strings are compared correctly", "[string]") {
    REQUIRE(std::string("hello") == "hello");
    REQUIRE(std::string("test") != "TEST");
    REQUIRE(std::string("Catch2").find("Catch") == 0);
}

TEST_CASE("Vectors are handled correctly", "[vector]") {
    std::vector<int> v = {1, 2, 3};
    REQUIRE(v.size() == 3);
    REQUIRE(v[0] == 1);
    REQU
