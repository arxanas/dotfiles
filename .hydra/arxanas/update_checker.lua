require "arxanas/init"

arxanas.update_checker = {}

-- Check for updates, and notify if there is an update available.
function arxanas.update_checker.check_for_updates()
  notify.register("hydra-update-available", function()
    hydra.updates.install()
  end)

  hydra.updates.check(function(is_update_available)
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
