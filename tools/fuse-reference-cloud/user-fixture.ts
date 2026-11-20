/** Reference-only guest. No identity, backend, production session or settings writes. */
export default function useUser(){return {isGuest:true,data:null,updateUserSettings:async()=>null};}
