{ lib
, fetchFromGitHub
, buildGoModule
}:

buildGoModule rec {

  pname = "zju-connect-fork";
  version = "0.7.1";
  
  src = fetchFromGitHub ({
    owner = "chenx-dust";
    repo = "zju-connect";
    rev = "02756ae5d86dabe5966a9be9482c43c5020abca1";
    fetchSubmodules = false;
    sha256 = "sha256-xFy47JHYqTP8hu0ZbeREFMAKlqefMgqcDJFVAPJBo6Y=";
  });
  
  vendorHash = "sha256-Y4QrgFie1vr7sdvX7IVfyps9fJFPzzKQoeXDXCnbmK4=";

  meta = with lib; {
    description = "Zhejiang University RVPN Client in Go";
    homepage = "https://github.com/Mythologyli/zju-connect";
    license = with licenses; [ agpl3Only ];
    mainProgram = "zju-connect";
    platforms = platforms.all;
  };

}
