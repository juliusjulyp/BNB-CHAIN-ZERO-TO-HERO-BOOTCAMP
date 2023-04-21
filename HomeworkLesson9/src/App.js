import { useState } from "react";
import { ethers } from "ethers";


function App() {

  //storing different states

  //let [text, setText] = useState("");
  //let [savedText, setSavedText] = useState("");

  let [connected, setConnected] = useState(false);
  const [CoinName, setCoinName] = useState("");
  const [symbol, setSymbol] = useState("");
  const [decimals, setDecimals] = useState("");
  const [totalSupply, setTotalSupply] = useState("");


  //web3 interface for interacting with ethereum smart contracts
  let { ethereum } = window
  let contract = null;


  if (ethereum) {
    let abi = [
      "function name() public view returns (string memory)",
      "function symbol() public view returns (string memory)",
      "function decimals() public view returns (uint8)",
      "function totalSupply() public view returns (uint256)",
    ];

    let address = "0x36acd8fa9eb4a86185f2c0a2483e24a5e93b5159";
    let provider = new ethers.providers.Web3Provider(ethereum);
    let signer = provider.getSigner();
    contract = new ethers.Contract(address, abi, signer);
  }

  return (
    <div className="App">

      <h1>A Contract for Badger Coin</h1>

      <button
        onClick={() => {
          if (contract && !connected) {
            ethereum
              .request({ method: "eth_requestAccounts" })
              .then((accounts) => {
                setConnected(true);
              });
          }
        }}
      >
        {!connected ? "Connect wallet" : "Connected"}
        </button>


        <h2>Contract Functions</h2>
        <button 
        onClick={() => {
          if (contract && connected){
            contract.name().then((tokenName) => {
              setCoinName(tokenName);
            });
          }
        }}
        >
          Get the name
        </button>
        <h3>{CoinName}</h3>

        <button
        onClick={() => {
          if(contract&& connected){
            contract.symbol().then((sym) => {
              setSymbol(sym);
            });
          }
        }}
        >
          Get the symbol
        </button>
        <h2>{ symbol }</h2>

        

        <button 
        onClick={() => {
          if ( contract && connected){
            contract.decimals().then((dec) =>{
              setDecimals(dec);
            });
          }
        }}
        >
          Get the decimals
        </button>
        <h2>{decimals}</h2>
        <button
        onClick={() => {
          if(contract && connected) {
            contract.totalSupply().then((supply) => {
              setTotalSupply(Number(supply));
            });
          }
        }}
        >
          Get the total supply
        </button>

        <h3>{totalSupply}</h3>
        </div>
        );
      }

      export default App;