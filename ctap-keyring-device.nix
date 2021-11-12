{ lib
, stdenv
, buildPythonPackage
, fetchPypi
# , pyobjc-framework-LocalAuthentication
, cryptography
, keyring
, fido2
, pytest
, pytest-flake8
, pytest-black
, pytest-cov
}:

buildPythonPackage rec {
  pname = "ctap-keyring-device";
  version = "1.0.6";

  src = fetchPypi {
    inherit pname version;
    sha256 = "a44264bb3d30c4ab763e4a3098b136602f873d86b666210d2bb1405b5e0473f6";
  };

  propagatedBuildInputs = [
# pyobjc-framework-LocalAuthentication # needs cocoa so probably will not work
    cryptography
    keyring
    fido2
  ];

  checkInputs = [
    pytest
    pytest-flake8
    pytest-black
    pytest-cov
  ];

  pythonImportsCheck = [ "ctap_keyring_device" ];

  meta = with lib; {
    description = "CTAP (client-to-authenticator-protocol) device backed by python's keyring library";
    homepage = "https://github.com/dany74q/ctap-keyring-device";
    license = licenses.mit;
    maintainers = with maintainers; [ lukasz-walkiewicz ];
    platforms = stdenv.lib.platforms.unix;
  };
}
