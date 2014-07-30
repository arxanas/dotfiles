-- Namespace for my stuff.
arxanas = {}

if not douserfile then
  function douserfile(package_name)
    dofile(package.searchpath(package_name, package.path))
  end
end
