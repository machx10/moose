[Mesh]
  type = GeneratedMesh
  dim = 3
  nx = 3
  ny = 3
  nz = 3
[]

[GlobalParams]
  displacements = 'disp_x disp_y disp_z'
[]

[Variables]
  [./disp_x]
  [../]
  [./disp_y]
  [../]
  [./disp_z]
  [../]
[]

[ADKernels]
  [./stress_x]
    type = ADStressDivergenceTensors
    component = 0
    variable = disp_x
    # use_displaced_mesh = true
  [../]
  [./stress_y]
    type = ADStressDivergenceTensors
    component = 1
    variable = disp_y
    # use_displaced_mesh = true
  [../]
  [./stress_z]
    type = ADStressDivergenceTensors
    component = 2
    variable = disp_z
    # use_displaced_mesh = true
  [../]
[]

[BCs]
  [./symmy]
    type = PresetBC
    variable = disp_y
    boundary = bottom
    value = 0
  [../]
  [./symmx]
    type = PresetBC
    variable = disp_x
    boundary = left
    value = 0
  [../]
  [./symmz]
    type = PresetBC
    variable = disp_z
    boundary = back
    value = 0
  [../]
  [./tdisp]
    type = PresetBC
    variable = disp_z
    boundary = front
    value = 0.1
  [../]
[]

[Materials]
  [./elasticity]
    type = ComputeIsotropicElasticityTensor
    poissons_ratio = 0.3
    youngs_modulus = 1e10
  [../]
[]

[ADMaterials]
  [./strain]
    type = ADComputeIncrementalSmallStrain
  [../]
  [./stress]
    type = ADComputeFiniteStrainElasticStress
  [../]
[]

[Preconditioning]
  [./smp]
    type = SMP
    full = true
  [../]
[]

[Executioner]
  type = Transient
  dt = 0.05
  solve_type = 'NEWTON'

  petsc_options_iname = -pc_hypre_type
  petsc_options_value = boomeramg

  dtmin = 0.05
  num_steps = 1
[]

[Outputs]
  exodus = true
[]
