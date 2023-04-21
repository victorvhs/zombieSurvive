function love.load()
	sprite= {}
	sprite.background = love.graphics.newImage("sprite/background.png")
	sprite.player = love.graphics.newImage("sprite/player.png")
	sprite.bullet = love.graphics.newImage("sprite/bullet.png")
	sprite.zombie = love.graphics.newImage("sprite/zombie.png")

	player = {}
	player.x = love.graphics.getWidth() / 2
	player.y = love.graphics.getHeight() / 2
	player.speed = 190

	zombies = {}
	zombiesCount = 0
end

function love.update(dt)
	movePlayer(dt,player)

	for i,z in ipairs(zombies) do
		z.x = z.x + (math.cos(zombiePlayerAngle(z,player))) * z.speed * dt
		z.y = z.y + (math.sin(zombiePlayerAngle(z,player))) * z.speed * dt
		zombiesCount = zombiesCount + 1

		if distanceBetween(z.x,z.y,player.x,player.y) < 30 then
			for i,z in ipairs(zombies) do
				zombies[i] = nil
				zombiesCount = zombiesCount - 1
			end
		end
	end
end

function love.draw()
	love.graphics.draw(sprite.background, 0, 0)
	love.graphics.draw(sprite.player, player.x, player.y,getAngleFromMouse(player.x,player.y),nil, nil, sprite.player:getWidth()/2, sprite.player:getHeight()/2)

	for i,z in ipairs(zombies) do 
		love.graphics.draw(sprite.zombie,z.x,z.y,zombiePlayerAngle(z,player),nil,nil,sprite.zombie:getWidth()/2,sprite.zombie:getHeight()/2)
	end

end

function movePlayer(dt,player)
	if love.keyboard.isDown("d") then
		player.x = player.x + player.speed * dt
	end
	if love.keyboard.isDown("a") then
		player.x = player.x - player.speed  * dt
	end
	if love.keyboard.isDown("w") then
		player.y = player.y - player.speed  * dt
	end
	if love.keyboard.isDown("s") then
		player.y = player.y + player.speed  * dt
	end
end

function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	end

	if key == "space" then
		spawnZombies(zombies)
	end
end

function getAngleFromMouse(x1, y1)
	return math.atan2(love.mouse.getY() - y1, love.mouse.getX() - x1)
end

function zombiePlayerAngle(enemy, player)
	return math.atan2(player.y - enemy.y, player.x - enemy.x)
end

function spawnZombies(zombies)
	local zombie = {}
	zombie.x = math.random(0,love.graphics.getWidth())
	zombie.y = math.random(0,love.graphics.getHeight())
	zombie.speed = 150
	table.insert(zombies, zombie)
end

function distanceBetween(x1,y1,x2,y2)
	return math.sqrt((y2 - y1)^2 + (x2 - x1)^2)
end