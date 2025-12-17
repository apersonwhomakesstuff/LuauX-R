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
								
Sub-module: Extra/Etc/Other
]]

local Extra = {}

-- Move a part directly to a position
function Extra.MoveTo(part: BasePart, x: number, y: number, z: number)
	if part and part:IsA("BasePart") then
		part.Position = Vector3.new(x, y, z)
	end
end

-- Smoothly move a part toward a target position
function Extra.ApproachPart(part: BasePart, target: Vector3, delta: number)
	if part and part:IsA("BasePart") then
		local current = part.Position
		local direction = target - current
		local distance = direction.Magnitude
		if distance <= delta then
			part.Position = target
		else
			part.Position = current + direction.Unit * delta
		end
	end
end

-- Linear interpolation between two Vector3s
function Extra.LerpVector(a: Vector3, b: Vector3, t: number)
	return a + (b - a) * t
end

-- Distance between two Vector3s
function Extra.DistanceVector(a: Vector3, b: Vector3)
	return (a - b).Magnitude
end

-- Clamp a Vector3 between min and max vectors
function Extra.ClampVector(vec: Vector3, min: Vector3, max: Vector3)
	return Vector3.new(
		math.clamp(vec.X, min.X, max.X),
		math.clamp(vec.Y, min.Y, max.Y),
		math.clamp(vec.Z, min.Z, max.Z)
	)
end

-- Generate a random Vector3 between min and max
function Extra.RandomVector(min: Vector3, max: Vector3)
	return Vector3.new(
		math.random() * (max.X - min.X) + min.X,
		math.random() * (max.Y - min.Y) + min.Y,
		math.random() * (max.Z - min.Z) + min.Z
	)
end

-- Rotate a Vector3 around Y axis by angle in degrees
function Extra.RotateY(vec: Vector3, angle: number)
	local rad = math.rad(angle)
	local cos = math.cos(rad)
	local sin = math.sin(rad)
	return Vector3.new(
		vec.X * cos - vec.Z * sin,
		vec.Y,
		vec.X * sin + vec.Z * cos
	)
end

-- Rotate a Vector3 around a center point by angle (degrees) on Y axis
function Extra.RotateAroundPoint(vec: Vector3, center: Vector3, angle: number)
	local relative = vec - center
	local rotated = Extra.RotateY(relative, angle)
	return center + rotated
end

-- Forward vector from part's orientation
function Extra.Forward(part: BasePart)
	if part and part:IsA("BasePart") then
		return part.CFrame.LookVector
	end
end

-- Right vector from part's orientation
function Extra.Right(part: BasePart)
	if part and part:IsA("BasePart") then
		return part.CFrame.RightVector
	end
end

-- Simple easing: move value toward target smoothly (like Lerp for numbers)
function Extra.ApproachNumber(current: number, target: number, delta: number)
	if current < target then
		return math.min(current + delta, target)
	elseif current > target then
		return math.max(current - delta, target)
	else
		return target
	end
end

-- Easing for Vector3s (smoothly interpolate each component)
function Extra.EaseVector(current: Vector3, target: Vector3, speed: number)
	return Vector3.new(
		Extra.ApproachNumber(current.X, target.X, speed),
		Extra.ApproachNumber(current.Y, target.Y, speed),
		Extra.ApproachNumber(current.Z, target.Z, speed)
	)
end

-- Random unit vector
function Extra.RandomUnitVector()
	local theta = math.random() * 2 * math.pi
	local phi = math.acos(2 * math.random() - 1)
	local x = math.sin(phi) * math.cos(theta)
	local y = math.sin(phi) * math.sin(theta)
	local z = math.cos(phi)
	return Vector3.new(x, y, z)
end

-- Smoothly rotate a part toward a target CFrame
local TweenService = game:GetService("TweenService")

-- Smoothly rotate a part toward a target CFrame using TweenService
function Extra.RotateTo(part: BasePart, targetCFrame: CFrame, time: number, easingStyle: Enum.EasingStyle?, easingDirection: Enum.EasingDirection?)
	if part and part:IsA("BasePart") then
		local tweenInfo = TweenInfo.new(
			time or 0.5, -- duration in seconds, default 0.5
			easingStyle or Enum.EasingStyle.Linear, -- easing style
			easingDirection or Enum.EasingDirection.Out -- easing direction
		)
		local tween = TweenService:Create(part, tweenInfo, {CFrame = targetCFrame})
		tween:Play()
	end
end


-- Calculate angle (in degrees) between two vectors
function Extra.AngleBetweenVectors(a: Vector3, b: Vector3)
	local dot = a.Unit:Dot(b.Unit)
	return math.deg(math.acos(math.clamp(dot, -1, 1)))
end

-- Velocity helper: move part toward target with speed
function Extra.MoveTowardsVelocity(part: BasePart, target: Vector3, speed: number)
	if part and part:IsA("BasePart") then
		local direction = (target - part.Position).Unit
		part.Velocity = direction * speed
	end
end

-- Calculate bounding box of multiple parts
function Extra.CalculateBoundingBox(parts: {BasePart})
	if #parts == 0 then return nil end
	local minX, minY, minZ = math.huge, math.huge, math.huge
	local maxX, maxY, maxZ = -math.huge, -math.huge, -math.huge

	for _, part in pairs(parts) do
		if part and part:IsA("BasePart") then
			local pos = part.Position
			minX = math.min(minX, pos.X)
			minY = math.min(minY, pos.Y)
			minZ = math.min(minZ, pos.Z)
			maxX = math.max(maxX, pos.X)
			maxY = math.max(maxY, pos.Y)
			maxZ = math.max(maxZ, pos.Z)
		end
	end

	local size = Vector3.new(maxX - minX, maxY - minY, maxZ - minZ)
	local center = Vector3.new((minX + maxX) / 2, (minY + maxY) / 2, (minZ + maxZ) / 2)
	return center, size
end

-- Check if two Vector3s are approximately equal
function Extra.VectorApproxEqual(a: Vector3, b: Vector3, tolerance: number)
	return (a - b).Magnitude <= tolerance
end

return Extra


--[[
TODO / Future ideas:
* Add functions for smooth rotations (CFrame rotations) DONE
* Add velocity / movement helpers for parts				DONE
* Add functions for bounding box calculations			DONE
* Add angle-between-vectors function					DONE
]]
