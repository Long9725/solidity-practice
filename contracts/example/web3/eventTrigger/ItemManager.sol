pragma solidity ^0.6.0;

contract Ownable {
    address payable _owner;
    
    constructor() public {
        _owner = msg.sender;
    }

    modifier onlyOwner() {
        require(isOwner(), "You are not the owner");
        _;
    }

    function isOwner() public view returns(bool) {
        return (msg.sender == _owner);
    }
}

contract Item {
    uint public priceInWei;
    uint public pricePaid;
    uint public index;

    ItemManager parentContract;

    constructor(ItemManager _parentContract, uint _priceInWei, uint _index) public {
        priceInWei = _priceInWei;
        index = _index;
        parentContract = _parentContract;
    }

    receive() external payable {
        /*
            address(parentContract).transfer(msg.value);

            위 코드는 ItemManager에서 어떤 아이템에 대한 돈을 보냈는지 알 수 없다.
        */
        require(pricePaid == 0, "Items is paid already");
        require(priceInWei == msg.value, "Only full payments allowed");
        pricePaid += msg.value;
        /*
            더 많은 가스를 얻기 위해서 저수준 함수를 사용하지만, 예외가 발생하더라도 문제를 발생시키지 않기 때문에 조심해야 한다.
            밑 코드의 원형은 (bool, returns of SignatureFunction) = address(address).call.value(value)(abi.encodeWithSignature(signature, parameters));
            인 것 같다.
        */
        (bool success, ) = address(parentContract).call.value(msg.value)(abi.encodeWithSignature("triggerPayment(uint256)", index));
        require(success, "The transaction wasn't successful, canceling");
    }

    fallback() external {

    }
}

contract ItemManager is Ownable {

    enum SupplyChainState{Created, Paid, Delivered}

    struct S_Item {
        Item _item;
        string _identifier;
        uint _itemPrice;
        ItemManager.SupplyChainState _state;
    }

    mapping(uint => S_Item) public items;
    uint itemIndex;

    event SupplyChainStep(uint _itemPrice, uint _step, address _itemAddress);

    function createItem(string memory _identifier, uint _itemPrice) public onlyOwner {
        Item item = new Item(this, _itemPrice, itemIndex);

        items[itemIndex]._item = item;
        items[itemIndex]._identifier = _identifier;
        items[itemIndex]._itemPrice = _itemPrice;
        items[itemIndex]._state = SupplyChainState.Created;

        emit SupplyChainStep(itemIndex, uint(items[itemIndex]._state), address(item));
        itemIndex++;
    }

    function triggerPayment(uint _itemIndex) public payable {
        require(items[_itemIndex]._itemPrice == msg.value, "Only full payments accepted");
        require(items[_itemIndex]._state == SupplyChainState.Created, "Item is further in the chain");
        items[_itemIndex]._state = SupplyChainState.Paid;

        emit SupplyChainStep(_itemIndex, uint(items[itemIndex]._state), address(items[_itemIndex]._item));
    }

    function triggerDelivery(uint _itemIndex) public onlyOwner {
        require(items[_itemIndex]._state == SupplyChainState.Paid, "Item is further in the chain");
        items[_itemIndex]._state = SupplyChainState.Delivered;

        emit SupplyChainStep(_itemIndex, uint(items[itemIndex]._state), address(items[_itemIndex]._item));
    }
}