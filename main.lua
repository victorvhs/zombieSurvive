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
end

function love.update(dt)
	movePlayer(dt,player)
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
	zombie.speed = 100
	table.insert(zombies, zombie)
end