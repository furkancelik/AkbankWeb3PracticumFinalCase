import React from "react";

export default function Mintable() {
  return (
    <>
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
    </>
  );
}