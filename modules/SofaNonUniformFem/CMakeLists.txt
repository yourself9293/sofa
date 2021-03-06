cmake_minimum_required(VERSION 3.1)
project(SofaNonUniformFem)

set(HEADER_FILES
    config.h
    initNonUniformFEM.h
    )

set(SOURCE_FILES
    initNonUniformFEM.cpp
    )

list(APPEND HEADER_FILES
    DynamicSparseGridGeometryAlgorithms.h
    DynamicSparseGridGeometryAlgorithms.inl
    DynamicSparseGridTopologyAlgorithms.h
    DynamicSparseGridTopologyContainer.h
    DynamicSparseGridTopologyModifier.h
    MultilevelHexahedronSetTopologyContainer.h
    NonUniformHexahedralFEMForceFieldAndMass.h
    NonUniformHexahedralFEMForceFieldAndMass.inl
    NonUniformHexahedronFEMForceFieldAndMass.h
    NonUniformHexahedronFEMForceFieldAndMass.inl
    # NonUniformHexahedronFEMForceFieldDensity.h
    # NonUniformHexahedronFEMForceFieldDensity.inl
    SparseGridMultipleTopology.h
    SparseGridRamificationTopology.h
    )
list(APPEND SOURCE_FILES
    DynamicSparseGridGeometryAlgorithms.cpp
    DynamicSparseGridTopologyAlgorithms.cpp
    DynamicSparseGridTopologyContainer.cpp
    DynamicSparseGridTopologyModifier.cpp
    MultilevelHexahedronSetTopologyContainer.cpp
    NonUniformHexahedralFEMForceFieldAndMass.cpp
    NonUniformHexahedronFEMForceFieldAndMass.cpp
    # NonUniformHexahedronFEMForceFieldDensity.cpp
    SparseGridMultipleTopology.cpp
    SparseGridRamificationTopology.cpp
    )

sofa_find_package(SofaDenseSolver QUIET BOTH_SCOPES)
if(SofaDenseSolver_FOUND)
    list(APPEND HEADER_FILES
        HexahedronCompositeFEMForceFieldAndMass.h
        HexahedronCompositeFEMForceFieldAndMass.inl
        HexahedronCompositeFEMMapping.h
        HexahedronCompositeFEMMapping.inl
        )
    list(APPEND SOURCE_FILES
        HexahedronCompositeFEMForceFieldAndMass.cpp
        HexahedronCompositeFEMMapping.cpp
        )
else()
    message(STATUS "SofaDenseSolver not found, disabling HexahedronCompositeFEMForceFieldAndMass compilation.")
endif()

add_library(${PROJECT_NAME} SHARED ${HEADER_FILES} ${SOURCE_FILES})
target_link_libraries(${PROJECT_NAME} PUBLIC SofaSimpleFem SofaGeneralSimpleFem SofaBaseTopology SofaBaseMechanics)
if(SofaDenseSolver_FOUND)
    target_link_libraries(${PROJECT_NAME} PUBLIC SofaDenseSolver)
endif()
set_target_properties(${PROJECT_NAME} PROPERTIES COMPILE_FLAGS "-DSOFA_BUILD_NON_UNIFORM_FEM")
set_target_properties(${PROJECT_NAME} PROPERTIES PUBLIC_HEADER "${HEADER_FILES}")

sofa_install_targets(SofaAdvanced ${PROJECT_NAME} "SofaAdvanced/${PROJECT_NAME}")
