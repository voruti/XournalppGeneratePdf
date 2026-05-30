{
  lib ? pkgs.lib,
  perSystem,
  pkgs,
  pname,
}:

pkgs.writeShellApplication {
  name = pname;

  text = ''
    sed -e '1i#!/bin/bash' -e '1,6d' ${lib.meta.getExe perSystem.self.default} > XournalppGeneratePdf.sh
  '';
}
