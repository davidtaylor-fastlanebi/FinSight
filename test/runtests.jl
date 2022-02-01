using FinSight
using Dates
using Test
@testset "(x)irr and (x)npv functions" begin
# Examples from
# https://support.microsoft.com/en-us/office/npv-function-8672cb67-2576-4d07-b67b-ac28acf2a568
    @test isapprox(npv(0.1, [-10000, 3000, 4200, 6800]), 1188.44, rtol = 1e-3)
    @test isapprox(npv(0.08, [8000, 9200, 10000, 12000, 14500]) + (-40000), 1922.06, rtol=1e-3)

    let values = [-70e3, 12e3, 15e3, 18e3, 21e3, 26e3]
        @test isapprox(irr(values[1:end-1]), -0.021, atol=1e-3)
        @test isapprox(npv(irr(values), values), 0.0, atol=1e-6)
        v2 = @view values[1:5]
        @test isapprox(npv(irr(v2), v2), 0.0, atol=1e-6)
    end

    # From https://support.microsoft.com/en-us/office/xnpv-function-1b42bbf6-370f-4532-a0eb-d67c16b664b7
    let (dates, values) =
        ([DateTime(2008, 1, 1), DateTime(2008, 3, 1), DateTime(2008, 10, 30), DateTime(2009,2,15), DateTime(2009,4, 1)],
         [-10e3, 2750, 4250, 3250, 2750])
        @test isapprox(xnpv(0.09, values, dates), 2086.65, atol=1e-2)
        @test isapprox(xnpv(xirr(values, dates), values, dates), 0.0, atol=1e-6)
    end
end
