module FinSight
using Roots: find_zero
using Dates: DateTime, Day

"""
Calculates the net present value of an investment by using a discount rate and a
series of future payments (negative values) and income (positive values).

rate - the rate of discount over the length of one period.
values - arguments representing the payments and income.

From https://support.microsoft.com/en-us/office/npv-function-8672cb67-2576-4d07-b67b-ac28acf2a568
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

"""
Returns the internal rate of return for a series of cash flows represented by
the numbers in values. These cash flows do not have to be even, as they would be
for an annuity.

values - An array or a reference to cells that contain numbers for
which you want to calculate the internal rate of return.
rate_guess -  A number that you guess is close to the result of IRR

From https://support.microsoft.com/en-us/office/irr-function-64925eaa-9988-495b-b290-3ad0c163c1bc
"""
function irr(values::AbstractVector{T}, rate_guess::Real = 0.1) where T <:Real
    @assert length(values) > 0
    rate = find_zero(x -> npv(x, values),  rate_guess, )
    return rate
end
export irr

"""
Returns the net present value for a schedule of cash flows that is not
necessarily periodic. To calculate the net present value for a series of cash
flows that is periodic, use the NPV function.
"""
function xnpv(rate::Real, values::AbstractVector{T}, dates::Vector{DateTime}) where T <:Real
    @assert length(values) > 0
    @assert length(values) == length(dates)
    out = 0
    for (i, val) in enumerate(values)
        exponent = Day(dates[i] - first(dates)) / Day(365)
        out += val / (1 + rate)^exponent
    end
    return out
end
export xnpv

"""
Returns the internal rate of return for a schedule of cash flows that is not
necessarily periodic. To calculate the internal rate of return for a series of
periodic cash flows, use the IRR function.
"""
function xirr(values::AbstractVector{T}, dates::Vector{DateTime}, rate_guess::Real = 0.1) where T <:Real
    @assert length(values) > 0
    @assert length(values) == length(dates)
    rate = find_zero(x -> xnpv(x, values, dates),  rate_guess)
    return rate
end
export xirr


end
