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

shop:
  type: command
  name: shop
  description: Opens the shop.
  usage: /shop
  script:
  - if <player.has_flag[run_active]>:
    - run narrate_to_player def:shop.disabled_during_run
  - else:
    - inventory open d:shop_main_menu

shop_main_menu:
    type: inventory
    inventory: chest
    gui: true
    definitions:
      f: black_stained_glass_pane
      p: purple_stained_glass_pane
    slots:
    - [f] [f] [f] [f] [f] [f] [f] [f] [f]
    - [f] [p] [omnitool_placeholder_locked] [p] [skeleton_skull] [p] [gold_ingot] [p] [f]
    - [f] [f] [f] [f] [f] [f] [f] [f] [f]

shop_main_menu_script:
  type: world
  events:
    after player opens shop_main_menu:
      - if <player.has_flag[omnitool_unlocked]>:
        - inventory set origin:<item[omnitool_placeholder]> slot:12 d:<player.open_inventory>
    after player clicks omnitool_placeholder_locked in shop_main_menu:
      - if <player.flag[star_balance].is_more_than_or_equal_to[5]>:
        - flag <player> star_balance:-:5
        - flag <player> omnitool_unlocked:true
        - inventory set origin:<item[omnitool_placeholder]> slot:12 d:<player.open_inventory>
    after player clicks omnitool_placeholder in shop_main_menu:
      - inventory close
      - inventory open d:omnitool_shop

omnitool_shop:
  type: inventory
  inventory: chest
  gui: true
  definitions:
    f: black_stained_glass_pane
  slots:
    - [f] [f] [f] [f] [f] [f] [f] [f] [f]
    - [f] [f] [] [] [] [] [] [f] [f]
    - [f] [f] [f] [f] [f] [f] [f] [f] [f]

omnitool_placeholder:
  type: item
  material: iron_pickaxe
  display name: <proc[lang_key].context[shop.omnitool_placeholder_displayname]>
  enchantments:
    - unbreaking:10

omnitool_placeholder_locked:
  type: item
  material: iron_pickaxe
  display name: <proc[lang_key].context[shop.omnitool_placeholder_displayname_locked]>
  lore:
    - <proc[lang_key].context[shop.omnitool_placeholder_lore_locked]>

