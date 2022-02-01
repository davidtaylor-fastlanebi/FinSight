module FinSight

# Write your package code here.

"""
Calculates the net present value of an investment by using a discount rate and a
series of future payments (negative values) and income (positive values).
Implentation from
https://support.microsoft.com/en-us/office/npv-function-8672cb67-2576-4d07-b67b-ac28acf2a568
"""
function npv(rate::Real, values::AbstractVector{T}) where T <:Real
    @assert length(values) > 0
    out = 0
    for (i, val) in enumerate(values)
        out += val / (1 + rate)^i
    end
    return out
end
export npv

end
