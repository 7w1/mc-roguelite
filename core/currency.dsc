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

my_command:
    type: command
    name: balance
    description: Display your currencies!
    usage: /balance
    aliases:
        - bal
        - bals
        - balances
        - currency
        - money
        - stars
        - wealth
    script:
    - narrate "<&nl><&r><&e>Your current balances:<&nl>"
    - narrate "<&r><&b> ✦ <player.flag[star_balance].format_number>"
    - narrate "<&r><&a> 💴 <player.flag[coin_balance].format_number>"
    - narrate <&nl>
