
include(../CMakeWithClasses.cmake)


DEFINE_CLASS("CLASS_A")
DEFINE_METHOD("CLASS_A" "FOO")
MACRO("${METHOD_NAME}")
  SET(METHOD_INST "${INSTANCE_NAME}")
  METHOD_RETURN(METHOD_INST)
ENDMACRO()

CREATE_INSTANCE("AC" "CLASS_A")

AC_FOO()

IF(NOT "${METHOD_INST}" STREQUAL "AC")
  MESSAGE(SEND_ERROR "Bad or non existent instance name. Should be AC, but it's ${METHOD_INST}")
ENDIF()
