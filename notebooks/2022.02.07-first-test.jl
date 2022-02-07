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
	Pkg.activate(".")
end

# ╔═╡ e5936aaa-59ec-48bf-91af-46f7bb3987c3
using Plots

# ╔═╡ 492be7c0-c211-4c40-8638-508183ddc615
using FinSight

# ╔═╡ 21f7cc65-851a-42a9-9b6d-ad8f5e188f66
using PlutoUI

# ╔═╡ ad43845d-81fe-41ae-b3f9-1eebded9e399
begin
	values = [-10000, 3000, 4200, 6800]
end

# ╔═╡ c6275a35-8093-432c-b5ed-db36eb8e7189
@bind rate Slider(range(0.1, stop=0.9, length=10))

# ╔═╡ 57f66f1e-3cf2-4db8-8ae6-3cb8f5069e61
npv(rate, values)

# ╔═╡ d0f16333-dfb6-437b-9007-9b07da70b64a
rates = range(0.1, stop=0.9, length=10)

# ╔═╡ 5702265d-e0dc-45a6-9e72-8df3c708c718
plot(rates, map(x->npv(x, values), rates), m=:c,
	xlab="rate", ylab="npv")

# ╔═╡ Cell order:
# ╠═ac99559c-880b-11ec-164b-ef9d96149fb9
# ╠═e5936aaa-59ec-48bf-91af-46f7bb3987c3
# ╠═492be7c0-c211-4c40-8638-508183ddc615
# ╠═21f7cc65-851a-42a9-9b6d-ad8f5e188f66
# ╠═ad43845d-81fe-41ae-b3f9-1eebded9e399
# ╠═c6275a35-8093-432c-b5ed-db36eb8e7189
# ╠═57f66f1e-3cf2-4db8-8ae6-3cb8f5069e61
# ╠═d0f16333-dfb6-437b-9007-9b07da70b64a
# ╠═5702265d-e0dc-45a6-9e72-8df3c708c718
