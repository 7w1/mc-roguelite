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

narrate_to_party:
    type: task
    definitions: messageKey
    script:
        - foreach <player[<player.flag[party_leader]>].flag[party_members]>:
            - narrate <proc[lang].context[<[messageKey].split[.].limit[2]>].parsed> targets:<player[<[value]>]>

chat_to_party:
    type: task
    definitions: messageKey
    script:
        - foreach <player[<player.flag[party_leader]>].flag[party_members]>:
            - narrate "<&d>Party<&r> <player.name>: <[messageKey]>" targets:<player[<[value]>]>

narrate_to_player:
    type: task
    debug: false
    definitions: messageKey|player
    script:
        - narrate <proc[lang].context[<[messageKey].split[.].limit[2]>].parsed> targets:<[player].if_null[<player>]>

title_to_player:
    type: task
    debug: false
    definitions: messageKey|player
    script:
        - title title:<proc[lang].context[<[messageKey].split[.].limit[2]>].parsed> targets:<[player].if_null[<player>]>

lang:
    type: procedure
    definitions: group|child
    debug: false
    script:
        - if <[child]> != null:
            - determine <script[lang_data_<player.has_flag[language].if_true[<player.flag[language]>].if_false[en_US]>].data_key[<[group]>].get[<[child]>]>
        - else:
            - determine <script[lang_data_<player.has_flag[language].if_true[<player.flag[language]>].if_false[en_US]>].data_key[<[group]>]>

lang_key:
    type: procedure
    definitions: key
    debug: false
    script:
        - if <[key]> != null:
            - determine <proc[lang].context[<[key].split[.].limit[2]>].parsed>