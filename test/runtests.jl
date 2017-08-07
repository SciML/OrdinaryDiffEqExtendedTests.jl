using OrdinaryDiffEqExtendedTests, OrdinaryDiffEq
using Base.Test

@time @testset "Unrolled Tests" begin include("ode_unrolled_comparison_tests.jl") end
@time @testset "Feagin Tests" begin include("ode_feagin_tests.jl") end
@time @testset "Units Tests" begin include("units_tests.jl") end
