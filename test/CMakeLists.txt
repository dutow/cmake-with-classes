
CMAKE_MINIMUM_REQUIRED(VERSION 3.6)

PROJECT(cmake-with-classes-tests)

ENABLE_TESTING()

MACRO(TESTCASE NAME)
  ADD_TEST(NAME "test_${NAME}" WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}" COMMAND ${CMAKE_COMMAND} -P "test_${NAME}.cmake")
ENDMACRO()


TESTCASE(called_twice)
TESTCASE(instance_name)
TESTCASE(method_argv)
TESTCASE(single_argument)