omnitool_shop_script:
  type: world
  events:
    after player opens omnitool_shop:
      - inventory set origin:<item[<player.flag[shovel_level]>_shovel_omnitool]> slot:12 d:<player.open_inventory>
      - inventory set origin:<item[<player.flag[axe_level]>_axe_omnitool]> slot:13 d:<player.open_inventory>
      - inventory set origin:<item[<player.flag[pickaxe_level]>_pickaxe_omnitool]> slot:14 d:<player.open_inventory>
      - inventory set origin:<item[<player.flag[sword_level]>_sword_omnitool]> slot:15 d:<player.open_inventory>
      - inventory set origin:<item[<player.flag[hoe_level]>_hoe_omnitool]> slot:16 d:<player.open_inventory>

      - define shovel_cost <proc[calc_omnitool_upgrade_cost].context[<list[shovel|<player.flag[shovel_level]>]>]>
      - define axe_cost <proc[calc_omnitool_upgrade_cost].context[<list[axe|<player.flag[axe_level]>]>]>
      - define pickaxe_cost <proc[calc_omnitool_upgrade_cost].context[<list[pickaxe|<player.flag[pickaxe_level]>]>]>
      - define sword_cost <proc[calc_omnitool_upgrade_cost].context[<list[sword|<player.flag[sword_level]>]>]>
      - define hoe_cost <proc[calc_omnitool_upgrade_cost].context[<list[hoe|<player.flag[hoe_level]>]>]>

      - inventory adjust slot:12 lore:<player.flag[star_balance].is_more_than_or_equal_to[<[shovel_cost]>].if_true[<&a>Click to upgrade for <&b><[shovel_cost]> ✦<&a>!].if_false[<&c>Upgrade cost: <&b><[shovel_cost]> ✦]> d:<player.open_inventory>
      - inventory adjust slot:13 lore:<player.flag[star_balance].is_more_than_or_equal_to[<[axe_cost]>].if_true[<&a>Click to upgrade for <&b><[axe_cost]> ✦<&a>!].if_false[<&c>Upgrade cost: <&b><[axe_cost]> ✦]> d:<player.open_inventory>
      - inventory adjust slot:14 lore:<player.flag[star_balance].is_more_than_or_equal_to[<[pickaxe_cost]>].if_true[<&a>Click to upgrade for <&b><[pickaxe_cost]> ✦<&a>!].if_false[<&c>Upgrade cost: <&b><[pickaxe_cost]> ✦]> d:<player.open_inventory>
      - inventory adjust slot:15 lore:<player.flag[star_balance].is_more_than_or_equal_to[<[sword_cost]>].if_true[<&a>Click to upgrade for <&b><[sword_cost]> ✦<&a>!].if_false[<&c>Upgrade cost: <&b><[sword_cost]> ✦]> d:<player.open_inventory>
      - inventory adjust slot:16 lore:<player.flag[star_balance].is_more_than_or_equal_to[<[hoe_cost]>].if_true[<&a>Click to upgrade for <&b><[hoe_cost]> ✦<&a>!].if_false[<&c>Upgrade cost: <&b><[hoe_cost]> ✦]> d:<player.open_inventory>
    after player clicks item in omnitool_shop slot:12:
      - define cost <proc[calc_omnitool_upgrade_cost].context[<list[shovel|<player.flag[shovel_level]>]>]>
      - if <player.flag[star_balance].is_less_than[<[cost]>]>:
        - run narrate_to_player def:shop.cant_afford_stars
      - else:
        - flag <player> star_balance:-:<[cost]>
        - run narrate_to_player def:shop.omnitool_upgraded
        - run upgrade_omnitool def:shovel
        - inventory close
    after player clicks item in omnitool_shop slot:13:
      - define cost <proc[calc_omnitool_upgrade_cost].context[<list[axe|<player.flag[axe_leve]>]>]>
      - if <player.flag[star_balance].is_less_than[<[cost]>]>:
        - run narrate_to_player def:shop.cant_afford_stars
      - else:
        - flag <player> star_balance:-:<[cost]>
        - run narrate_to_player def:shop.omnitool_upgraded
        - run upgrade_omnitool def:axe
        - inventory close
    after player clicks item in omnitool_shop slot:14:
      - define cost <proc[calc_omnitool_upgrade_cost].context[<list[pickaxe|<player.flag[pickaxe_level]>]>]>
      - if <player.flag[star_balance].is_less_than[<[cost]>]>:
        - run narrate_to_player def:shop.cant_afford_stars
      - else:
        - flag <player> star_balance:-:<[cost]>
        - run narrate_to_player def:shop.omnitool_upgraded
        - run upgrade_omnitool def:pickaxe
        - inventory close
    after player clicks item in omnitool_shop slot:15:
      - define cost <proc[calc_omnitool_upgrade_cost].context[<list[sword|<player.flag[sword_level]>]>]>
      - if <player.flag[star_balance].is_less_than[<[cost]>]>:
        - run narrate_to_player def:shop.cant_afford_stars
      - else:
        - flag <player> star_balance:-:<[cost]>
        - run narrate_to_player def:shop.omnitool_upgraded
        - run upgrade_omnitool def:sword
        - inventory close
    after player clicks item in omnitool_shop slot:16:
      - define cost <proc[calc_omnitool_upgrade_cost].context[<list[hoe|<player.flag[hoe_level]>]>]>
      - if <player.flag[star_balance].is_less_than[<[cost]>]>:
        - run narrate_to_player def:shop.cant_afford_stars
      - else:
        - flag <player> star_balance:-:<[cost]>
        - run narrate_to_player def:shop.omnitool_upgraded
        - run upgrade_omnitool def:hoe
        - inventory close

calc_omnitool_upgrade_cost:
  type: procedure
  definitions: type|level
  script:
    - if <[level]> == wooden:
      - define cost 10
    - if <[level]> == stone:
      - define cost 25
    - if <[level]> == iron:
      - define cost 50
    - if <[level]> == diamond:
      - define cost 100
    - if <[level]> == netherite:
      - define cost 9999999
    - determine <[cost]>

upgrade_omnitool:
  type: task
  definitions: type
  script:
    - if <player.flag[<[type]>_level].equals[diamond]>:
      - flag player <[type]>_level:netherite
    - if <player.flag[<[type]>_level].equals[iron]>:
      - flag player <[type]>_level:diamond
    - if <player.flag[<[type]>_level].equals[stone]>:
      - flag player <[type]>_level:iron
    - if <player.flag[<[type]>_level].equals[wooden]>:
      - flag player <[type]>_level:stone