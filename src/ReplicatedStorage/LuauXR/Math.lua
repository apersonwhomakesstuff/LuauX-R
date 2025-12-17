--[[

^##^                                                ^##^       ^##^  ^##&&&&&&&%%,
 %%                                                   %$       $%     $$        ^$,
 %%                                                    ^$     $^      $$         $;
 $$            ^##^   ^##^  ,$$%%%%$,  ^##^   ^##^      ^$, ,$^       $$     __,;$^
 $$             %%     %%   $%,   ^%%   $$     $$         ^$^         $$&&&&&&&%^
 $$             %%     %%     ,;;;;%%   $$     $$        $^ ^$        $$    ^%,
 $$             $$     $$   ,$^^^^^$$   $$     $$       $^   ^$       $$      ^%,
 $$         ,$  $$,___,$$   %%,___,$$   $$,___,$$     %^       ^%     $$       ^%,
,%%$$$$$$$$$$%  ^%%$$$%^%,  ^%%$$$%^%,  ^%%$$$%^%,  ,##,       ,##,  ,%%,       ^%,

                            The best Luau helper module yet
							
							 Don't sue us. 🙏
								-- The LuauXR Team
								
Sub-module: Math
]]

local Math = {}
function Math.Clamp(Input: number, Minimum: number, Maximum: number)
	if Input < Minimum then
		return Minimum
	elseif Input > Maximum then
		return Maximum
	else
		return Input
	end
end

function Math.Lerp(A: number, B: number, T: number)
	return A + (B - A) * T
end

function Math.Round(X: number, Decimals: number?)
	Decimals = Decimals or 0
	local Multiplier = 10 ^ Decimals
	if X >= 0 then
		return math.floor(X * Multiplier + 0.5) / Multiplier
	else
		return math.ceil(X * Multiplier - 0.5) / Multiplier
	end
end

function Math.Approach(Current: number, Target: number, Delta: number)
	if Current < Target then
		if Current + Delta < Target then
			return Current + Delta
		else
			return Target
		end
	elseif Current > Target then
		if Current - Delta > Target then
			return Current - Delta
		else
			return Target
		end
	else
		return Target
	end
end

function Math.Sign(X: number)
	if X > 0 then
		return 1
	elseif X < 0 then
		return -1
	else
		return 0
	end
end

function Math.Distance(A: number, B: number)
	if A > B then
		return A - B
	elseif A < B then
		return B - A
	else
		return 0
	end
end

function Math.Wrap(Value: number, Minimum: number, Maximum: number)
	local Range = Maximum - Minimum
	if Range == 0 then
		return Minimum
	else
		local Wrapped = (Value - Minimum) % Range + Minimum
		if Wrapped < Minimum then
			return Wrapped + Range
		elseif Wrapped > Maximum then
			return Wrapped - Range
		else
			return Wrapped
		end
	end
end

function Math.RandomRange_Float(Minimum: number, Maximum: number)
	if Minimum > Maximum then
		return math.random() * (Minimum - Maximum) + Maximum
	elseif Minimum < Maximum then
		return math.random() * (Maximum - Minimum) + Minimum
	else
		return Minimum
	end
end

function Math.RandomRange_Integer(Minimum: number, Maximum: number)
	return math.round(Math.RandomRange_Float(Minimum, Maximum))
end
	
return Math

--[[

TODO:

The following functions should be added to Math:
	*
	*
	*

]]