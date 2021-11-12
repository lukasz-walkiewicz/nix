{ lib
, buildPythonPackage
, fetchurl
, boto3
, python-dateutil
, beautifulsoup4
, configparser
, keyring
, requests
, fido2
, okta
, ctap-keyring-device
, responses
, nose
}:

buildPythonPackage rec {
  pname = "gimme_aws_creds";
  version = "2.4.3";

  src = fetchurl {
    # gimme_aws_creds publish artifact with spaces
    url = "https://files.pythonhosted.org/packages/d9/c1/3b744022fe388e95d9f7011c26a1f5d2a844c1a49e385403350f3e9d0815/gimme%20aws%20creds-2.4.3.tar.gz";
    name = "gimme-aws-creds-2.4.3.tar.gz";
    sha256 = "4efd68f3e4f74672b4dc69595307a2abe34600f9d91ce18f202b069407fd0b69";
  };

  propagatedBuildInputs = [
    boto3
    python-dateutil
    beautifulsoup4
    configparser
    keyring
    requests
    fido2
#okta
    ctap-keyring-device
  ];

  checkInputs = [
    responses
    nose
  ];

  pythonImportsCheck = [ "gimme_aws_creds" ];

  meta = with lib; {
    description = "A CLI to get temporary AWS credentials from Okta";
    homepage = "https://github.com/Nike-Inc/gimme-aws-creds";
    license = licenses.asl20;
    maintainers = with maintainers; [ lukasz-walkiewicz ];
  };
}
