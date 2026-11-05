import {test} from 'node:test';
import assert from 'node:assert/strict';
import {ThemeControlBase} from '../packages/primecare_ui/web/theme-control-base.ts';
class Example extends ThemeControlBase {
 constructor(root){super(root);this.cleaned=0;}
 listen(target,callback){target.addEventListener('change',callback,{signal:this.abort.signal});}
 dispose(){if(this.endControlScope())this.cleaned++;}
}
test('inherited control scope removes listeners and disposes once',()=>{
 const root={},target=new EventTarget(),control=new Example(root);let calls=0;
 control.listen(target,()=>calls++);target.dispatchEvent(new Event('change'));
 control.dispose();target.dispatchEvent(new Event('change'));control.dispose();
 assert.equal(control.root,root);assert.equal(calls,1);assert.equal(control.cleaned,1);
});
