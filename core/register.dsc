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

my_world:
    type: world
    debug: false
    events:
        after player joins:
        - if !<player.has_flag[registered]>:
            #- narrate "<&nl><&nl>Welcome to game that hasn't been named yet!<&nl>To begin your journey, please speak to the villager infront of you.<&nl>"
            - flag <player> registered:true

        - if !<player.has_flag[star_balance]>:
            - flag <player> star_balance:1
        - if !<player.has_flag[coin_balance]>:
            - flag <player> coin_balance:0

        - if !<player.has_flag[pickaxe_level]>:
            - flag <player> pickaxe_level:wooden
        - if !<player.has_flag[axe_level]>:
            - flag <player> axe_level:wooden
        - if !<player.has_flag[shovel_level]>:
            - flag <player> shovel_level:wooden
        - if !<player.has_flag[sword_level]>:
            - flag <player> sword_level:wooden
        - if !<player.has_flag[hoe_level]>:
            - flag <player> hoe_level:wooden

        - if !<player.has_flag[max_run_time]>:
            - flag <player> max_run_time:300000