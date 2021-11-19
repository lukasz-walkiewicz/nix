{ lib
, stdenv
, fetchurl
, graalvm11-ce
, unzip
, autoPatchelfHook
, makeWrapper
}:

stdenv.mkDerivation rec {
  pname = "mvnd";
  version = "0.7.0";

  # add multiplatform support
  src = fetchurl {
    url = "https://github.com/mvndaemon/mvnd/releases/download/0.7.0/mvnd-0.7.0-darwin-amd64.zip";
    sha256 = "2c155e03096d05af37f6134331f55ced0834728f70f7b195e1cc8c74d5403b19";
  };

  nativeBuildInputs = [ autoPatchelfHook makeWrapper unzip ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/mvnd $out/bin
    cp -ra . $out/share/mvnd
    makeWrapper $out/share/mvnd/bin/mvnd $out/bin/mvnd --set "MVND_HOME" $out/share/mvnd --set "JAVA_HOME" ${graalvm11-ce}
    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://github.com/mvndaemon/mvnd/";
    license = licenses.asl20;
    description = "The Maven Daemon";
    maintainers = maintainers; #[ lukasz-walkiewicz ];
    platforms = platforms.darwin;
  };
}
