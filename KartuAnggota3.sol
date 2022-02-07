// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Group {
    address[] member;
    address[] verifiedMembers;
    uint256 id = 0;
    uint256 contractCreation;
    address owner;

   constructor() public {
        contractCreation = block.timestamp;
        owner = msg.sender;
    }

    modifier onlyOwner(address _user){
        require(owner == _user);
        _;
    }

    event anggotaCreated(
        uint _id,
        uint256 _created,
        string _name,
        string _alamat,
        string _domisili,
        string _url,
        bool verified
    );

    mapping(uint256 => Anggota) internal idToAnggota;

    function createAnggota(
        string memory _name,
        string memory _alamat,
        string memory _domisili,
        string memory _url
    ) public onlyOwner(msg.sender){
        uint256 _created = block.timestamp;
        Anggota anggota = new Anggota(id, _created,_name, _alamat, _domisili, _url, false);
        member.push(address(anggota));
        idToAnggota[id] = anggota;
        id++;
        emit anggotaCreated(id, _created,_name, _alamat, _domisili, _url, false);
    }

    function getAnggotaAddress(uint256 _id) public view returns(address){
        return (address(member[_id]));
    }

    function append(string memory a, string memory b, string memory c, string memory d) internal pure returns (string memory) {
        return string(abi.encodePacked(a," ", b," ", c," ", d," "));
    }
    function addressData(uint256 _id) public view returns(string memory){
        string memory temp = append(Anggota(member[_id]).name(), Anggota(member[_id]).alamat(), Anggota(member[_id]).domisili(), Anggota(member[_id]).url());
        return temp;

    }

    function checkVerified() internal{

        for (uint i = 0; i < member.length; i++) {
            if(now >= (Anggota(member[i]).created() + 10 seconds)){
                Anggota(member[i]).setVerified(true);
                if(verifiedMembers.length > 0){
                    for(uint a = 0; a < verifiedMembers.length; a++){
                        if(member[i] != verifiedMembers[a]){
                            verifiedMembers.push(member[i]);
                        } 
                    }
                }else{
                    verifiedMembers.push(member[i]);
                }
                
                
            }
        }

    }



    function verifiedAddress() public onlyOwner(msg.sender) returns(address[] memory){
        checkVerified();
        return verifiedMembers;
    }

    
}

contract Anggota {
    uint256 id;
    uint256 public created;
    string public name;
    string public alamat;
    string public domisili;
    string public url;
    bool public verified;

    constructor(
        uint256 _id,
        uint256 _created,
        string memory _name,
        string memory _alamat,
        string memory _domisili,
        string memory _url,
        bool _verified
    ) public {
        id = _id;
        created = _created;
        name = _name;
        alamat = _alamat;
        domisili = _domisili;
        url = _url;
        verified = _verified;
    }

    function setVerified(bool _verified) public{
        verified = _verified;
    }
}