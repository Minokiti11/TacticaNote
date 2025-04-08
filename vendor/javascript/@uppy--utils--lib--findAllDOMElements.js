// @uppy/utils/lib/findAllDOMElements@6.1.1 downloaded from https://ga.jspm.io/npm:@uppy/utils@6.1.1/lib/findAllDOMElements.js

import e from"@uppy/utils/lib/isDOMElement";function findAllDOMElements(t){if(typeof t==="string"){const e=document.querySelectorAll(t);return e.length===0?null:Array.from(e)}return typeof t==="object"&&e(t)?[t]:null}export{findAllDOMElements as default};

