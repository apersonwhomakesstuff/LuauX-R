--[[

^##^                                                ^##^       ^##^    ^##&&&&&&&%%,
 %%                                                   %$       $%   ::  $$        ^$,
 %%                                                    ^$     $^        $$         $;
 $$            ^##^   ^##^  ,$$%%%%$,  ^##^   ^##^      ^$, ,$^         $$     __,;$^
 $$             %%     %%   $%,   ^%%   $$     $$         ^$^           $$&&&&&&&%^
 $$             %%     %%     ,;;;;%%   $$     $$        $^ ^$          $$    ^%,
 $$             $$     $$   ,$^^^^^$$   $$     $$       $^   ^$         $$      ^%,
 $$         ,$  $$,___,$$   %%,___,$$   $$,___,$$     %^       ^%   ::  $$       ^%,
,%%$$$$$$$$$$%  ^%%$$$%^%,  ^%%$$$%^%,  ^%%$$$%^%,  ,##,       ,##,    ,%%,       ^%,

                            The best Luau helper module yet
							
							 Don't sue us. 🙏
								-- The LuauXR Team
]]

local luauxr = {} -- Luau Extra Remastered

function luauxr.Repeat(Times: number, Function: (any?) -> (any?), ...)
	local i = 0
	repeat
		i += 1
		Function(...)
	until i >= Times
end

return luauxr

	