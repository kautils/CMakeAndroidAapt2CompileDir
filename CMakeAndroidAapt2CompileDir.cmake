
if(NOT DEFINED KAUTIL_THIRD_PARTY_DIR)
    set(KAUTIL_THIRD_PARTY_DIR ${CMAKE_BINARY_DIR})
    file(MAKE_DIRECTORY "${KAUTIL_THIRD_PARTY_DIR}")
endif()

macro(git_clone url)
    get_filename_component(file_name ${url} NAME)
    if(NOT EXISTS ${KAUTIL_THIRD_PARTY_DIR}/kautil_cmake/${file_name})
        file(DOWNLOAD ${url} "${KAUTIL_THIRD_PARTY_DIR}/kautil_cmake/${file_name}")
    endif()
    include("${KAUTIL_THIRD_PARTY_DIR}/kautil_cmake/${file_name}")
    unset(file_name)
endmacro()
git_clone(https://raw.githubusercontent.com/kautils/CMakeIsPathUpdated/v0.0.1/CMakeIsPathUpdated.cmake)


macro(CMakeAndroidAapt2CompileDir result)
    
    set(${PROJECT_NAME}_m_evacu ${m})
    set(m ${PROJECT_NAME}.CMakeAndroidAapt2CompileDir)
    
    list(APPEND ${m}_unsetter ${m}_DIR ${m}_DESTINATION)
    cmake_parse_arguments(${m} "DEBUG_VERBOSE;VERBOSE" "AAPT2;DIR;DESTINATION" "" ${ARGV})
    
    list(APPEND ${m}_unsetter ${m}_res ${m}_name ${m}_dst)
    cmake_path(ABSOLUTE_PATH ${m}_DESTINATION)
    file(MAKE_DIRECTORY "${${m}_DESTINATION}")
    get_filename_component(${m}_name ${${m}_DIR} NAME)
    set(${m}_dst ${${m}_DESTINATION}/${${m}_name}.zip)
    
    if(${${m}_DEBUG_VERBOSE})
        include(CMakePrintHelpers)
        cmake_print_variables(${m}_AAPT2)
        cmake_print_variables(${m}_DIR)
        cmake_print_variables(${m}_DESTINATION)
        cmake_print_variables(${m}_dst)
    endif()
    
    CMakeIsPathUpdated( ${m}_res PATH ${${m}_DIR})
    if(${${m}_res} OR (NOT EXISTS "${${m}_dst}"))
        if(${${m}_VERBOSE})
            message("[${m}] : ${${m}_AAPT2} compile --dir \"${${m}_DIR}\" -o \"${${m}_DESTINATION}/${${m}_name}.zip\"")
        endif()
        execute_process(COMMAND ${${m}_AAPT2} compile --dir "${${m}_DIR}" -o "${${m}_DESTINATION}/${${m}_name}.zip")
    endif()
    unset(${m}_res)
    
    foreach(__v ${${m}_unsetter})
        unset(${__v})
    endforeach()
    unset(${m}_unsetter)
    set(m ${${PROJECT_NAME}_m_evacu})
    unset(${PROJECT_NAME}_CMakeAndroidAapt2CompileDir)
    
    set(${result}.output ${${m}_dst})
endmacro()