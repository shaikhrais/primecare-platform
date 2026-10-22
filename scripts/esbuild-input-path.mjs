/** Attributed JSON identities in an esbuild metafile are not filesystem paths. */
export function esbuildInputPath(name,input){
 if(input.with===undefined)return name;
 if(!input.with||Object.keys(input.with).length!==1||input.with.type!=='json')throw Error('Unsupported diagnostic import attributes');
 const suffix=/ with \{ type: ['"]json['"] \}$/;
 if(!suffix.test(name))throw Error('Invalid attributed diagnostic input identity');
 return name.replace(suffix,'');
}
