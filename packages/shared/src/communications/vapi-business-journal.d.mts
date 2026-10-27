export type VapiBusinessReceiptKey={callId:string;scopeKey:string;toolCallId:string;digest:string};
export class DurableVapiBusinessJournal {
 constructor(storage:{transaction<T>(closure:(tx:{get(key:string):Promise<unknown>;put(key:string,value:unknown):Promise<void>})=>Promise<T>):Promise<T>});
 begin(input:VapiBusinessReceiptKey):Promise<{status:'new'}|{status:'pending';digest:string}|{status:'complete';digest:string;result:string}>;
 complete(input:VapiBusinessReceiptKey&{result:string}):Promise<void>;
}
