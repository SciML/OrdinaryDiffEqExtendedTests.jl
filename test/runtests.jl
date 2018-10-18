using OrdinaryDiffEqExtendedTests, OrdinaryDiffEq, Test

const CACHE_TEST_ALGS = [Euler(),Midpoint(),RK4(),SSPRK22(),SSPRK33(),SSPRK53(),
  SSPRK63(),SSPRK73(),SSPRK83(),SSPRK432(),SSPRK932(),SSPRK54(),SSPRK104(),CarpenterKennedy2N54(),
  BS3(),BS5(),DP5(),DP5Threaded(),DP8(),Feagin10(),Feagin12(),Feagin14(),TanYam7(),
  Tsit5(),TsitPap8(),Vern6(),Vern7(),Vern8(),Vern9(),OwrenZen3(),OwrenZen4(),OwrenZen5()]

#@time @testset "Feagin Tests" begin include("ode_feagin_tests.jl") end
@time @testset "Units Tests" begin include("units_tests.jl") end
@time @testset "Time Derivative Tests" begin include("time_derivative_test.jl") end
@time @testset "Jacobian Tests" begin include("jacobian_tests.jl") end
@time @testset "Number Type Tests" begin include("ode_numbertype_tests.jl") end
@time @testset "Ndim Complex Tests" begin include("ode_ndim_complex_tests.jl") end
@time @testset "In-Place Tests" begin include("ode_inplace_tests.jl") end
@time @testset "Event Detection Tests" begin include("event_detection_tests.jl") end
@time @testset "Adaptive Tests" begin include("ode_adaptive_tests.jl") end
@time @testset "PSOS and Energy Conserve" begin include("psos_and_energy_conservation.jl") end
@time @testset "Init dt vs dorpri tests" begin include("init_dt_vs_dopri_tests.jl") end
@time @testset "Unrolled Tests" begin include("ode_unrolled_comparison_tests.jl") end
@time @testset "Alg Events Tests" begin include("alg_events_tests.jl") end
