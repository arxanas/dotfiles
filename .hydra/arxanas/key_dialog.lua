require "arxanas/init"

arxanas.key_dialog = {}

function arxanas.key_dialog.show(message, callback, styles)
  styles = styles or {}
  styles.font = styles.font or "Menlo"
  styles.font_size = styles.font_size or 54
  styles.bg = styles.bg or "000000"
  styles.fg = styles.fg or "aaaaaa"

  local dialog = textgrid:create()
  dialog:keydown(function(key_info)
    callback(key_info)
    dialog:destroy()
  end)

  dialog:sethastitlebar(false)
  dialog:sethasborder(false)
  dialog:sethasshadow(false)
  dialog:usefont(styles.font, styles.font_size)
  dialog:resize({w = message:len() + 2, h = 3})
  dialog:center()
  dialog:setbg(styles.bg)
  dialog:setfg(styles.fg)

  -- Write the message.
  for i = 1, string.len(message) do
    dialog:setchar(message:sub(i, i), i + 1, 2)
  end

  dialog:show()
  dialog:window():focus()

  return dialog
end
