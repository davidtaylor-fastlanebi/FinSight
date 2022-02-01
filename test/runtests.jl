using FinSight
using Test

@testset "FinSight.jl" begin
# Examples from
# https://support.microsoft.com/en-us/office/npv-function-8672cb67-2576-4d07-b67b-ac28acf2a568
    @test isapprox(npv(0.1, [-10000, 3000, 4200, 6800]), 1188.44, rtol = 1e-3)
    @test isapprox(npv(0.08, [8000, 9200, 10000, 12000, 14500]) + (-40000), 1922.06, rtol=1e-3)
end
