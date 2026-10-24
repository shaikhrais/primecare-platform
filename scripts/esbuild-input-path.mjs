/** Attributed JSON identities in an esbuild metafile are not filesystem paths. */
export function esbuildInputPath(name,input){
 if(input.with===undefined)return name;
 if(!input.with||Object.keys(input.with).length!==1||input.with.type!=='json')throw Error('Unsupported diagnostic import attributes');
 const suffix=/ with \{ type: ['"]json['"] \}$/;
 // esbuild adds the suffix only when attributed and plain imports coexist.
 // A sole attributed import already has a filesystem identity.
 if(!suffix.test(name))return name;
 return name.replace(suffix,'');
}
