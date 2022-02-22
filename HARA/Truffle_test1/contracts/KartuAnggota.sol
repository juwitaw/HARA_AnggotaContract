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

    modifier onlyOwner(address _user) {
        require(owner == _user);
        _;
    }

    event anggotaCreated(
        uint256 _id,
        uint256 _created,
        string _name,
        string _alamat,
        string _domisili,
        string _url
        //bool verified
    );
    event UpdateVerified(
        address indexed sender,
        address[] data,
        uint256 timestamp
    );

    mapping(uint256 => Anggota) internal idToAnggota;

    //Creation of Anggota
    //Stiap anggota yg di create verified akan false secara default
    //Anggota akan menjadi verified jika sudah 3 hari
    function createAnggota(
        string memory _name,
        string memory _alamat,
        string memory _domisili,
        string memory _url
    ) public onlyOwner(msg.sender) {
        uint256 _created = block.timestamp;
        Anggota anggota = new Anggota(
            id,
            _created,
            _name,
            _alamat,
            _domisili,
            _url,
            false
        );
        member.push(address(anggota));
        idToAnggota[id] = anggota;
        id++;
        emit anggotaCreated(id, _created, _name, _alamat, _domisili, _url);
    }

    function getAnggotaAddress(uint256 _id) public view returns (address) {
        return (address(member[_id]));
    }

    function append(
        string memory a,
        string memory b,
        string memory c,
        string memory d
    ) internal pure returns (string memory) {
        return string(abi.encodePacked(a, " ", b, " ", c, " ", d, " "));
    }

    function addressData(uint256 _id) public view returns (string memory) {
        string memory temp = append(
            Anggota(member[_id]).name(),
            Anggota(member[_id]).alamat(),
            Anggota(member[_id]).domisili(),
            Anggota(member[_id]).url()
        );
        return temp;
    }

    function totalAnggota() public view returns (uint256) {
        return member.length;
    }

    /*
    //Check smua member yg ada dan push member yg sudah verifed ke verifiedMembers array.
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
    */
    function checkVerified() internal view returns (address[] memory) {
        uint256 tmp = 0;
        address[] memory tmp1 = new address[](member.length);

        for (uint256 i = 0; i < member.length; i++) {
            if ((Anggota(member[i]).created() + 5 seconds) <= block.timestamp) {
                tmp1[tmp] = member[i];
                tmp += 1;
            }
        }

        for (uint256 i = 0; i < (member.length - (tmp + 1)); i++) {
            delete tmp1[tmp1.length - 1];
        }
        // delete tmp1[tmp1.length-1];

        return tmp1;
    }

    // function testing() internal view returns (uint[] memory){
    //     uint[] memory aaa;
    //     aaa[0] = 1;
    //     aaa[1] = 2;
    //     return aaa;
    // }

    // function test() public view returns(uint[] memory){
    //     return testing();
    // }

    // Seharusnya call function, call smua anggota yg udh "verified"
    //Stiap function ini di call, akan check panggil function checkVerified untuk check anggota
    //yg sudah verified spuya dpt data yg paling recent. habis itu baru call.

    //check and update data
    function pushVerifiedAddress()
        public
        onlyOwner(msg.sender)
        returns (address[] memory)
    {
        verifiedMembers = checkVerified();
        emit UpdateVerified(msg.sender, verifiedMembers, block.timestamp);
        return verifiedMembers;
    }

    //check only
    function CheckOnlyVerifiedAddress() public view returns (address[] memory) {
        return checkVerified();
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

    function setVerified(bool _verified) public {
        verified = _verified;
    }
}
