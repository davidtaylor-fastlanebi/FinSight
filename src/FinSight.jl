module FinSight

# Write your package code here.

"""
Calculates the net present value of an investment by using a discount rate and a
series of future payments (negative values) and income (positive values).
Implentation from
https://support.microsoft.com/en-us/office/npv-function-8672cb67-2576-4d07-b67b-ac28acf2a568
"""
function npv(rate, values)
    @assert length(values) > 0
    out = 0
    for (i, val) in enumerate(values)
        out += val / (1 + rate)^i
    end
    return out
end
export npv

# Example 1 from
# https://support.microsoft.com/en-us/office/npv-function-8672cb67-2576-4d07-b67b-ac28acf2a568
@show npv(0.1, [-10000, 3000, 4200, 6800])

# Example 2
npv(0.08, [8000, 9200, 10000, 12000, 14500]) + (-40000)
end
