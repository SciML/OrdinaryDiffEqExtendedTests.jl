# OrdinaryDiffEqExtendedTests.jl

[![Build Status](https://travis-ci.org/JuliaDiffEq/OrdinaryDiffEqExtendedTests.jl.svg?branch=master)](https://travis-ci.org/JuliaDiffEq/OrdinaryDiffEqExtendedTests.jl)

This repository is for extended tests of OrdinaryDiffEq.jl. They cover extra
features like full convergence tests of the Feagin methods and units compatibility
which take too long to be part of the standard test suite. Additionally, specific
features tested for modeling domains are added here. If you have a downstream
package and would like to make sure some very specific functionality is
tested, feel free to add a PR here. 
