#    Copyright (C) 2024  7w1
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.

omnitool_manager:
    type: world
    debug: false
    events:
        on player left clicks block:
        - ratelimit <player> 1t
        - if <player.item_in_hand.has_flag[omnitool].equals[true]>:
            - define tags <context.location.block.material.vanilla_tags>
            - if <[tags].contains[mineable/pickaxe]>:
                - if !<player.item_in_hand.material.advanced_matches[*_pickaxe]>:
                    - inventory set origin:<item[<player.flag[pickaxe_level]>_pickaxe_omnitool]> slot:hand
            - else if <[tags].contains[mineable/axe]>:
                - if !<player.item_in_hand.material.advanced_matches[*_axe]>:
                    - inventory set origin:<item[<player.flag[axe_level]>_axe_omnitool]> slot:hand
            - else if <[tags].contains[mineable/shovel]>:
                - if !<player.item_in_hand.material.advanced_matches[*_shovel]>:
                    - inventory set origin:<item[<player.flag[shovel_level]>_shovel_omnitool]> slot:hand
            - else if <[tags].contains[mineable/hoe]>:
                - if !<player.item_in_hand.material.advanced_matches[*_hoe]>:
                    - inventory set origin:<item[<player.flag[hoe_level]>_hoe_omnitool]> slot:hand
            - else if <[tags].contains[sword_efficient]>:
                - if !<player.item_in_hand.material.advanced_matches[*_sword]>:
                    - inventory set origin:<item[<player.flag[sword_level]>_sword_omnitool]> slot:hand
        on player tries to attack entity:
        - ratelimit <player> 1t
        - if <player.item_in_hand.has_flag[omnitool].equals[true]>:
            - if !<player.item_in_hand.material.advanced_matches[*_sword]>:
                - inventory set origin:<item[<player.flag[sword_level]>_sword_omnitool]> slot:hand

