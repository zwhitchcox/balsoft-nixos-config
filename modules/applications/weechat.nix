{ pkgs, lib, config, inputs, ... }:
let
  weechat = pkgs.weechat.override {
    configure = { availablePlugins, ... }: {
      scripts = [ pkgs.weechatScripts.wee-slack ];
    };
  };
in {
  secrets-envsubst.weechat = {
    owner = "balsoft:users";
    directory = "weechat";
    template = ''
      [var]
      python.slack.auto_open_threads = "true"
      python.slack.background_load_all_history = "true"
      python.slack.channel_name_typing_indicator = "true"
      python.slack.color_buflist_muted_channels = "darkgray"
      python.slack.color_edited_suffix = "095"
      python.slack.color_reaction_suffix = "darkgray"
      python.slack.color_thread_suffix = "lightcyan"
      python.slack.colorize_private_chats = "false"
      python.slack.debug_level = "3"
      python.slack.debug_mode = "false"
      python.slack.distracting_channels = ""
      python.slack.external_user_suffix = "*"
      python.slack.files_download_location = "/home/balsoft/Downloads/slack"
      python.slack.group_name_prefix = "&"
      python.slack.map_underline_to = "_"
      python.slack.migrated = "true"
      python.slack.muted_channels_activity = "personal_highlights"
      python.slack.never_away = "false"
      python.slack.notify_usergroup_handle_updated = "false"
      python.slack.record_events = "false"
      python.slack.render_bold_as = "bold"
      python.slack.render_italic_as = "italic"
      python.slack.send_typing_notice = "true"
      python.slack.server_aliases = ""
      python.slack.shared_name_prefix = "%"
      python.slack.short_buffer_names = "false"
      python.slack.show_buflist_presence = "true"
      python.slack.show_reaction_nicks = "true"
      python.slack.slack_api_token = "$slack_api_token"
      python.slack.slack_timeout = "20000"
      python.slack.switch_buffer_on_join = "true"
      python.slack.thread_messages_in_channel = "false"
      python.slack.unfurl_auto_link_display = "both"
      python.slack.unfurl_ignore_alt_text = "false"
      python.slack.unhide_buffers_with_activity = "false"
    '';
  };

  home-manager.users.balsoft = {
    home.file.".weechat/python/autoload/notify_send.py".source =
      "${inputs.weechat-notify-send}/notify_send.py";

    home.file.".weechat/perl/autoload/multiline.pl".source =
      "${inputs.weechat-scripts}/perl/multiline.pl";

    home.file.".weechat/python/autoload/go.py".source =
      "${inputs.weechat-scripts}/python/go.py";

    home.activation.weechat = ''
      $DRY_RUN_CMD mkdir -p $HOME/.weechat
      $DRY_RUN_CMD ln -sf $VERBOSE_ARG ${config.secrets-envsubst.weechat} $HOME/.weechat/plugins.conf
    '';

    home.file.".weechat/weechat.conf".text = ''
      #
      # weechat -- weechat.conf
      #
      # WARNING: It is NOT recommended to edit this file by hand,
      # especially if WeeChat is running.
      #
      # Use /set or similar command to change settings in WeeChat.
      #
      # For more info, see: https://weechat.org/doc/quickstart
      #

      [debug]

      [startup]
      command_after_plugins = ""
      command_before_plugins = ""
      display_logo = on
      display_version = on
      sys_rlimit = ""

      [look]
      align_end_of_lines = message
      align_multiline_words = on
      bar_more_down = "++"
      bar_more_left = "<<"
      bar_more_right = ">>"
      bar_more_up = "--"
      bare_display_exit_on_input = on
      bare_display_time_format = "%H:%M"
      buffer_auto_renumber = on
      buffer_notify_default = all
      buffer_position = end
      buffer_search_case_sensitive = off
      buffer_search_force_default = off
      buffer_search_regex = off
      buffer_search_where = prefix_message
      buffer_time_format = "%H:%M:%S"
      buffer_time_same = ""
      color_basic_force_bold = off
      color_inactive_buffer = on
      color_inactive_message = on
      color_inactive_prefix = on
      color_inactive_prefix_buffer = on
      color_inactive_time = off
      color_inactive_window = on
      color_nick_offline = off
      color_pairs_auto_reset = 5
      color_real_white = off
      command_chars = ""
      command_incomplete = off
      confirm_quit = off
      confirm_upgrade = off
      day_change = on
      day_change_message_1date = "-- %a, %d %b %Y --"
      day_change_message_2dates = "-- %%a, %%d %%b %%Y (%a, %d %b %Y) --"
      eat_newline_glitch = off
      emphasized_attributes = ""
      highlight = ""
      highlight_regex = ""
      highlight_tags = ""
      hotlist_add_conditions = "''${away} || ''${buffer.num_displayed} == 0 || ''${
        "info:relay_client_count,weechat,connected"
      } > 0"
      hotlist_buffer_separator = ", "
      hotlist_count_max = 2
      hotlist_count_min_msg = 2
      hotlist_names_count = 3
      hotlist_names_length = 0
      hotlist_names_level = 12
      hotlist_names_merged_buffers = off
      hotlist_prefix = "H: "
      hotlist_remove = merged
      hotlist_short_names = on
      hotlist_sort = group_time_asc
      hotlist_suffix = ""
      hotlist_unique_numbers = on
      input_cursor_scroll = 20
      input_share = none
      input_share_overwrite = off
      input_undo_max = 32
      item_away_message = on
      item_buffer_filter = "*"
      item_buffer_zoom = "!"
      item_mouse_status = "M"
      item_time_format = "%H:%M"
      jump_current_to_previous_buffer = on
      jump_previous_buffer_when_closing = on
      jump_smart_back_to_buffer = on
      key_bind_safe = on
      key_grab_delay = 800
      mouse = on
      mouse_timer_delay = 100
      nick_color_force = ""
      nick_color_hash = djb2
      nick_color_stop_chars = "_|["
      nick_prefix = ""
      nick_suffix = ""
      paste_auto_add_newline = on
      paste_bracketed = on
      paste_bracketed_timer_delay = 10
      paste_max_lines = 1
      prefix_action = " *"
      prefix_align = right
      prefix_align_max = 0
      prefix_align_min = 0
      prefix_align_more = "+"
      prefix_align_more_after = on
      prefix_buffer_align = right
      prefix_buffer_align_max = 0
      prefix_buffer_align_more = "+"
      prefix_buffer_align_more_after = on
      prefix_error = "=!="
      prefix_join = "-->"
      prefix_network = "--"
      prefix_quit = "<--"
      prefix_same_nick = ""
      prefix_same_nick_middle = ""
      prefix_suffix = "|"
      quote_nick_prefix = "<"
      quote_nick_suffix = ">"
      quote_time_format = "%H:%M:%S"
      read_marker = line
      read_marker_always_show = off
      read_marker_string = "- "
      save_config_on_exit = on
      save_config_with_fsync = off
      save_layout_on_exit = none
      scroll_amount = 3
      scroll_bottom_after_switch = off
      scroll_page_percent = 100
      search_text_not_found_alert = on
      separator_horizontal = "-"
      separator_vertical = ""
      tab_width = 1
      time_format = "%a, %d %b %Y %T"
      window_auto_zoom = off
      window_separator_horizontal = on
      window_separator_vertical = on
      window_title = ""
      word_chars_highlight = "!\u00A0,-,_,|,alnum"
      word_chars_input = "!\u00A0,-,_,|,alnum"

      [palette]

      [color]
      bar_more = lightmagenta
      chat = default
      chat_bg = default
      chat_buffer = white
      chat_channel = white
      chat_day_change = cyan
      chat_delimiters = green
      chat_highlight = yellow
      chat_highlight_bg = magenta
      chat_host = cyan
      chat_inactive_buffer = default
      chat_inactive_window = default
      chat_nick = lightcyan
      chat_nick_colors = "cyan,magenta,green,brown,lightblue,default,lightcyan,lightmagenta,lightgreen,blue"
      chat_nick_offline = default
      chat_nick_offline_highlight = default
      chat_nick_offline_highlight_bg = blue
      chat_nick_other = cyan
      chat_nick_prefix = green
      chat_nick_self = white
      chat_nick_suffix = green
      chat_prefix_action = white
      chat_prefix_buffer = brown
      chat_prefix_buffer_inactive_buffer = default
      chat_prefix_error = yellow
      chat_prefix_join = lightgreen
      chat_prefix_more = lightmagenta
      chat_prefix_network = magenta
      chat_prefix_quit = lightred
      chat_prefix_suffix = green
      chat_read_marker = magenta
      chat_read_marker_bg = default
      chat_server = brown
      chat_tags = red
      chat_text_found = yellow
      chat_text_found_bg = lightmagenta
      chat_time = default
      chat_time_delimiters = brown
      chat_value = cyan
      chat_value_null = blue
      emphasized = yellow
      emphasized_bg = magenta
      input_actions = lightgreen
      input_text_not_found = red
      item_away = yellow
      nicklist_away = cyan
      nicklist_group = green
      separator = blue
      status_count_highlight = magenta
      status_count_msg = brown
      status_count_other = default
      status_count_private = green
      status_data_highlight = lightmagenta
      status_data_msg = yellow
      status_data_other = default
      status_data_private = lightgreen
      status_filter = green
      status_more = yellow
      status_mouse = green
      status_name = white
      status_name_ssl = lightgreen
      status_nicklist_count = default
      status_number = yellow
      status_time = default

      [completion]
      base_word_until_cursor = on
      command_inline = on
      default_template = "%(nicks)|%(irc_channels)"
      nick_add_space = on
      nick_case_sensitive = off
      nick_completer = ": "
      nick_first_only = off
      nick_ignore_chars = "[]`_-^"
      partial_completion_alert = on
      partial_completion_command = off
      partial_completion_command_arg = off
      partial_completion_count = on
      partial_completion_other = off
      partial_completion_templates = "config_options"

      [history]
      display_default = 5
      max_buffer_lines_minutes = 0
      max_buffer_lines_number = 4096
      max_commands = 100
      max_visited_buffers = 50

      [proxy]

      [network]
      connection_timeout = 60
      gnutls_ca_file = "/etc/ssl/certs/ca-certificates.crt"
      gnutls_handshake_timeout = 30
      proxy_curl = ""

      [plugin]
      autoload = "*"
      debug = off
      extension = ".so,.dll"
      path = "%h/plugins"
      save_config_on_unload = on

      [bar]
      buflist.color_bg = default
      buflist.color_delim = default
      buflist.color_fg = default
      buflist.conditions = ""
      buflist.filling_left_right = vertical
      buflist.filling_top_bottom = columns_vertical
      buflist.hidden = off
      buflist.items = "buflist"
      buflist.position = left
      buflist.priority = 0
      buflist.separator = on
      buflist.size = 0
      buflist.size_max = 0
      buflist.type = root
      fset.color_bg = default
      fset.color_delim = cyan
      fset.color_fg = default
      fset.conditions = "''${buffer.full_name} == fset.fset"
      fset.filling_left_right = vertical
      fset.filling_top_bottom = horizontal
      fset.hidden = off
      fset.items = "fset"
      fset.position = top
      fset.priority = 0
      fset.separator = on
      fset.size = 3
      fset.size_max = 3
      fset.type = window
      input.color_bg = default
      input.color_delim = cyan
      input.color_fg = default
      input.conditions = ""
      input.filling_left_right = vertical
      input.filling_top_bottom = horizontal
      input.hidden = off
      input.items = "[input_prompt]+(away),[input_search],[input_paste],input_text"
      input.position = bottom
      input.priority = 1000
      input.separator = off
      input.size = 0
      input.size_max = 0
      input.type = window
      nicklist.color_bg = default
      nicklist.color_delim = cyan
      nicklist.color_fg = default
      nicklist.conditions = "''${nicklist}"
      nicklist.filling_left_right = vertical
      nicklist.filling_top_bottom = columns_vertical
      nicklist.hidden = off
      nicklist.items = "buffer_nicklist"
      nicklist.position = right
      nicklist.priority = 200
      nicklist.separator = on
      nicklist.size = 0
      nicklist.size_max = 0
      nicklist.type = window
      status.color_bg = blue
      status.color_delim = cyan
      status.color_fg = default
      status.conditions = ""
      status.filling_left_right = vertical
      status.filling_top_bottom = horizontal
      status.hidden = off
      status.items = "[time],[buffer_last_number],[buffer_plugin],buffer_number+:+buffer_name+(buffer_modes)+{buffer_nicklist_count}+buffer_zoom+buffer_filter,scroll,[lag],[hotlist],completion"
      status.position = bottom
      status.priority = 500
      status.separator = off
      status.size = 1
      status.size_max = 0
      status.type = window
      title.color_bg = blue
      title.color_delim = cyan
      title.color_fg = default
      title.conditions = ""
      title.filling_left_right = vertical
      title.filling_top_bottom = horizontal
      title.hidden = off
      title.items = "buffer_title"
      title.position = top
      title.priority = 500
      title.separator = off
      title.size = 1
      title.size_max = 0
      title.type = window

      [layout]

      [notify]

      [filter]

      [key]
      ctrl-? = "/input delete_previous_char"
      ctrl-A = "/input move_beginning_of_line"
      ctrl-B = "/input move_previous_char"
      ctrl-C_ = "/input insert \x1F"
      ctrl-Cb = "/input insert \x02"
      ctrl-Cc = "/input insert \x03"
      ctrl-Ci = "/input insert \x1D"
      ctrl-Co = "/input insert \x0F"
      ctrl-Cv = "/input insert \x16"
      ctrl-D = "/input delete_next_char"
      ctrl-E = "/input move_end_of_line"
      ctrl-F = "/input move_next_char"
      ctrl-H = "/input delete_previous_char"
      ctrl-I = "/input complete_next"
      ctrl-J = "/input return"
      ctrl-K = "/input delete_end_of_line"
      ctrl-L = "/window refresh"
      ctrl-M = "/input return"
      ctrl-N = "/buffer +1"
      ctrl-P = "/buffer -1"
      ctrl-R = "/input search_text_here"
      ctrl-Sctrl-U = "/input set_unread"
      ctrl-T = "/input transpose_chars"
      ctrl-U = "/input delete_beginning_of_line"
      ctrl-W = "/input delete_previous_word"
      ctrl-X = "/input switch_active_buffer"
      ctrl-Y = "/input clipboard_paste"
      meta-meta-OP = "/bar scroll buflist * b"
      meta-meta-OQ = "/bar scroll buflist * e"
      meta-meta2-11~ = "/bar scroll buflist * b"
      meta-meta2-12~ = "/bar scroll buflist * e"
      meta-meta2-1~ = "/window scroll_top"
      meta-meta2-23~ = "/bar scroll nicklist * b"
      meta-meta2-24~ = "/bar scroll nicklist * e"
      meta-meta2-4~ = "/window scroll_bottom"
      meta-meta2-5~ = "/window scroll_up"
      meta-meta2-6~ = "/window scroll_down"
      meta-meta2-7~ = "/window scroll_top"
      meta-meta2-8~ = "/window scroll_bottom"
      meta-meta2-A = "/buffer -1"
      meta-meta2-B = "/buffer +1"
      meta-meta2-C = "/buffer +1"
      meta-meta2-D = "/buffer -1"
      meta-- = "/filter toggle @"
      meta-/ = "/input jump_last_buffer_displayed"
      meta-0 = "/buffer *10"
      meta-1 = "/buffer *1"
      meta-2 = "/buffer *2"
      meta-3 = "/buffer *3"
      meta-4 = "/buffer *4"
      meta-5 = "/buffer *5"
      meta-6 = "/buffer *6"
      meta-7 = "/buffer *7"
      meta-8 = "/buffer *8"
      meta-9 = "/buffer *9"
      meta-< = "/input jump_previously_visited_buffer"
      meta-= = "/filter toggle"
      meta-> = "/input jump_next_visited_buffer"
      meta-OA = "/input history_global_previous"
      meta-OB = "/input history_global_next"
      meta-OC = "/input move_next_word"
      meta-OD = "/input move_previous_word"
      meta-OF = "/input move_end_of_line"
      meta-OH = "/input move_beginning_of_line"
      meta-OP = "/bar scroll buflist * -100%"
      meta-OQ = "/bar scroll buflist * +100%"
      meta-Oa = "/input history_global_previous"
      meta-Ob = "/input history_global_next"
      meta-Oc = "/input move_next_word"
      meta-Od = "/input move_previous_word"
      meta2-11^ = "/bar scroll buflist * -100%"
      meta2-11~ = "/bar scroll buflist * -100%"
      meta2-12^ = "/bar scroll buflist * +100%"
      meta2-12~ = "/bar scroll buflist * +100%"
      meta2-15~ = "/buffer -1"
      meta2-17~ = "/buffer +1"
      meta2-18~ = "/window -1"
      meta2-19~ = "/window +1"
      meta2-1;3A = "/buffer -1"
      meta2-1;3B = "/buffer +1"
      meta2-1;3C = "/buffer +1"
      meta2-1;3D = "/buffer -1"
      meta2-1;3F = "/window scroll_bottom"
      meta2-1;3H = "/window scroll_top"
      meta2-1;3P = "/bar scroll buflist * b"
      meta2-1;3Q = "/bar scroll buflist * e"
      meta2-1;5A = "/input history_global_previous"
      meta2-1;5B = "/input history_global_next"
      meta2-1;5C = "/input move_next_word"
      meta2-1;5D = "/input move_previous_word"
      meta2-1;5P = "/bar scroll buflist * -100%"
      meta2-1;5Q = "/bar scroll buflist * +100%"
      meta2-1~ = "/input move_beginning_of_line"
      meta2-200~ = "/input paste_start"
      meta2-201~ = "/input paste_stop"
      meta2-20~ = "/bar scroll title * -30%"
      meta2-21~ = "/bar scroll title * +30%"
      meta2-23;3~ = "/bar scroll nicklist * b"
      meta2-23;5~ = "/bar scroll nicklist * -100%"
      meta2-23^ = "/bar scroll nicklist * -100%"
      meta2-23~ = "/bar scroll nicklist * -100%"
      meta2-24;3~ = "/bar scroll nicklist * e"
      meta2-24;5~ = "/bar scroll nicklist * +100%"
      meta2-24^ = "/bar scroll nicklist * +100%"
      meta2-24~ = "/bar scroll nicklist * +100%"
      meta2-3~ = "/input delete_next_char"
      meta2-4~ = "/input move_end_of_line"
      meta2-5;3~ = "/window scroll_up"
      meta2-5~ = "/window page_up"
      meta2-6;3~ = "/window scroll_down"
      meta2-6~ = "/window page_down"
      meta2-7~ = "/input move_beginning_of_line"
      meta2-8~ = "/input move_end_of_line"
      meta2-A = "/input history_previous"
      meta2-B = "/input history_next"
      meta2-C = "/input move_next_char"
      meta2-D = "/input move_previous_char"
      meta2-F = "/input move_end_of_line"
      meta2-G = "/window page_down"
      meta2-H = "/input move_beginning_of_line"
      meta2-I = "/window page_up"
      meta2-Z = "/input complete_previous"
      meta2-[E = "/buffer -1"
      meta-_ = "/input redo"
      meta-a = "/input jump_smart"
      meta-b = "/input move_previous_word"
      meta-d = "/input delete_next_word"
      meta-f = "/input move_next_word"
      meta-h = "/input hotlist_clear"
      meta-jmeta-f = "/buffer -"
      meta-jmeta-l = "/buffer +"
      meta-jmeta-r = "/server raw"
      meta-jmeta-s = "/server jump"
      meta-j01 = "/buffer *1"
      meta-j02 = "/buffer *2"
      meta-j03 = "/buffer *3"
      meta-j04 = "/buffer *4"
      meta-j05 = "/buffer *5"
      meta-j06 = "/buffer *6"
      meta-j07 = "/buffer *7"
      meta-j08 = "/buffer *8"
      meta-j09 = "/buffer *9"
      meta-j10 = "/buffer *10"
      meta-j11 = "/buffer *11"
      meta-j12 = "/buffer *12"
      meta-j13 = "/buffer *13"
      meta-j14 = "/buffer *14"
      meta-j15 = "/buffer *15"
      meta-j16 = "/buffer *16"
      meta-j17 = "/buffer *17"
      meta-j18 = "/buffer *18"
      meta-j19 = "/buffer *19"
      meta-j20 = "/buffer *20"
      meta-j21 = "/buffer *21"
      meta-j22 = "/buffer *22"
      meta-j23 = "/buffer *23"
      meta-j24 = "/buffer *24"
      meta-j25 = "/buffer *25"
      meta-j26 = "/buffer *26"
      meta-j27 = "/buffer *27"
      meta-j28 = "/buffer *28"
      meta-j29 = "/buffer *29"
      meta-j30 = "/buffer *30"
      meta-j31 = "/buffer *31"
      meta-j32 = "/buffer *32"
      meta-j33 = "/buffer *33"
      meta-j34 = "/buffer *34"
      meta-j35 = "/buffer *35"
      meta-j36 = "/buffer *36"
      meta-j37 = "/buffer *37"
      meta-j38 = "/buffer *38"
      meta-j39 = "/buffer *39"
      meta-j40 = "/buffer *40"
      meta-j41 = "/buffer *41"
      meta-j42 = "/buffer *42"
      meta-j43 = "/buffer *43"
      meta-j44 = "/buffer *44"
      meta-j45 = "/buffer *45"
      meta-j46 = "/buffer *46"
      meta-j47 = "/buffer *47"
      meta-j48 = "/buffer *48"
      meta-j49 = "/buffer *49"
      meta-j50 = "/buffer *50"
      meta-j51 = "/buffer *51"
      meta-j52 = "/buffer *52"
      meta-j53 = "/buffer *53"
      meta-j54 = "/buffer *54"
      meta-j55 = "/buffer *55"
      meta-j56 = "/buffer *56"
      meta-j57 = "/buffer *57"
      meta-j58 = "/buffer *58"
      meta-j59 = "/buffer *59"
      meta-j60 = "/buffer *60"
      meta-j61 = "/buffer *61"
      meta-j62 = "/buffer *62"
      meta-j63 = "/buffer *63"
      meta-j64 = "/buffer *64"
      meta-j65 = "/buffer *65"
      meta-j66 = "/buffer *66"
      meta-j67 = "/buffer *67"
      meta-j68 = "/buffer *68"
      meta-j69 = "/buffer *69"
      meta-j70 = "/buffer *70"
      meta-j71 = "/buffer *71"
      meta-j72 = "/buffer *72"
      meta-j73 = "/buffer *73"
      meta-j74 = "/buffer *74"
      meta-j75 = "/buffer *75"
      meta-j76 = "/buffer *76"
      meta-j77 = "/buffer *77"
      meta-j78 = "/buffer *78"
      meta-j79 = "/buffer *79"
      meta-j80 = "/buffer *80"
      meta-j81 = "/buffer *81"
      meta-j82 = "/buffer *82"
      meta-j83 = "/buffer *83"
      meta-j84 = "/buffer *84"
      meta-j85 = "/buffer *85"
      meta-j86 = "/buffer *86"
      meta-j87 = "/buffer *87"
      meta-j88 = "/buffer *88"
      meta-j89 = "/buffer *89"
      meta-j90 = "/buffer *90"
      meta-j91 = "/buffer *91"
      meta-j92 = "/buffer *92"
      meta-j93 = "/buffer *93"
      meta-j94 = "/buffer *94"
      meta-j95 = "/buffer *95"
      meta-j96 = "/buffer *96"
      meta-j97 = "/buffer *97"
      meta-j98 = "/buffer *98"
      meta-j99 = "/buffer *99"
      meta-k = "/go"
      meta-l = "/window bare"
      meta-m = "/mute mouse toggle"
      meta-n = "/window scroll_next_highlight"
      meta-p = "/window scroll_previous_highlight"
      meta-r = "/input delete_line"
      meta-s = "/mute aspell toggle"
      meta-u = "/window scroll_unread"
      meta-wmeta-meta2-A = "/window up"
      meta-wmeta-meta2-B = "/window down"
      meta-wmeta-meta2-C = "/window right"
      meta-wmeta-meta2-D = "/window left"
      meta-wmeta2-1;3A = "/window up"
      meta-wmeta2-1;3B = "/window down"
      meta-wmeta2-1;3C = "/window right"
      meta-wmeta2-1;3D = "/window left"
      meta-wmeta-b = "/window balance"
      meta-wmeta-s = "/window swap"
      meta-x = "/input zoom_merged_buffer"
      meta-z = "/window zoom"
      ctrl-_ = "/input undo"

      [key_search]
      ctrl-I = "/input search_switch_where"
      ctrl-J = "/input search_stop_here"
      ctrl-M = "/input search_stop_here"
      ctrl-Q = "/input search_stop"
      ctrl-R = "/input search_switch_regex"
      meta2-A = "/input search_previous"
      meta2-B = "/input search_next"
      meta-c = "/input search_switch_case"

      [key_cursor]
      ctrl-J = "/cursor stop"
      ctrl-M = "/cursor stop"
      meta-meta2-A = "/cursor move area_up"
      meta-meta2-B = "/cursor move area_down"
      meta-meta2-C = "/cursor move area_right"
      meta-meta2-D = "/cursor move area_left"
      meta2-1;3A = "/cursor move area_up"
      meta2-1;3B = "/cursor move area_down"
      meta2-1;3C = "/cursor move area_right"
      meta2-1;3D = "/cursor move area_left"
      meta2-A = "/cursor move up"
      meta2-B = "/cursor move down"
      meta2-C = "/cursor move right"
      meta2-D = "/cursor move left"
      @chat(python.*):D = "hsignal:slack_cursor_delete"
      @chat(python.*):L = "hsignal:slack_cursor_linkarchive"
      @chat(python.*):M = "hsignal:slack_cursor_message"
      @chat(python.*):R = "hsignal:slack_cursor_reply"
      @chat(python.*):T = "hsignal:slack_cursor_thread"
      @item(buffer_nicklist):K = "/window ''${_window_number};/kickban ''${nick}"
      @item(buffer_nicklist):b = "/window ''${_window_number};/ban ''${nick}"
      @item(buffer_nicklist):k = "/window ''${_window_number};/kick ''${nick}"
      @item(buffer_nicklist):q = "/window ''${_window_number};/query ''${nick};/cursor stop"
      @item(buffer_nicklist):w = "/window ''${_window_number};/whois ''${nick}"
      @chat:Q = "hsignal:chat_quote_time_prefix_message;/cursor stop"
      @chat:m = "hsignal:chat_quote_message;/cursor stop"
      @chat:q = "hsignal:chat_quote_prefix_message;/cursor stop"

      [key_mouse]
      @bar(buflist):ctrl-wheeldown = "hsignal:buflist_mouse"
      @bar(buflist):ctrl-wheelup = "hsignal:buflist_mouse"
      @bar(input):button2 = "/input grab_mouse_area"
      @bar(nicklist):button1-gesture-down = "/bar scroll nicklist ''${_window_number} +100%"
      @bar(nicklist):button1-gesture-down-long = "/bar scroll nicklist ''${_window_number} e"
      @bar(nicklist):button1-gesture-up = "/bar scroll nicklist ''${_window_number} -100%"
      @bar(nicklist):button1-gesture-up-long = "/bar scroll nicklist ''${_window_number} b"
      @chat(fset.fset):button1 = "/window ''${_window_number};/fset -go ''${_chat_line_y}"
      @chat(fset.fset):button2* = "hsignal:fset_mouse"
      @chat(fset.fset):wheeldown = "/fset -down 5"
      @chat(fset.fset):wheelup = "/fset -up 5"
      @chat(python.*):button2 = "hsignal:slack_mouse"
      @chat(script.scripts):button1 = "/window ''${_window_number};/script go ''${_chat_line_y}"
      @chat(script.scripts):button2 = "/window ''${_window_number};/script go ''${_chat_line_y};/script installremove -q ''${script_name_with_extension}"
      @chat(script.scripts):wheeldown = "/script down 5"
      @chat(script.scripts):wheelup = "/script up 5"
      @item(buffer_nicklist):button1 = "/window ''${_window_number};/query ''${nick}"
      @item(buffer_nicklist):button1-gesture-left = "/window ''${_window_number};/kick ''${nick}"
      @item(buffer_nicklist):button1-gesture-left-long = "/window ''${_window_number};/kickban ''${nick}"
      @item(buffer_nicklist):button2 = "/window ''${_window_number};/whois ''${nick}"
      @item(buffer_nicklist):button2-gesture-left = "/window ''${_window_number};/ban ''${nick}"
      @item(buflist):button1* = "hsignal:buflist_mouse"
      @item(buflist):button2* = "hsignal:buflist_mouse"
      @item(buflist2):button1* = "hsignal:buflist_mouse"
      @item(buflist2):button2* = "hsignal:buflist_mouse"
      @item(buflist3):button1* = "hsignal:buflist_mouse"
      @item(buflist3):button2* = "hsignal:buflist_mouse"
      @bar:wheeldown = "/bar scroll ''${_bar_name} ''${_window_number} +20%"
      @bar:wheelup = "/bar scroll ''${_bar_name} ''${_window_number} -20%"
      @chat:button1 = "/window ''${_window_number}"
      @chat:button1-gesture-left = "/window ''${_window_number};/buffer -1"
      @chat:button1-gesture-left-long = "/window ''${_window_number};/buffer 1"
      @chat:button1-gesture-right = "/window ''${_window_number};/buffer +1"
      @chat:button1-gesture-right-long = "/window ''${_window_number};/input jump_last_buffer"
      @chat:ctrl-wheeldown = "/window scroll_horiz -window ''${_window_number} +10%"
      @chat:ctrl-wheelup = "/window scroll_horiz -window ''${_window_number} -10%"
      @chat:wheeldown = "/window scroll_down -window ''${_window_number}"
      @chat:wheelup = "/window scroll_up -window ''${_window_number}"
      @*:button3 = "/cursor go ''${_x},''${_y}"
    '';

    home.packages = [ weechat ];
    wayland.windowManager.sway.config.startup = [{
      command =
        "${config.defaultApplications.term.cmd} -e ${weechat}/bin/weechat";
    }];
  };
}
