// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;
// ^ - karot (0.6.x)


contract SimpleStorage {
    
    // zmiene 
    // w przypadku nie przypisania wartosc = 0
    int16 number;
    bool prawda = true;
    

    /*
    Widzialnosc zminnych https://docs.soliditylang.org/en/v0.8.10/contracts.html#visibility-and-getters
    private - widzoczne tylko w tym kontrakcie i nigdzie indziej
    internal - defaultowo, widoczne w tym i pochodnym kontrakcie (bez this)
    external - widzialne w innych kontraktach (jeżeli użycie w tym kontrakcie trzeba użyć this)
    */
    int16 numer;
    //zapisywanie
    function store(int16 _numer) public {
        numer = _numer;
    }
    
    // odczytywanie
    // view umozliwa wgląd w blockchain
    function zwroc() public view returns(int16) {
        return numer;
    }

    // pure to jedynie operacje
    function dodaj(int16 _numer) public pure {
        _numer + _numer;
    }

    // struktura
    struct People {
        string imie;
        string nazwisko;
    }

    People public person = People({imie: "Marjusz", nazwisko: "Krzak"});

    //Tablica
    // typ [rozmiar] widzialność nazwa          || jak rozmiar nie określony to jest dynamiczna
    People[] public people;

    // obiekt mapowania
    mapping(string => string) public imieDoNazwiska;
    
    //dodanie do tablicy
    // w przypadku tablicy: memory - wartosc znika po wyjściu z funkcji    |     storage - zostaje
    function addPerson(string memory _imie, string memory _nazwisko) public{
        people.push(People(_imie, _nazwisko));
        imieDoNazwiska[_imie] = _nazwisko;
    }    
    // https://rinkeby.etherscan.io/tx/0x464a2131f59eb9c65ef0f26b4672e6464fbf27c4bfa4ab4c023c15a8afee7980 :)
}