// @uppy/utils/lib/findDOMElement@6.1.1 downloaded from https://ga.jspm.io/npm:@uppy/utils@6.1.1/lib/findDOMElement.js

import e from"@uppy/utils/lib/isDOMElement";function findDOMElement(t,n){n===void 0&&(n=document);return typeof t==="string"?n.querySelector(t):e(t)?t:null}export{findDOMElement as default};

