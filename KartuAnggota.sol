// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract KartuAnggota {
    struct Anggota {
        uint256 id;
        string nama;
        string alamat;
        string domisili;
        string url;
    }

    Anggota[] public anggota;
    uint256 idAnggota = 0;
    event NewAnggota(
        uint256 _id,
        string _name,
        string _alamat,
        string _domisili,
        string _url
    );

    mapping(string => string) public anggotaToAlamat;
    mapping(string => string) public anggotaToDomisili;
    mapping(string => string) public anggotaToUrl;

    function _createAnggota(
        string memory _name,
        string memory _alamat,
        string memory _domisili,
        string memory _url
    ) public {
        anggota.push(Anggota(idAnggota, _name, _alamat, _domisili, _url));
        anggotaToAlamat[_name] = _alamat;
        anggotaToDomisili[_name] = _domisili;
        anggotaToUrl[_name] = _url;
        emit NewAnggota(idAnggota, _name, _alamat, _domisili, _url);
        idAnggota++;
    }
}
