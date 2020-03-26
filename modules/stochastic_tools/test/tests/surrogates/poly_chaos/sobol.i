[Mesh]
  type = GeneratedMesh
  dim = 1
  nx = 1
[]

[Distributions/uniform]
  type = Uniform
  lower_bound = 0
  upper_bound = 1
[]

[Samplers/sample]
  type = Quadrature
  order = 4
  distributions = 'uniform uniform uniform uniform uniform uniform'
  execute_on = 'initial'
[]

[VectorPostprocessors]
  [results]
    type = GFunction
    sampler = sample
    q_vector = '0 0.5 3 9 99 99'
    execute_on = INITIAL
    outputs = none
  []
  [sobol]
    type = PolynomialChaosSobolStatistics
    pc_name = poly_chaos
    sensitivity_order = 'all total'
    execute_on = final
  []
[]

[Surrogates]
  [poly_chaos]
    type = PolynomialChaos
    trainer = poly_chaos
  []
[]

[Trainers]
  [poly_chaos]
    type = PolynomialChaosTrainer
    execute_on = final
    order = 4
    distributions = 'uniform uniform uniform uniform uniform uniform'
    sampler = sample
    results_vpp = results
    results_vector = g_values
  []
[]

[Executioner]
  type = Steady
[]

[Problem]
  solve = false
  kernel_coverage_check = false
[]

[Outputs]
  execute_on = 'FINAL'
  csv = true
[]
