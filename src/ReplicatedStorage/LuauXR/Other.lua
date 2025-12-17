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

local TweenService = game:GetService("TweenService")

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

-- Clamp vector magnitude
function Extra.ClampMagnitude(vec: Vector3, maxMagnitude: number)
	local mag = vec.Magnitude
	if mag > maxMagnitude then
		return vec.Unit * maxMagnitude
	end
	return vec
end

-- Generate a random Vector3 between min and max
function Extra.RandomVector(min: Vector3, max: Vector3)
	return Vector3.new(
		math.random() * (max.X - min.X) + min.X,
		math.random() * (max.Y - min.Y) + min.Y,
		math.random() * (max.Z - min.Z) + min.Z
	)
end

-- Random unit vector
function Extra.RandomUnitVector()
	local theta = math.random() * 2 * math.pi
	local phi = math.acos(2 * math.random() - 1)
	return Vector3.new(
		math.sin(phi) * math.cos(theta),
		math.sin(phi) * math.sin(theta),
		math.cos(phi)
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

-- Rotate a Vector3 around a center point on Y axis
function Extra.RotateAroundPoint(vec: Vector3, center: Vector3, angle: number)
	return center + Extra.RotateY(vec - center, angle)
end

-- Forward vector from part
function Extra.Forward(part: BasePart)
	if part and part:IsA("BasePart") then
		return part.CFrame.LookVector
	end
end

-- Right vector from part
function Extra.Right(part: BasePart)
	if part and part:IsA("BasePart") then
		return part.CFrame.RightVector
	end
end

-- Up vector from part
function Extra.Up(part: BasePart)
	if part and part:IsA("BasePart") then
		return part.CFrame.UpVector
	end
end

-- Project vector a onto vector b
function Extra.ProjectVector(a: Vector3, b: Vector3)
	if b.Magnitude == 0 then
		return Vector3.zero
	end
	return b.Unit * a:Dot(b.Unit)
end

-- Reflect vector off a normal
function Extra.ReflectVector(direction: Vector3, normal: Vector3)
	if normal.Magnitude == 0 then
		return direction
	end
	return direction - 2 * direction:Dot(normal.Unit) * normal.Unit
end

-- Move in local space relative to part orientation
function Extra.MoveLocal(part: BasePart, localOffset: Vector3)
	if part and part:IsA("BasePart") then
		part.CFrame = part.CFrame * CFrame.new(localOffset)
	end
end

-- LookAt convenience (returns CFrame)
function Extra.LookAt(from: Vector3, to: Vector3, up: Vector3?)
	return CFrame.lookAt(from, to, up or Vector3.yAxis)
end

-- Apply LookAt directly to a part
function Extra.PartLookAt(part: BasePart, target: Vector3)
	if part and part:IsA("BasePart") then
		part.CFrame = CFrame.lookAt(part.Position, target)
	end
end

-- Smoothly rotate a part toward a target CFrame
function Extra.RotateTo(part: BasePart, targetCFrame: CFrame, time: number, easingStyle: Enum.EasingStyle?, easingDirection: Enum.EasingDirection?)
	if part and part:IsA("BasePart") then
		local tweenInfo = TweenInfo.new(
			time or 0.5,
			easingStyle or Enum.EasingStyle.Linear,
			easingDirection or Enum.EasingDirection.Out
		)
		TweenService:Create(part, tweenInfo, { CFrame = targetCFrame }):Play()
	end
end

-- Move value toward target
function Extra.ApproachNumber(current: number, target: number, delta: number)
	if current < target then
		return math.min(current + delta, target)
	elseif current > target then
		return math.max(current - delta, target)
	end
	return target
end

-- Frame-rate independent smoothing
function Extra.SmoothDamp(current: Vector3, target: Vector3, speed: number, deltaTime: number)
	return current:Lerp(target, 1 - math.exp(-speed * deltaTime))
end

-- Easing for Vector3s
function Extra.EaseVector(current: Vector3, target: Vector3, speed: number)
	return Vector3.new(
		Extra.ApproachNumber(current.X, target.X, speed),
		Extra.ApproachNumber(current.Y, target.Y, speed),
		Extra.ApproachNumber(current.Z, target.Z, speed)
	)
end

-- Angle between two vectors (degrees)
function Extra.AngleBetweenVectors(a: Vector3, b: Vector3)
	local dot = math.clamp(a.Unit:Dot(b.Unit), -1, 1)
	return math.deg(math.acos(dot))
end

-- Velocity helper
function Extra.MoveTowardsVelocity(part: BasePart, target: Vector3, speed: number)
	if part and part:IsA("BasePart") then
		part.Velocity = (target - part.Position).Unit * speed
	end
end

-- Average / centroid of vectors
function Extra.AverageVector(vectors: { Vector3 })
	if #vectors == 0 then
		return Vector3.zero
	end
	local sum = Vector3.zero
	for _, v in ipairs(vectors) do
		sum += v
	end
	return sum / #vectors
end

-- Calculate bounding box of multiple parts
function Extra.CalculateBoundingBox(parts: { BasePart })
	if #parts == 0 then return nil end

	local minX, minY, minZ = math.huge, math.huge, math.huge
	local maxX, maxY, maxZ = -math.huge, -math.huge, -math.huge

	for _, part in ipairs(parts) do
		if part and part:IsA("BasePart") then
			local p = part.Position
			minX = math.min(minX, p.X)
			minY = math.min(minY, p.Y)
			minZ = math.min(minZ, p.Z)
			maxX = math.max(maxX, p.X)
			maxY = math.max(maxY, p.Y)
			maxZ = math.max(maxZ, p.Z)
		end
	end

	local center = Vector3.new(
		(minX + maxX) / 2,
		(minY + maxY) / 2,
		(minZ + maxZ) / 2
	)

	local size = Vector3.new(
		maxX - minX,
		maxY - minY,
		maxZ - minZ
	)

	return center, size
end

-- Ray helper
function Extra.CastRay(origin: Vector3, direction: Vector3, params: RaycastParams?)
	return workspace:Raycast(origin, direction, params)
end

-- Vector approximate equality
function Extra.VectorApproxEqual(a: Vector3, b: Vector3, tolerance: number)
	return (a - b).Magnitude <= tolerance
end

return Extra
