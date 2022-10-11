import React from "react";
import Header from "./components/Header";
// import logo from "./logo.svg";
// import "./App.css";

function App() {
  return (
    <>
      <div className="bg-primary">
        <Header />

        <main id="main" className="py-16 bg-red-800 min-h-[calc(100vh_-_5rem)]">
          <div className="container max-w-6xl mx-auto flex flex-row pt-4">
            <div class="basis-2/4 ">
              <div className="flex flex-col items-center">
                <img
                  src="/images/preview.gif"
                  width="300"
                  height="300"
                  className="rounded-xl"
                />

                <p className="bg-gray-100 rounded-md text-gray-800 font-extrabold text-lg my-4 py-1 px-3">
                  <span className="text-primary">10</span> / 40
                </p>

                <div className="flex items-center mt-6 text-3xl font-bold text-gray-200">
                  <button className="button" onClick={() => {}}>
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      className="w-6 h-6"
                      fill="none"
                      viewBox="0 0 24 24"
                      stroke="currentColor">
                      <path
                        strokeLinecap="round"
                        strokeLinejoin="round"
                        strokeWidth="2"
                        d="M12 4v16m8-8H4"
                      />
                    </svg>
                  </button>

                  <h2 className="mx-8">10</h2>

                  <button className="button" onClick={() => {}}>
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      className="w-6 h-6"
                      fill="none"
                      viewBox="0 0 24 24"
                      stroke="currentColor">
                      <path
                        strokeLinecap="round"
                        strokeLinejoin="round"
                        strokeWidth="2"
                        d="M20 12H4"
                      />
                    </svg>
                  </button>
                </div>

                <h4 className="mt-2 font-semibold text-center text-white">
                  1 ETH <span className="text-sm text-gray-300"> + GAS</span>
                </h4>

                {/* Mint Button */}
                <button className="mint-button" onClick={() => {}}>
                  Mint now!
                </button>
              </div>

              <div className="flex items-center justify-center mx-15 px-4 py-4 mt-8 font-semibold text-white bg-red-400 rounded-md ">
                Hataları göster
              </div>
            </div>
            <div class="basis-2/4">
              <h1 className="text-5xl text-white font-extrabold mb-8 pb-8 mt-10">
                Akbank Web3 Practicum <br /> Final Case
              </h1>
              <p className="content-text">
                Patika.dev için Akbank Web3 Practicum'un final case'i için
                hazırlanmış NFT Mint contractıdır.
              </p>
              <p className="content-text">
                Yapay zeka ile oluşturulmuş Akbank NFT'leri
              </p>
              <p className="content-text">
                Altın, Gümüş ve Bronz yazıya sahip NFT'leri Mint edebilirsiniz.
              </p>
              <p className="content-text">
                Mint edeceğiniz NFT'nizin değerini üzerindeki altın, gümüş ve
                bronz karakterler belirlemektedir.
              </p>
              <p className="content-text">
                Mint ettiğiniz NFT ile 1.000.000 TL kadar geri ödemesiz kredi
                çekebilirsiniz! Demeyi çok isterdim 😊 ama sadece eğlence amaçlı
                üretilen NFT'ler <i className="font-bold">Georli Test ağında</i>{" "}
                şimdilik hiçbir işlem görmemektedir...
              </p>
            </div>
          </div>
        </main>
        {/* <div className="bg-red-800 h-[2000px]">sd</div> */}
      </div>
    </>
  );
}

export default App;
