using OrdinaryDiffEqExtendedTests, OrdinaryDiffEq
using Base.Test

@time @testset "Init dt vs dorpri tests" begin include("init_dt_vs_dopri_tests.jl") end
@time @testset "Unrolled Tests" begin include("ode_unrolled_comparison_tests.jl") end
@time @testset "Feagin Tests" begin include("ode_feagin_tests.jl") end
@time @testset "Units Tests" begin include("units_tests.jl") end
@time @testset "PSOS and Energy Conserve" begin include("psos_and_energy_conservation.jl") end
