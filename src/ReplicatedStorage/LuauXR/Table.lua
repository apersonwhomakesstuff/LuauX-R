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
								
Sub-module: Table
]]

local Table = {}

function Table.Map(Table: {any?}, Function: (any?) -> any?)
	local Result = {}
	for Key, Value in Table do
		Result[Key] = Function(Value)
	end
	return Result
end 

function Table.Filter(Table: {any?}, Function: (any?) -> any?)
	local Result = {}
	for Key, Value in Table do
		if Function(Value) then
			Result[Key] = Value
		end
	end
	return Result
end

function Table.Reduce(Table: {any?}, Function: (any?) -> any?, Initial: any)
	local Accumulator = Initial
	for _, Value in Table do
		Accumulator = Function(Accumulator, Value)
	end
	return Accumulator
end

function Table.ShallowCopy(Table: {any?})
	local Result = {}
	for Key, Value in Table do
		Result[Key] = Value
	end
	return Result
end

function Table.DeepCopy(Table: {any?})
	local Seen = {}
	local function Copy(Value)
		if typeof(Value) ~= "table" then
			return Value
		end
		if Seen[Value] then
			return Seen[Value]
		end
		local NewTable = {}
		Seen[Value] = NewTable
		for _Key, _Value in pairs(Value) do
			NewTable[Copy(_Key)] = Copy(_Value)
		end
		setmetatable(NewTable, getmetatable(Value))
		return NewTable
	end
	return Copy(Table)
end

function Table.Freeze(Table: {any?})
	local Metatable = getmetatable(Table)
	if Metatable and Metatable.__frozen then
		return Table
	end
	Metatable = Metatable or {}
	Metatable.__frozen = true
	Metatable.__newindex = function()
		error('LuauXR Error (id 1.00): attempt to modify a frozen table', 2)
	end
	Metatable.__metatable = 'This table has been frozen by LuauXR.'
	setmetatable(Table, Metatable)
	return Table
end

function Table.Append(Table: {any?}, Value: any)
	local Index = #Table + 1
	Table[Index] = Value
	return Table
end

function Table.Remove(Table: {any?}, Value: any)
	for Index = 1, #Table do
		if Table[Index] == Value then
			for Jndex = Index, #Table - 1 do
				Table[Jndex] = Table[Jndex + 1]
			end
			Table[#Table] = nil
			break
		end
	end
	return Table
end

function Table.Merge(TableA: {any?}, TableB: {any?})
	for Key, Value in pairs(TableB) do
		TableA[Key] = Value
	end
	return TableA
end

function Table.Contains(Table: {any?}, Value: any)
	for _Key, _Value in pairs(Table) do
		if _Value == Value then
			return true
		end
	end
	return false
end

function Table.Keys(Table: {any?})
	local Keys = {}
	for Key in pairs(Table) do
		Keys[#Keys + 1] = Key
	end
	return Keys
end

function Table.Values(Table: {any?})
	local Values = {}
	for _Key, Value in pairs(Table) do
		Values[#Values + 1] = Value
	end
	return Values
end

function Table.Reverse(Table: {any?})
	local Nndex = #Table
	for Index = 1, math.floor(Nndex / 2) do
		local Jndex = Nndex - Index + 1
		Table[Index], Table[Jndex] = Table[Jndex], Table[Index]
	end
	return Table
end

function Table.Find(Table: {any?}, Function: (any?) -> any?)
	for Index, Value in ipairs(Table) do
		if Function(Value, Index) then
			return Index, Value
		end
	end
	return nil
end

return Table