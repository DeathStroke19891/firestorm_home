{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "candy";

  src = pkgs.fetchurl {
    url = "https://github.com/EliverLara/candy-icons/archive/refs/heads/master.zip";
    sha256 = "10nbgmz9p82x1vwlsyk1ir74jgwkbi71jx45w80s02sbzsfc1mbv";
  };

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out
    ${pkgs.unzip}/bin/unzip $src -d $out/
    cd $out
    cp -r candy-icons-master/* .
    rm -r candy-icons-master
  '';
}
