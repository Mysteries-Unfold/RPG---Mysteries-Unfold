

require('player')
require('enemies')

	phase = {}

function phase_load()
  title_font = love.graphics.newFont(40)
	player_load()
	
	phase1, phase2 = 1, 2



	phase.state = 1

	phase.x 	= 240
	phase.y   	= 80
	phase.w   	= phase.x + 480 -- Phase.x + comprimento de phase
	phase.h   	= phase.y + 480 -- Phase.y + altura de phase

	ext = {}

	ext.x = phase.x + 480 - 32
	ext.y = phase.y
	ext.w = ext.x + 32
	ext.h = ext.y + 32

end

-- Todas as colisões
function phase_update(dt)

	player_update(dt)
  
  if player.chicken then   --if the user is chicken
    player.chicken_time = player.chicken_time + dt  --adds chicken time
    if player.chicken_time >= 3 then                 --if it already chicken for 3 seconds
      player.chicken = false                        --its not chicken anymore
      player.chicken_time = 0                       --resets chicken time
    end
  end

	if phase.state == phase1 then
    
    if (enemies["phase1"][1].alive) and (not player.chicken) and (player.x+32>= 290) and (player.x<=290+(37.5)) and (player.y+32>= 400) and (player.y<=400+(41))then
      encontro.load()
      encontro.setPlayers(player, enemies["phase1"][1], phase.state)  --pass the player, enemy, and phase state to the encontro
      gameState = 3
     
    end

		if player.w > ext.x and player.y < ext.h then

			phase.state = 2
      cachang:play()

		end

	end

end

function phase.keypressed(key)
  
  if key == "b" then
    encontro.load()
    encontro.setPlayers(player, nil, phase.state)  --pass the player, enemy, and phase state to the encontro
    gameState = 3
     
  end
  
end


function phase_draw()
  
  

	if phase.state == phase1 then 

		love.graphics.setColor(255, 255, 255)
		love.graphics.print('Phase 1', 480 - 30, 40)
    --fundo da fase 1
    love.graphics.draw(phase.background1,phase.x,phase.y,0,1.25,1.25)
		love.graphics.setColor(255, 255, 255)
    -- saída
		love.graphics.draw(phase.exit1, ext.x-23, ext.y-23,0,0.2,0.2)
    --draw the enemy (to debug)
    love.graphics.draw(enemies["phase1"][1].alive_image, enemies["phase1"][1].x, enemies["phase1"][1].y,0,0.05, 0.05)

	elseif phase.state == phase2 then
		love.graphics.setColor(255, 255, 255)
		love.graphics.print('Phase 2', 480 - 30, 40)
    love.graphics.draw(phase.background2, phase.x, phase.y,0,0.48,0.65)    --draw the background
  end

	player_draw()

end

