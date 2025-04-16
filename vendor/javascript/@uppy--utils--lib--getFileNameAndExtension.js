// @uppy/utils/lib/getFileNameAndExtension@6.1.1 downloaded from https://ga.jspm.io/npm:@uppy/utils@6.1.1/lib/getFileNameAndExtension.js

function getFileNameAndExtension(e){const n=e.lastIndexOf(".");return n===-1||n===e.length-1?{name:e,extension:void 0}:{name:e.slice(0,n),extension:e.slice(n+1)}}export{getFileNameAndExtension as default};

