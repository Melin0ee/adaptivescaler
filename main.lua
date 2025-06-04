

local base_antes = {300, 800, 2000, 5000, 11000, 20000, 35000, 50000}
local DIFFICULTY = {0.8, 1.0, 1.3,1.6}
local selected_difficulty = 1

local function get_best_hand_chips()
    if G.GAME and G.GAME.round_scores and G.GAME.round_resets.blind_states.Boss == 'Defeated' then
        return G.GAME.round_scores.hand.amt
    end
    return 100
end

local old_get_blind_amount = get_blind_amount

local best_chips = get_best_hand_chips()

function get_blind_amount(ante)
        sendDebugMessage("Best hand chips: " .. best_chips)
        if G.GAME.round_resets.blind_states.Boss == 'Defeated' then
            best_chips = get_best_hand_chips()
        end
        if ante < 1 then return best_chips
        elseif ante == 1 then return base_antes[1] 
        elseif ante <=8 then return (base_antes[ante]) + (best_chips * DIFFICULTY[selected_difficulty])
        else return (base_antes[8]*(1.5^(ante-8))) + (best_chips * DIFFICULTY[selected_difficulty])
        end
end

