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

	tempRotation = 0
end

function love.update(dt)
	movePlayer(dt,player)
	tempRotation = tempRotation + 0.01
end

function love.draw()
	love.graphics.draw(sprite.background, 0, 0)
	love.graphics.draw(sprite.player, player.x, player.y,tempRotation,nil, nil, sprite.player:getWidth()/2, sprite.player:getHeight()/2)

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