{ lib
, buildPythonPackage
, fetchPypi
, aiohttp
, flatdict
, pyyaml
, xmltodict
, yarl
, pycryptodome
, python-jose
, aenum
, pydash
, flake8
, pytest
, pytest-asyncio
, pytest-mock
, pytest-recording
, pyfakefs
, aenum
, pydash
}:

buildPythonPackage rec {
  pname = "okta";
  version = "2.2.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "0fdb3e47dbf99dc168624fde9180dab778d14414db2e21236646b7921a8bbfd2";
  };

  propagatedBuildInputs = [
    buildPythonPackage
    fetchPypi
    aiohttp
    flatdict
    pyyaml
    xmltodict
    yarl
    pycryptodome
    python-jose
    aenum
    pydash
    flake8
  ];

  checkInputs = [
    pytest
    pytest-asyncio
    pytest-mock
    pytest-recording
    pyfakefs
    aenum
    pydash
  ];

  pythonImportsCheck = [ "okta" ];

  meta = with lib; {
    description = "Python SDK for the Okta Management API";
    homepage = "https://github.com/okta/okta-sdk-python";
    license = licenses.asl20;
    maintainers = with maintainers; [ lukasz-walkiewicz ];
  };
}
