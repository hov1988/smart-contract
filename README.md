# 🧱 Solidity Smart Contracts – Portfolio Examples

This repository contains a collection of **production-style Solidity smart contracts**
demonstrating core Ethereum development concepts and best practices.

The goal of this project is to showcase **clean contract design**, **explicit error handling**,
**access control**, and **event-driven logic** suitable for **professional Web3 / Smart Contract engineering roles**.

---

## 🚀 Key Concepts Demonstrated

- ✅ Custom Solidity **errors** (gas-efficient vs `require`)
- ✅ **Modifiers** for access control and state validation
- ✅ **Events** for off-chain indexing and transparency
- ✅ Explicit state machines using `enum`
- ✅ ETH handling and balance safety
- ✅ Pause / emergency-stop pattern
- ✅ Clean, audit-friendly contract structure

All contracts target **Solidity `^0.8.20`**.

---

## 📁 Contracts Overview

### 1️⃣ SimpleVault.sol
**ETH vault with owner-based access control**

**Features:**
- Owner-only withdrawals
- Custom errors (`NotOwner`, `ZeroAmount`, `InsufficientBalance`)
- ETH deposits & withdrawals
- Ownership transfer
- Event emission for all state changes

**Concepts covered:**  
`modifiers`, `errors`, `events`, ETH transfers, access control

---

### 2️⃣ PausableToken.sol
**ERC20-like token with pause mechanism**

**Features:**
- Token transfers
- Pause / unpause functionality
- Owner-restricted admin actions
- Gas-efficient error handling

**Concepts covered:**  
`modifiers`, pause pattern, state validation, events

> ⚠️ This is a simplified token implementation for demonstration purposes  
> (not a full ERC20 replacement).

---

### 3️⃣ SimpleVoting.sol
**On-chain voting system**

**Features:**
- Enum-based state machine (`Active` / `Closed`)
- One-vote-per-address enforcement
- Owner-controlled lifecycle
- Explicit validation & domain logic

**Concepts covered:**  
`enum`, state machines, business logic modeling, events

---

## 🗂️ Project Structure

```text
solidity-contracts/
├── contracts/
│   ├── SimpleVault.sol
│   ├── PausableToken.sol
│   └── SimpleVoting.sol
├── test/                  # (optional) Foundry / Hardhat tests
├── README.md
├── foundry.toml           # or hardhat.config.js
└── .gitignore
