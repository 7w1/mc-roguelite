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

sidebar_manager:
    type: world
    debug: false
    events:
        on delta time secondly:
            - repeat 10:
                - sidebar set title:<proc[lang].context[sidebar|title].parsed> values:<proc[sidebar_line_manager]> players:<server.online_players_flagged[run_active]> per_player
                - wait 0.1s

sidebar_line_manager:
    type: procedure
    debug: false
    script:
        - foreach <script[lang_data_<player.has_flag[language].if_true[<player.flag[language]>].if_false[en_US]>].data_key[sidebar].keys>:
            - if <[value]> != title:
                - define values:->:<script[lang_data_<player.has_flag[language].if_true[<player.flag[language]>].if_false[en_US]>].data_key[sidebar].get[<[value]>].parsed>
        - determine <[values]>