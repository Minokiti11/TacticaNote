// @uppy/utils/lib/AbortController@6.1.1 downloaded from https://ga.jspm.io/npm:@uppy/utils@6.1.1/lib/AbortController.js

import o from"@uppy/utils/lib/hasProperty";const{AbortController:r}=globalThis;const{AbortSignal:t}=globalThis;const createAbortError=function(r,t){r===void 0&&(r="Aborted");const e=new DOMException(r,"AbortError");t!=null&&o(t,"cause")&&Object.defineProperty(e,"cause",{__proto__:null,configurable:true,writable:true,value:t.cause});return e};export{r as AbortController,t as AbortSignal,createAbortError};

