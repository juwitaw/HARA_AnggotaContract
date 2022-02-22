const Group = artifacts.require("Group");

contract("KartuAnggota", accounts => {

    it("it should create an Anggota", async () => {
        let instance = await Group.new();
        let anggota = await instance.createAnggota("jo", "test", "test", "test");
        let idTest = await instance.totalAnggota();


        var assert = require('assert');
        assert(idTest > 0, "Anggota has not been created ye since the ID is still 0");
    })

    it("it should get the address data", async () => {
        let instance = await Group.deployed();
        let anggota = await instance.createAnggota("jo", "test", "test", "test");
        let temp = await instance.addressData(0);



        var assert = require('assert');
        assert(temp.length > 0, "Didnt get the data of the address");
    })

    it("it should get the ID address", async () => {
        let instance = await Group.deployed();
        let anggota = await instance.createAnggota("jo", "test", "test", "test");
        let temp = await instance.getAnggotaAddress(0);



        var assert = require('assert');
        assert(temp.length > 0, "Didnt get the anggota address");
    })
})