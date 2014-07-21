arxanas.update_checker = {}
function arxanas.update_checker.check_for_updates()
  notify.register("hydra-update-available", function()
    os.execute("open " .. updates.changelogurl)
  end)

  updates.check(function(is_update_available)
    if is_update_available then
      notify.show(
        "Hydra",
        "Update available",
        "A new update is available for Hydra!",
        "hydra-update-available"
      )
    end
  end)
end
