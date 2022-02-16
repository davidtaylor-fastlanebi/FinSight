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
	using StatsPlots
	using Distributions
	using PlutoUI
	using DataFrames
	using MonteCarloMeasurements
end

# ╔═╡ c2f43cb6-e226-4be6-b54c-96417ae953fa
# Illistrative "pro forma" DCF valuation of a rental property

# ╔═╡ d7e8f31d-86e9-4832-878b-be2d925767dc
begin
	# initial purchase price of property $ per unit area
	initial_investment = 1000
	
	# rate
	r = 0.07
	
	# Capital Expenditures 10% of gross income 
	ci = 0.10 ± 0  # Could be zero
	
	#Growth Rate 2%
	g = 0.02 ± 0
	
	# Expenses 35% of gross income
	expense_ratio = 0.35 ± 0
	
	# Exit Capitalisation Rate 5%
	y = 0.05
	
	# Time horizon now (year 0) plus 11 years
	year = [0,0,0, 0,0,0, 0,0,0, 0, 0,0]  
	
	# Potential Gross Income first year $100
	pgi_fy = 100.0 ± 0

	nothing
end

# ╔═╡ 454d71be-0ca1-4234-a736-8d1033a5d68d
begin
	# Vacancy 5.0% of gross income
	# v_distr = TriangularDist(0.05, 0.08, 0.051) 

	# Try Gener
	v_distr = GeneralizedPareto(0.04, 0.01, 0.01) 
	v = Particles(2000, v_distr)
		
	plot(v_distr, title="Vacancy distribution (non-gaussian)", leg=false, )
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
	df.years = 0:length(year)-1
	df.pgi = pgi
	df.vacancy_allowance = df.pgi .* v
	df.effective_gross_income = df.pgi - df.vacancy_allowance
	df.operating_expenses = expense_ratio * df.pgi
	df.net_operating_income = df.effective_gross_income - df.operating_expenses
	df.capital_expenditures = ci * df.pgi
	df.net_annual_cash_flows = df.net_operating_income - df.capital_expenditures
	df.reversion_cash_flows = [-initial_investment, 0,0,0,0,0, 0,0,0,0, df.net_annual_cash_flows[12] / y ,0]

	df.net_cash_flows = df.net_annual_cash_flows + df.reversion_cash_flows

	df
end;

# ╔═╡ 25391fc1-5a43-4dcd-b69b-ff77628dbb83
# transpose the dataframe for presentation with columns as time periods
nominal_cash_flows = DataFrame([[names(df)]; collect.(eachrow(df))], [:column; Symbol.(axes(df, 1))])

# ╔═╡ faa662b0-d0d7-4a8d-8328-5f324a0d7f3f
net_present_value = npv(r, df.net_cash_flows)

# ╔═╡ 931cdff5-fe89-4f8c-bb5c-033ed228fdc5
density(net_present_value, ylab="relative prob", title="Net present value distribution", leg=false)

# ╔═╡ Cell order:
# ╠═d6cfceae-779d-474d-a609-e1fe6fb1d276
# ╠═ea6b61fa-51d1-499a-884a-b7fba187d005
# ╠═c2f43cb6-e226-4be6-b54c-96417ae953fa
# ╠═d7e8f31d-86e9-4832-878b-be2d925767dc
# ╠═454d71be-0ca1-4234-a736-8d1033a5d68d
# ╠═6d70da11-1f37-46c1-bae2-c9635674f4e2
# ╠═06a77d3e-e321-446a-9e18-8a53e3ad2214
# ╠═46f48d40-e8d6-4b4a-8176-06ae91298209
# ╠═25391fc1-5a43-4dcd-b69b-ff77628dbb83
# ╠═faa662b0-d0d7-4a8d-8328-5f324a0d7f3f
# ╠═931cdff5-fe89-4f8c-bb5c-033ed228fdc5
