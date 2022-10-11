    // SPDX-License-Identifier: MIT
    import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
    import "@openzeppelin/contracts/access/Ownable.sol";
    import "@openzeppelin/contracts/utils/math/SafeMath.sol"; //matematik işlemleri için import edildi
    import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
    
    pragma solidity ^0.8.4;
    pragma abicoder v2;
    
    contract NftMinter is ERC721, Ownable, ERC721Enumerable {
      using SafeMath for uint256; // safemath dahil edildi
      using Strings for uint256; // strnig dahil edildi 
    
      uint256 public constant tokenPrice = 1900000000000000; // 0.0019 ETH // token ücreti wei cinsinden
      uint256 public constant maxTokenPurchase = 2; // bir kullanıcı en faza kaç tane nft mintleyecek
      uint256 public constant MAX_TOKENS = 10; //toplam kaç nft var
    
      string public baseURI = ""; // tüm nftler satıldıktna sonra bu url adresi değiştirilmelidir. 
      //ilk mintlendiğinde soru işareti resmi olacak eğer gerçek base url görebilirse gdip o adresten 
      // nftye bakabilir o yüzden bu adres sonradan değiştirilmesi gerekiyor.

    
      bool public saleIsActive = false; // satış açık mı kapalı mı?
      bool public presaleIsActive = false;  //önsatış açık mı kapalı mı?
      bool public isRevealed = false; // soru işareti görseli için gereklidir. sonrada true yada false yapabiliriz
    
      mapping(address => bool) private _presaleList; //önsatış listemize ekleyeceğimiz adresleri tutuyoruz
      mapping(address => uint256) private _presaleListClaimed; //önsatış listemize ekleyeceğimiz adresleri tutuyoruz
    
      uint256 public presaleMaxMint = 2; // önsatışda max kaç adet mintleyebilir?
      uint256 public devReserve = 64; //TODO:sil
    
      event NftMinted(uint256 tokenId, address owner);
    
      constructor() ERC721("AkbankWeb3 NFT Minter", "PTKA") {} //NFT'mizin adı ve sembolü
    
      function _baseURI() internal view virtual override returns (string memory) {
        return baseURI; //NFT'mizin url adresidir.
      }
    
      function setBaseURI(string memory _newBaseURI) public onlyOwner {
        baseURI = _newBaseURI; //contract sahibi set edebilir
      }
    
      function withdraw() public payable onlyOwner { // içerdeki tüm parayı hesaba gönderir sadece cotract sahibi çalıştırabilir.
        (bool os, ) = payable(owner()).call{ value: address(this).balance }("");
        require(os);
      }
    
      function reveal() public onlyOwner {
        isRevealed = true; //reveal'ın true yada false olmasına göre token url değiştiriliyor
      }
    
    
      function toggleSaleState() external onlyOwner {
        saleIsActive = !saleIsActive;  //satışı aktif edebiliyor yada pasif edebiliyoruz, sadece contract sahibi çalıştırabilir
      }
    
      function togglePresaleState() external onlyOwner {
        presaleIsActive = !presaleIsActive; //ön satışı aktif edebiliyor yada pasif edebiliyoruz, sadece contract sahibi çalıştırabilir
      }
    
    //owner'a ait olan tokenlerin listesini döndürüyoruz. (1,2,3 id li tokenler owner'a ait gibi)
      function tokensOfOwner(address _owner)
        external
        view
        returns (uint256[] memory)
      {
        uint256 tokenCount = balanceOf(_owner);
        if (tokenCount == 0) {
          //boş dizi döndürüyor
          return new uint256[](0);
        } else {
          uint256[] memory result = new uint256[](tokenCount);
          uint256 index;
          for (index = 0; index < tokenCount; index++) {
            result[index] = tokenOfOwnerByIndex(_owner, index);
          }
          return result;
        }
      }
    
      // satışda kullanıdığımız mint metodu
      function mintNFT(uint256 numberOfTokens) external payable {
        require(saleIsActive, "Henuz satis aktif degil!");
        require(
          numberOfTokens > 0 && numberOfTokens <= maxTokenPurchase,
          "Bir seferde yalnizca bir veya daha fazla jeton basabilir"
        );
        require(
          totalSupply().add(numberOfTokens) <= MAX_TOKENS,
          "Mint sayisi toplam arzi asmaktadir!"
        );
        require(
          msg.value >= tokenPrice.mul(numberOfTokens),
          "Gonderilen ETH degeri dogru degildir!"
        );
    
        for (uint256 i = 0; i < numberOfTokens; i++) {
          uint256 id = totalSupply().add(1);
          if (totalSupply() < MAX_TOKENS) {
            _safeMint(msg.sender, id);
            emit NftMinted(id, msg.sender);
          }
        }
      }
    

    // önsatışda kullanıdığımız mint metodu
      function presaleNFT(uint256 numberOfTokens) external payable {
        require(presaleIsActive, "Onsatis aktif degil!");
        require(_presaleList[msg.sender], "Onsatis listesinde yoksunuz!");
        require(
          totalSupply().add(numberOfTokens) <= MAX_TOKENS,
          "Mint sayisi toplam arzi asmaktadir!"
        );
        require(
          numberOfTokens > 0 && numberOfTokens <= presaleMaxMint,
          "Bu kadar fazla NFT mintleyemezsiniz!"
        );
        require(
          _presaleListClaimed[msg.sender].add(numberOfTokens) <= presaleMaxMint,
          "Mintleme izni verilen NFT sayisi asildi!"
        );
        require(
          msg.value >= tokenPrice.mul(numberOfTokens),
          "Gonderilen ETH degeri dogru degildir!"
        );
    
        for (uint256 i = 0; i < numberOfTokens; i++) {
          uint256 id = totalSupply().add(1); //0.json diye pinatada dosyam yok 1 den başlattığım için 1 diyorum.
          //hiç nft mintlenmediği için totalSupply değeri 0'dır. add(1) ile 1 ekletip, 1'den başlatmış oluyorum.
          if (totalSupply() < MAX_TOKENS) {
            _presaleListClaimed[msg.sender] += 1;
            _safeMint(msg.sender, id);
            emit NftMinted(id, msg.sender); //gerçekeşen event'i emit ediyor. 
          }
        }
      }
    

    //adres dizini alır ve aldığı adresleri önsatış listesine ekler.
      function addToPresaleList(address[] calldata addresses) external onlyOwner {
        for (uint256 i = 0; i < addresses.length; i++) {
          require(addresses[i] != address(0), "Bos adres ekleyemezsiniz!");
          _presaleList[addresses[i]] = true;
        }
      }
    
    //adres dizini alır ve aldığı adresleri önsatışdan çıkartır.
      function removeFromPresaleList(address[] calldata addresses)
        external
        onlyOwner
      {
        for (uint256 i = 0; i < addresses.length; i++) {
          require(addresses[i] != address(0), "Can't add the null address");
    
          _presaleList[addresses[i]] = false;
        }
      }
    

    //önsatışdaki max mintleme sayısını değiştirebilir
      function setPresaleMaxMint(uint256 maxMint) external onlyOwner {
        presaleMaxMint = maxMint;
      }
    

    //bir adres önsatış listesinde var mı yok mu onu kontrol eden metod
      function onPreSaleList(address addr) external view returns (bool) {
        return _presaleList[addr];
      }
    

    //NFT URL adresini döndürüyor
      function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
      {
        require(
          _exists(tokenId),
          "ERC721Metadata: Boylebir token yok!"
        );
    
        string memory currentBaseURI = _baseURI();
    
        if (isRevealed == false) { //revealed edilmemişse soru işareti resmini döndür
          return
            "ipfs://Qme1svHAQXujmXbh6c6SM13AoXKFogWUwGQX2c92dmj1aR/hidden.json";
        }

        //proje reveale edildiyse ilgili url return et.
        return
          bytes(currentBaseURI).length > 0
            ? string(abi.encodePacked(currentBaseURI, tokenId.toString(), ".json"))
            : "";
            
      }
    
      function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
      ) internal override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId);
      }
    
      function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
      {
        return super.supportsInterface(interfaceId);
      }

      
    }