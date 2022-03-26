{
  description = ''Text string translation from free online crowdsourced API. Tinyslation a tiny translation.'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-translation-0_2_0.flake = false;
  inputs.src-translation-0_2_0.ref   = "refs/tags/0.2.0";
  inputs.src-translation-0_2_0.owner = "juancarlospaco";
  inputs.src-translation-0_2_0.repo  = "nim-tinyslation";
  inputs.src-translation-0_2_0.dir   = "";
  inputs.src-translation-0_2_0.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-translation-0_2_0"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-translation-0_2_0";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}