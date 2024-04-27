{
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.system.env;
in {
  options.system.env = with types;
    mkOption {
      type = attrsOf (oneOf [str path (listOf (either str path))]);
      apply = mapAttrs (_n: v:
        if isList v
        then concatMapStringsSep ":" toString v
        else (toString v));
      default = {};
      description = "A set of environment variables to set.";
    };

  config = {
    environment = {
      variables = {
        # Make some programs "XDG" compliant.
        LESSHISTFILE = "$XDG_CACHE_HOME/less.history";
      };
      extraInit =
        concatStringsSep "\n"
        (mapAttrsToList (n: v: ''export ${n}="${v}"'') cfg);
    };
  };
}
