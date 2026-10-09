/** PostgreSQL Int columns are signed int4 values, without adapter coercion. */
export function validDatabaseInteger(value:unknown):value is number {
 return typeof value==='number'&&Number.isInteger(value)&&value>=-2147483648&&value<=2147483647;
}
/** SUM(int4) returns canonical int8 text; retain exact values above Number precision. */
export function validDatabaseIntegerSum(value:unknown):value is string {
 if(typeof value!=='string'||value.length>20||!/^-?(?:0|[1-9]\d*)$/.test(value)||value==='-0')return false;
 const integer=BigInt(value);return integer>=-9223372036854775808n&&integer<=9223372036854775807n;
}
