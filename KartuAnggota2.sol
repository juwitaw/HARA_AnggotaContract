// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Group {
    Anggota[] member;
    uint256 id = 0;

    event anggotaCreated(
        string _name,
        string _alamat,
        string _domisili,
        string _url
    );
    mapping(uint256 => Anggota) public idToAnggota;

    function createAnggota(
        string memory _name,
        string memory _alamat,
        string memory _domisili,
        string memory _url
    ) public {
        Anggota anggota = new Anggota(id, _name, _alamat, _domisili, _url);
        member.push(anggota);
        idToAnggota[id] = anggota;
        id++;
        emit anggotaCreated(_name, _alamat, _domisili, _url);
    }
}

contract Anggota {
    uint256 id;
    string name;
    string alamat;
    string domisili;
    string url;

    constructor(
        uint256 _id,
        string memory _name,
        string memory _alamat,
        string memory _domisili,
        string memory _url
    ) public {
        id = _id;
        name = _name;
        alamat = _alamat;
        domisili = _domisili;
        url = _url;
    }
}
