
# Defines a new class.
# This macro/function should do some sanity checks in the future. For now it's only here for the DSL.
# Example: DEFINE_CLASS(FOO_CLASS)
MACRO(DEFINE_CLASS NAME)
  
ENDMACRO()

# Defines a new method in a class.
# Optional parameters after class and method names specify parameter names.
# Sets the METHOD_NAME variable, which should be passed to the MACRO command to define the method body.
# Note: even thought methods are defined as macros, they behave as functions.
#  * Defining them as function makes changing the parent scope impossible
#  * To "return" values (change variables outside the method), use METHOD_RETURN(variable_name)
# Note: ARGV, ARGN and variables like them won't be usable within the method. Use named parameters and METHOD_ARGV
	# Example: 
#  DEFINE_METHOD(FOO_CLASS, BAR_METHOD, ARG1NAME, ARG2_NAME, ARG3_SOMETHING)
#  MACRO(${METHOD_NAME})
#  ...
#  ENDMACRO()
MACRO(DEFINE_METHOD CLASS_NAME FUNC_NAME)
  LIST(APPEND "${CLASS_NAME}_METHODS" "${FUNC_NAME}")
  SET(METHOD_NAME "${CLASS_NAME}_${FUNC_NAME}")
  SET("${METHOD_NAME}_ARGS" "${ARGN}")
  SET("${METHOD_NAME}_WATCH" 0)
  VARIABLE_WATCH("${METHOD_NAME}_WATCH" "${METHOD_NAME}")
ENDMACRO()

# Marks a variable as the return value of a method.
# Example:
#   SET(var1 "foo")
#   METHOD_RETURN(var1)
MACRO(METHOD_RETURN name)
  SET(${name} "${${name}}" PARENT_SCOPE)
ENDMACRO()

# Internal method: this is what keeps cmake-with-classes together.
MACRO(INT_WIRE_METHOD INST INST_N FUNC_N)
  # Defines the <INSTANCE_NAME>_<METHOD_NAME> function
  # Note: this has to be a function because the macro argument caveats
	  FUNCTION("${INST_N}" ${${FUNC_N}_ARGS})
    SET(INSTANCE_NAME "${INST}")
    FOREACH(ARG_NAME ${${FUNC_N}_ARGS})
      LIST(APPEND METHOD_ARGV ${${ARG_NAME}})
    ENDFOREACH()
    MATH(EXPR "${FUNC_N}_WATCH" "${${FUNC_N}_WATCH}+1")
  ENDFUNCTION()
ENDMACRO()

# Creates a new instance of a class
# Example: CREATE_INSTANCE(BAR, CLASS_FOO)
FUNCTION(CREATE_INSTANCE INSTANCE_NAME CLASS_NAME)
  FOREACH(FUNC_NAME ${${CLASS_NAME}_METHODS})
    INT_WIRE_METHOD("${INSTANCE_NAME}" "${INSTANCE_NAME}_${FUNC_NAME}" "${CLASS_NAME}_${FUNC_NAME}")
  ENDFOREACH()
ENDFUNCTION()

	