// @uppy/store-default@4.2.0 downloaded from https://ga.jspm.io/npm:@uppy/store-default@4.2.0/lib/index.js

function _classPrivateFieldLooseBase(e,t){if(!{}.hasOwnProperty.call(e,t))throw new TypeError("attempted to use private field on non-instance");return e}var e=0;function _classPrivateFieldLooseKey(t){return"__private_"+e+++"_"+t}const t={version:"4.2.0"};var s=_classPrivateFieldLooseKey("callbacks");var a=_classPrivateFieldLooseKey("publish");class DefaultStore{constructor(){Object.defineProperty(this,a,{value:_publish2});this.state={};Object.defineProperty(this,s,{writable:true,value:new Set})}getState(){return this.state}setState(e){const t={...this.state};const s={...this.state,...e};this.state=s;_classPrivateFieldLooseBase(this,a)[a](t,s,e)}subscribe(e){_classPrivateFieldLooseBase(this,s)[s].add(e);return()=>{_classPrivateFieldLooseBase(this,s)[s].delete(e)}}}function _publish2(){for(var e=arguments.length,t=new Array(e),a=0;a<e;a++)t[a]=arguments[a];_classPrivateFieldLooseBase(this,s)[s].forEach((e=>{e(...t)}))}DefaultStore.VERSION=t.version;export{DefaultStore as default};

