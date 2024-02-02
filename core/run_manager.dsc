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

begin_run:
    type: command
    name: beginrun
    description: Begin a new run.
    usage: /beginrun
    aliases:
        - br
    script:
    - if !<player.has_flag[run_active]>:
        - flag <player> run_active
        - flag <player> run_start:<util.current_time_millis>

        - define target <player>
        - run narrate_to_player def:run.initializing
        - inventory clear
        - cast blindness amplifier:10 duration:infinite
        - cast slow amplifier:10 duration:infinite

        - run narrate_to_player def:run.building_world
        - createworld <player.uuid>
        - teleport <player> <world[<player.uuid>].spawn_location>

        - run narrate_to_player def:run.reset_player
        - heal
        - feed
        - experience set 0
        - run reset_advancements def:<player>

        - run narrate_to_player def:run.apply_upgrades
        - if <player.has_flag[omnitool_unlocked]>:
            - give <player.flag[pickaxe_level]>_pickaxe_omnitool

        - run narrate_to_player def:run.initialized
        - foreach <player.effects_data>:
            - cast <[value].get[type]> remove

        - run narrate_to_player def:run.good_luck
        - run title_to_player def:run.title_begin
    - else:
        - run narrate_to_player def:run.already_in_run

force_end:
    type: command
    name: forceend
    description: End your run immediately, gaining all relevent rewards.
    usage: /forceend
    aliases:
        - fe
        - end
    script:
        - if <player.has_flag[run_active]>:
            - run end_run
        - else:
            - run narrate_to_player def:run.no_active_run

end_run:
    type: task
    script:
        - run narrate_to_player def:run.ending
        - inventory clear
        - teleport <player> <world[world].spawn_location>
        - adjust <world[<player.uuid>]> destroy
        - if <player.has_flag[nether_generated]>:
            - adjust <world[<player.uuid>_nether]> destroy
            - flag <player> nether_generated:!
        - if <player.has_flag[the_end_generated]>:
            - adjust <world[<player.uuid>_the_end]> destroy
            - flag <player> the_end_generated:!
        - run narrate_to_player def:run.ended
        - run narrate_to_player def:run.rewards_coming_soon
        - flag <player> run_active:!
        - sidebar remove

run_status_checker:
    type: world
    debug: false
    events:
        on delta time secondly:
            - repeat 10:
                - foreach <server.players_flagged[run_active]> as:__player:
                    - if <player.flag[max_run_time].is_less_than_or_equal_to[<util.current_time_millis.sub[<player.flag[run_start]>]>]>:
                        - run end_run

portal_override:
    type: world
    events:
        on entity teleported by portal:
        - define player <player[<context.entity.location.world.name.split[_].get[1]>]||null>
        - if <[player]> != null:
            - if <context.target_world.equals[<world[world]>]>:
                    - determine TARGET_WORLD:<[player].uuid>
            - if <context.portal_type.equals[NETHER]>:
                - if !<[player].has_flag[nether_generated]>:
                    - createworld <[player].uuid>_nether environment:NETHER
                    - flag <[player]> nether_generated:true
                - determine TARGET_WORLD:<[player].uuid>_nether
            - else if <context.portal_type.equals[THE_END]>:
                - if !<[player].has_flag[the_end_generated]>:
                    - createworld <[player].uuid>_the_end environment:THE_END
                    - flag <[player]> the_end_generated:true
                - determine TARGET_WORLD:<[player].uuid>_the_end