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

lang_data_en_US:
    type: data
    run:
        # Pre-run
        initializing: <&e>Initializing run...
        building_world: <&e>Building world...
        reset_player: <&e>Resetting player...
        apply_upgrades: <&e>Applying upgrades...
        initialized: <&a>Run initialization complete!
        good_luck: <&nl><&b><&l>Good Luck!<&nl>
        title_begin: <&a>Begin!
        # Post run
        ending: <&e>Ending run...
        ended: <&nl><&a><&l>Run over!<&nl>
        rewards_coming_soon: <&e>Rewards will be provided shortly...
        # Misc
        no_active_run: <&c>You are not currently in a run.
        already_in_run: <&c>You are already in a run.
    party:
        valid_commands: <&d>Valid party commands are: list, invite, accept, deny, leave, kick, transfer, and disband.
        not_in_party: <&d>You must be in a party to use this command.
        transfer_to_leave: <&d>Please transfer ownership to leave your party or disband to end your party.
        left_party: <&c><player.name> left the party.
        specify_player: <&d>Please specify a player.
        specify_unique_player: <&d>Please do not use yourself for party commands.
        not_leader: <&d>You must be the party leader to use this command.
        already_invited: <&d>You have already sent this player an invite. Please wait for the current invite to expire before sending another.
        recieved_invite: <&nl><&e><player.name><&d> invited you to join their party.<&nl><&d>Type <&a>/party accept <player.name><&d> to join.<&nl><&7><&o>This invite will expire in 60 seconds.<&nl>
        sent_invite: <&nl><&e><[target].name><&d> has been invited to join your party.<&nl><&7><&o>Their invite will expire in 60 seconds.<&nl>
        invite_invalid: <&d>That party invite is no longer valid.
        joined_party: <&b><player.name> has joined the party.
        no_invite: <&d>You have no active invite from that player.
        invite_invalidated: <&c>That party invite has been invalidated.'
        player_kicked: <&c><[target].name> was kicked from the party.
        transfer_not_in_party: <&d>You can only transfer ownership to someone currently in the party.
        ownership_transfered: <&b>Party ownership was transfered to <&e><[target].name><&r>.
        disbanded: <&c>Your party has been disbanded.
        list_title: <&nl><&d>Your current party<&co>
        list_content: <&sp><&sp><&sp><&sp><&d><[loop_index]>. <&r><player[<[value]>]><[value].equals[<player.flag[party_leader]>].if_true[ <&7><&o>(Party Leader)].if_false[]>
    sidebar:
        title: <&a><&l>Current Run
        0: <empty>
        1: Time left<&co>
        2: <&sp><&sp><duration[<player.flag[max_run_time].sub[<util.current_time_millis.sub[<player.flag[run_start]>]>].div[50].max[0]>t].formatted>
        7: <empty>
    shop:
        omnitool_placeholder_locked_displayname: <&c>Unlock Omnitool
        omnitool_placeholder_displayname: <&gradient[from=#ff5e5e;to=#a75eff;style=HSB]>Omnitool Upgrades!
        omnitool_placeholder_lore_locked: <&7>Click to unlock Omnitool on all future runs, and unlock it's upgrade shop!
        disabled_during_run: <&c>Shop is disabled while in a run.
        cant_afford_stars: <&c>You don't have enough stars to purchase that item.
        omnitool_upgraded: <&a>Omnitool upgraded.