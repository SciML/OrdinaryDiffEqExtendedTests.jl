using Unitful#, UnitfulPlots
using OrdinaryDiffEq, DiffEqBase

const UNITS_TEST_ALGS = [Euler(),Midpoint(),RK4(),SSPRK104(),SSPRK22(),SSPRK33(),
    SSPRK432(),BS3(),BS5(),DP5(),DP5Threaded(),DP8(),Feagin10(),Feagin12(),Feagin14(),
    TanYam7(),Tsit5(),TsitPap8(),Vern6(),Vern7(),Vern8(),Vern9()]

f = (t,y) -> 0.5*y / 3.0u"s"
u0 = 1.0u"N"
prob = ODEProblem(f,u0,(0.0u"s",1.0u"s"))

sol =solve(prob,ExplicitRK())

for alg in UNITS_TEST_ALGS
  if !(typeof(alg) <: DP5Threaded)
    @show alg
    sol = solve(prob,alg,dt=1u"s"/10)
  end
end

println("Units for Number pass")

u0 = [1.0u"N" 2.0u"N"
      3.0u"N" 1.0u"N"]
f = (t,y,dy) -> (dy .= 0.5.*y ./ 3.0u"s")
prob = ODEProblem(f,u0,(0.0u"s",1.0u"s"))

sol =solve(prob,ExplicitRK())

for alg in UNITS_TEST_ALGS
  @show alg
  sol = solve(prob,alg,dt=1u"s"/10)
end

println("Units for 2D pass")
