// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract Freebet {
uint bank;
uint gameNumber = 0;
uint constant fee = 4;
uint totalBets;
uint a = 0;
address bettor;
address owner;
uint winner;
//Bet data
mapping (uint => address) betAddress;
mapping (address => uint) betValue;
mapping (address => uint) betSide;


//DRY functions
constructor() {owner = msg.sender;}

//fee
function feeDistribution() public {
//burn
address x0 = 0x0000000000000000000000000000000000000000 ;
address payable zero = payable(x0);
zero.transfer(address(this).balance / 2);
//owner's profit
address payable own = payable(owner);
own.transfer(address(this).balance);
}

function basicBet() private{
bank = bank + msg.value*(100-fee)/100;
betValue[address(bettor)] = msg.value;   
}

function withdraw(address payable _to, uint send) private{
_to.transfer(send * (100 - fee) / 100);
feeDistribution();
}
//contract

function setWinner(uint won) public{
//there will be API conneting
winner = won;
windata(won);
}

mapping(uint => address) winbase;

function giveaway() public{ 
    for(a; a <= w; a++){
        address payable current = payable(winbase[a]);
        uint value = betValue[current];
        current.transfer(value*wc/10000);
    }
}

uint winbank;
uint w;
uint n;
uint prize;
uint wc;
uint uwc;



function windata(uint wonx) private {
    while(n <= totalBets){
        if(betSide[betAddress[n]] == wonx){
            address payable current = payable(betAddress[n]);
            prize = betValue[current];
            winbank = winbank + prize;
            winbase[w] = current;
            w++;
            n++;
            continue;
        }
        
        else{
            n++;
            continue;
        }
    }
    bank = bank * 10000;
    wc = bank/winbank;
    giveaway();
}



function bet1() public payable{
totalBets++;
bettor = msg.sender;
betSide[address(msg.sender)] = 1;
betAddress[totalBets] = address(msg.sender);
basicBet(); 
}

function bet2() public payable{
totalBets++;
bettor = msg.sender;
betSide[address(msg.sender)] = 2;
betAddress[totalBets] = address(msg.sender);
basicBet();
}

function draw() public payable{
totalBets++;
bettor = msg.sender;
basicBet();
betSide[address(msg.sender)] = 3;
betAddress[totalBets] = address(msg.sender);
}
}