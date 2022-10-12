import React, { useState } from "react";
import Header from "./Header";
import Info from "./Info";
import Mintable from "./Mintable";

export default function Layout() {
  const [status, setStatus] = useState("");

  return (
    <>
      <div className="bg-primary">
        <Header status={status} setStatus={setStatus} />
        <main id="main" className="py-16 bg-red-800 min-h-[calc(100vh_-_5rem)]">
          <div className="container max-w-6xl mx-auto flex flex-row pt-4">
            <div class="basis-2/4 ">
              <Mintable status={status} setStatus={setStatus} />
            </div>
            <div class="basis-2/4">
              <Info />
            </div>
          </div>
        </main>
      </div>
    </>
  );
}
