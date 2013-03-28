cmake_minimum_required(VERSION 2.8)

project("SofaComponentGeneral")

include(${SOFA_CMAKE_DIR}/pre.cmake)

set(HEADER_FILES

    initComponentGeneral.h

    )
    
set(SOURCE_FILES

    initComponentGeneral.cpp
 
    )
    
add_library(${PROJECT_NAME} SHARED ${HEADER_FILES} ${SOURCE_FILES})

set(COMPILER_DEFINES "SOFA_BUILD_COMPONENT_GENERAL" )
set(LINKER_DEPENDENCIES SofaValidation SofaExporter SofaEngine SofaGraphComponent SofaTopologyMapping SofaBoundaryCondition SofaUserInteraction SofaConstraint SofaHaptics SofaDenseSolver SofaOpenglVisual )
if(EXTERNAL_HAVE_CSPARSE)
    list(LINKER_DEPENDENCIES APPEND SofaSparseSolver SofaPreconditioner)
endif()
include(${SOFA_CMAKE_DIR}/post.cmake)
