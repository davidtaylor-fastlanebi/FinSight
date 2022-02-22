### A Pluto.jl notebook ###
# v0.18.0

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ ac99559c-880b-11ec-164b-ef9d96149fb9
begin
	import Pkg
	Pkg.activate("Project.toml")
	Pkg.instantiate()
end

# ╔═╡ e5936aaa-59ec-48bf-91af-46f7bb3987c3
using Plots

# ╔═╡ 492be7c0-c211-4c40-8638-508183ddc615
using FinSight

# ╔═╡ 21f7cc65-851a-42a9-9b6d-ad8f5e188f66
using PlutoUI

# ╔═╡ bfb73c6d-b36d-4d9b-b549-8ce8775b1be9
using Measurements

# ╔═╡ ad43845d-81fe-41ae-b3f9-1eebded9e399

values = [-10000, 3000, 4200, 5800]

# ╔═╡ 38bf894e-fcae-4d20-98c6-6de7e73ebcfc
uncertanties = [1000, 100, 300, 400]

# ╔═╡ f8a0b02e-e913-4b97-92c7-dbac971ed569
values .± uncertanties

# ╔═╡ c6275a35-8093-432c-b5ed-db36eb8e7189
@bind rate Slider(range(0.1, stop=0.9, length=10))

# ╔═╡ dfd301bc-8420-41e7-b2d8-4e570dfdaad8
npv(rate, values .± uncertanties)

# ╔═╡ 594461e0-4da5-48c8-98cc-31232a7770ba
rate

# ╔═╡ 57f66f1e-3cf2-4db8-8ae6-3cb8f5069e61
npv(rate, values)

# ╔═╡ d0f16333-dfb6-437b-9007-9b07da70b64a
rates = range(0.1, stop=0.9, length=10)

# ╔═╡ 5702265d-e0dc-45a6-9e72-8df3c708c718
plot(rates, 
	map(x->npv(x, values), rates), 
	
	m=:c, xlab="rate", ylab="npv")

# ╔═╡ 3640b925-9670-4b37-a357-64cd91f6ef98
rates

# ╔═╡ 73fd2d92-1d35-451e-be2e-b9975f7296fb
[npv(i, values) for i in rates]

# ╔═╡ Cell order:
# ╠═ac99559c-880b-11ec-164b-ef9d96149fb9
# ╠═e5936aaa-59ec-48bf-91af-46f7bb3987c3
# ╠═492be7c0-c211-4c40-8638-508183ddc615
# ╠═21f7cc65-851a-42a9-9b6d-ad8f5e188f66
# ╠═bfb73c6d-b36d-4d9b-b549-8ce8775b1be9
# ╠═ad43845d-81fe-41ae-b3f9-1eebded9e399
# ╠═38bf894e-fcae-4d20-98c6-6de7e73ebcfc
# ╠═f8a0b02e-e913-4b97-92c7-dbac971ed569
# ╠═dfd301bc-8420-41e7-b2d8-4e570dfdaad8
# ╠═c6275a35-8093-432c-b5ed-db36eb8e7189
# ╠═594461e0-4da5-48c8-98cc-31232a7770ba
# ╠═57f66f1e-3cf2-4db8-8ae6-3cb8f5069e61
# ╠═d0f16333-dfb6-437b-9007-9b07da70b64a
# ╠═5702265d-e0dc-45a6-9e72-8df3c708c718
# ╠═3640b925-9670-4b37-a357-64cd91f6ef98
# ╠═73fd2d92-1d35-451e-be2e-b9975f7296fb
