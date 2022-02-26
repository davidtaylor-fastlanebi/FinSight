### A Pluto.jl notebook ###
# v0.18.0

using Markdown
using InteractiveUtils

# ╔═╡ d6cfceae-779d-474d-a609-e1fe6fb1d276
begin
	import Pkg
	Pkg.activate(".")
end

# ╔═╡ ea6b61fa-51d1-499a-884a-b7fba187d005
begin
	using FinSight
	using Plots
	using PlutoUI
	using DataFrames
	using Measurements
end

# ╔═╡ c2f43cb6-e226-4be6-b54c-96417ae953fa
# Illistrative "pro forma" DCF valuation of a rental property

# ╔═╡ d7e8f31d-86e9-4832-878b-be2d925767dc
begin
	# rate
	r = 0.07
	
	# Vacancy 5.0% of gross income
	v = 0.05
	
	# Capital Expenditures 10% of gross income 
	ci = 0.10 ± 0  # Could be zero
	
	#Growth Rate 2%
	g = 0.02 ± 0.001
	
	# Expenses 35% of gross income
	expense_ratio = 0.35 ± 0.05
	
	# Exit Capitalisation Rate 5%
	y = 0.05
	
	# Time horizon now (year 0) plus 11 years
	year = [0,0,0, 0,0,0, 0,0,0, 0, 0,0]  
	
	# Potential Gross Income first year $100
	pgi_fy = 100.0 ± 20

	nothing
end

# ╔═╡ 6d70da11-1f37-46c1-bae2-c9635674f4e2
# Potential Gross Income nominal cash flow 
begin
	pgi = zeros(typeof(pgi_fy), 12)
	pgi[2] = pgi_fy   # first year gross income is the second value
	growth_factor = 1.0 + g  
	
	for i = 3:12
			prior_year_income = pgi[i-1]
	 		pgi[i] =   prior_year_income * growth_factor  		
	end

	pgi
end

# ╔═╡ 06a77d3e-e321-446a-9e18-8a53e3ad2214
pgi  # Potential gross income per square metre of office space

# ╔═╡ 46f48d40-e8d6-4b4a-8176-06ae91298209
begin
	df = DataFrame();
	df.years = 1:length(year)
	df.pgi = pgi
	df.vacancy_allowance = df.pgi .* v
	df.effective_gross_income = df.pgi - df.vacancy_allowance
	df.operating_expenses = expense_ratio * df.pgi
	df.net_operating_income = df.effective_gross_income - df.operating_expenses
	df.capital_expenditures = ci * df.pgi
	df.net_annual_cash_flows = df.net_operating_income - df.capital_expenditures
	df.reversion_cash_flows = [0, 0,0,0,0,0, 0,0,0,0, df.net_annual_cash_flows[12] / y ,0]

	df.net_cash_flows = df.net_annual_cash_flows + df.reversion_cash_flows

	df
end

# ╔═╡ 7e23378a-5293-4e9a-b308-89324cd1cad2
# Present value @ 7.0% Discount rate
net_present_value = round(npv(r, df.net_cash_flows[2:11]))

# ╔═╡ 772f35f4-5d5c-4359-a14c-d88e704bee49
plot(df.years, df.net_cash_flows, xlab="years", ylab="Net cash flows")

# ╔═╡ b2286e8c-f911-457c-ab86-66799f380f70


# ╔═╡ Cell order:
# ╠═d6cfceae-779d-474d-a609-e1fe6fb1d276
# ╠═ea6b61fa-51d1-499a-884a-b7fba187d005
# ╠═c2f43cb6-e226-4be6-b54c-96417ae953fa
# ╠═d7e8f31d-86e9-4832-878b-be2d925767dc
# ╠═6d70da11-1f37-46c1-bae2-c9635674f4e2
# ╠═06a77d3e-e321-446a-9e18-8a53e3ad2214
# ╠═46f48d40-e8d6-4b4a-8176-06ae91298209
# ╠═7e23378a-5293-4e9a-b308-89324cd1cad2
# ╠═772f35f4-5d5c-4359-a14c-d88e704bee49
# ╠═b2286e8c-f911-457c-ab86-66799f380f70
