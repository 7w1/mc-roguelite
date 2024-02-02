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

party_command:
    type: command
    name: party
    description: Party management.
    usage: /party <&lt>command<&gt> <&lt>player<&gt>
    aliases:
        - p
    tab completions:
        1: list|invite|accept|deny|leave|kick|transfer|disband
        2: <server.online_players.parse[name]>
    script:
    - define command <context.args.get[1]||null>
    - if <[command].equals[null]>:
        - run narrate_to_player def:party.valid_commands
        - stop
    - if !<[command].equals[list]>:
        - if <[command].equals[leave]>:
            - if !<player.has_flag[party_active]>:
                - run narrate_to_player def:party.not_in_party
                - stop
            - if <player.flag[party_leader].equals[<player.uuid>]>:
                - run narrate_to_player def:party.transfer_to_leave
                - stop
            - run narrate_to_party def:party.left_party
            - flag <player> party_active:!
            - flag <player[<player.flag[party_leader]>]> party_members:<-:<player.uuid>
            - flag <player> party_leader:!
            - stop
        - if <[command].equals[disband]>:
            - if !<player.has_flag[party_active]>:
                - run narrate_to_player def:party.not_in_party
                - stop
            - if !<player.flag[party_leader].equals[<player.uuid>]>:
                - run narrate_to_player def:party.not_leader
                - stop
            - run narrate_to_party def:party.disbanded
            - foreach <player.flag[party_members]>:
                - flag <player[<[value]>]> party_leader:!
                - flag <player[<[value]>]> party_active:!
            - flag <player> party_members:!
            - stop
        - define target <player[<context.args.get[2]>]||null>
        - if <[target].equals[null]>:
            - run narrate_to_player def:party.specify_player
            - stop
        - if <[target].uuid.equals[<player.uuid>]>:
            - run narrate_to_player def:party.specify_unique_player
            - stop
        - if <[command].equals[invite]>:
            - if <player.has_flag[party_leader]> && !<player.flag[party_leader].equals[<player.uuid>]>:
                - run narrate_to_player def:party.not_leader
                - stop
            - if <[target].has_flag[<player.uuid>_party_invite]>:
                - run narrate_to_player def:party.already_invited
                - stop
            - flag <[target]> <player.uuid>_party_invite:true expire:60s
            - run narrate_to_player def:party.recieved_invite|<[target]>
            - run narrate_to_player def:party.sent_invite defmap:<map[target=<[target]>]>
            - stop
        - if <[command].equals[accept]>:
            - if <player.has_flag[<[target].uuid>_party_invite]>:
                - if !<[target].has_flag[party_active]>:
                    - flag <[target]> party_active:true
                    - flag <[target]> party_leader:<[target].uuid>
                - else if !<[target].flag[party_leader].equals[<[target].uuid>]>:
                    - run narrate_to_player def:party.invite_invalid
                    - stop
                - flag <player> party_active:true
                - flag <player> party_leader:<[target].uuid>
                - flag <[target]> party_members:->:<player.uuid>
                - run narrate_to_party def:party.joined_party
                - stop
            - run narrate_to_player def:party.no_invite
            - stop
        - if <[command].equals[deny]>:
            - flag <player> <[target].uuid>_party_invite:!
            - run narrate_to_player def:party.invite_invalidated
            - stop
        - if <[command].equals[kick]>:
            - if !<player.has_flag[party_active]>:
                - run narrate_to_player def:party.not_in_party
                - stop
            - if !<player.flag[party_leader].equals[<player.uuid>]>:
                - run narrate_to_player def:party.not_leader
                - stop
            - run narrate_to_party def:party.player_kicked defmap:<map[target=<[target]>]>
            - flag <[target]> party_active:!
            - flag <player> party_members:<-:<player.uuid>
            - flag <[target]> party_leader:!
            - stop
        - if <[command].equals[transfer]>:
            - if !<player.has_flag[party_active]>:
                - run narrate_to_player def:party.not_in_party
                - stop
            - if !<player.flag[party_leader].equals[<player.uuid>]>:
                - run narrate_to_player def:party.not_leader
                - stop
            - if !<player.flag[party_members].contains[<[target].uuid>]>:
                - run narrate_to_player def:party.transfer_not_in_party
                - stop
            - run narrate_to_party def:party.ownership_transferred defmap:<map[target=<[target]>]>
            - foreach <player.flag[party_members]>:
                - flag <player[<[value]>]> party_leader:<[target].uuid>
            - flag <[target]> party_members:<player.flag[party_members]>
            - flag <player> party_members:!
            - stop
    - else:
        - if <player.has_flag[party_active]>:
            - run narrate_to_player def:party.list_title
            - foreach <player[<player.flag[party_leader]>].flag[party_members]>:
                - run narrate_to_player def:party.list_content defmap:<map[loop_index=<[loop_index]>;value=<[value]>]>
            - narrate <&nl>
        - else:
            - run narrate_to_player def:party.not_in_party