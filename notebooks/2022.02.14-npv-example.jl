### A Pluto.jl notebook ###
# v0.18.0

using Markdown
using InteractiveUtils

# ╔═╡ c2f43cb6-e226-4be6-b54c-96417ae953fa
# Illistrative "pro forma" DCF valuation of a rental property

# ╔═╡ 138676f7-18b8-4f1e-b4e2-b14bb0c0c6f0
#  Assumptions 

# Discount Rate 7%
r = 0.07 

# ╔═╡ 61a0f4ed-d089-469d-b710-ec120db396b8
# Vacancy 5.0% of gross income
v = 0.05

# ╔═╡ 13f86375-41e5-4363-b8cc-1b0b8a8bf6ae
# Capital Expenditures 10% of gross income 
ci = 0.10

# ╔═╡ 5a3840cb-506c-4951-8d6d-af52d19b76df
#Growth Rate 2%
g = 0.02

# ╔═╡ d522f1fe-3e3a-4d92-b873-8d6b5a438d7b
# Expenses 35% of gross income
expense_ratio = 0.35

# ╔═╡ c0155310-6b8f-491f-94da-590ce2a121c0
# Exit Capitalisation Rate 5%
y = 0.05

# ╔═╡ dd69dbc8-f4a6-4f5c-b417-e4e359199580
# Time horizon now (year 0) plus 11 years
year = [0,0,0, 0,0,0, 0,0,0, 0, 0,0]  

# ╔═╡ 1baf4382-8caa-4582-8d6f-e2d387b7d775
# Potential Gross Income first year $100
pgi_fy = 100.0

# ╔═╡ 6d70da11-1f37-46c1-bae2-c9635674f4e2
# Potential Gross Income nominal cash flow 
begin
	pgi =  [values = 0.0 for values = 0:11  ]  # create an income array years 0-11 
	pgi[2] = pgi_fy  # first year gross income is the second value
	growth_factor = 1.0 + g  
	
	for i = 3:12
			prior_year_income = pgi[i-1]
	 		pgi[i] =   prior_year_income * growth_factor  		
	end
end

# ╔═╡ 06a77d3e-e321-446a-9e18-8a53e3ad2214
pgi  # Potential gross income per square metre of office space

# ╔═╡ 758105e9-2277-442f-96e7-4b88f6cbaea4
# Vacancy allowance
vacancy_allowance = pgi .* v

# ╔═╡ 8c15b2eb-d3d8-4a6e-9af4-5dea167bb9ef
# Effective gross income
effective_gross_income = pgi - vacancy_allowance

# ╔═╡ 978c98da-8d3e-4a46-8d0d-b1fc309765e3
# Operating expenses
operating_expenses = expense_ratio * pgi

# ╔═╡ fa6e76de-4f87-4e28-90ec-96a7e050af92
# Net operating income
net_operating_income = effective_gross_income - operating_expenses

# ╔═╡ 682ab75d-cec1-4072-a1c5-2fcb2c0723cf
# Capital expenditures
capital_expenditures = ci * pgi

# ╔═╡ d5e03d54-8a61-48d9-8d82-ebc890225bf6
# Net annual cash flows
net_annual_cash_flows = net_operating_income - capital_expenditures

# ╔═╡ c70deae0-92a7-42e0-85eb-f46c38a9c7a7
# Reversion cash flows
reversion_cash_flows = [0, 0,0,0,0,0, 0,0,0,0, net_annual_cash_flows[12] / y ,0] 

# ╔═╡ de488ff6-f6d1-4bd5-8042-6a0f525c9352
# Net cash flows
net_cash_flows = net_annual_cash_flows + reversion_cash_flows

# ╔═╡ a15ed659-66bd-48e9-9501-1b8729672caf
function npv(rate::Real, values::AbstractVector{T}) where T <:Real
    out = 0
    for (i, val) in enumerate(values)
        out += val / (1 + rate)^i
    end
    return out
end

# ╔═╡ 7e23378a-5293-4e9a-b308-89324cd1cad2
# Present value @ 7.0% Discount rate
net_present_value = round( npv(r, net_cash_flows[2:11]) )

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.0"
manifest_format = "2.0"

[deps]
"""

# ╔═╡ Cell order:
# ╠═c2f43cb6-e226-4be6-b54c-96417ae953fa
# ╠═138676f7-18b8-4f1e-b4e2-b14bb0c0c6f0
# ╠═61a0f4ed-d089-469d-b710-ec120db396b8
# ╠═13f86375-41e5-4363-b8cc-1b0b8a8bf6ae
# ╠═5a3840cb-506c-4951-8d6d-af52d19b76df
# ╠═d522f1fe-3e3a-4d92-b873-8d6b5a438d7b
# ╠═c0155310-6b8f-491f-94da-590ce2a121c0
# ╠═dd69dbc8-f4a6-4f5c-b417-e4e359199580
# ╠═1baf4382-8caa-4582-8d6f-e2d387b7d775
# ╠═6d70da11-1f37-46c1-bae2-c9635674f4e2
# ╠═06a77d3e-e321-446a-9e18-8a53e3ad2214
# ╠═758105e9-2277-442f-96e7-4b88f6cbaea4
# ╠═8c15b2eb-d3d8-4a6e-9af4-5dea167bb9ef
# ╠═978c98da-8d3e-4a46-8d0d-b1fc309765e3
# ╠═fa6e76de-4f87-4e28-90ec-96a7e050af92
# ╠═682ab75d-cec1-4072-a1c5-2fcb2c0723cf
# ╠═d5e03d54-8a61-48d9-8d82-ebc890225bf6
# ╠═c70deae0-92a7-42e0-85eb-f46c38a9c7a7
# ╠═de488ff6-f6d1-4bd5-8042-6a0f525c9352
# ╠═a15ed659-66bd-48e9-9501-1b8729672caf
# ╠═7e23378a-5293-4e9a-b308-89324cd1cad2
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
