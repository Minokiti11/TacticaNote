// @uppy/utils/lib/dataURItoBlob@6.1.1 downloaded from https://ga.jspm.io/npm:@uppy/utils@6.1.1/lib/dataURItoBlob.js

const e=/^data:([^/]+\/[^,;]+(?:[^,]*?))(;base64)?,([\s\S]*)$/;function dataURItoBlob(n,t,l){var o,a;const d=e.exec(n);const c=(o=(a=t.mimeType)!=null?a:d==null?void 0:d[1])!=null?o:"plain/text";let u;if((d==null?void 0:d[2])!=null){const e=atob(decodeURIComponent(d[3]));const n=new Uint8Array(e.length);for(let t=0;t<e.length;t++)n[t]=e.charCodeAt(t);u=[n]}else(d==null?void 0:d[3])!=null&&(u=[decodeURIComponent(d[3])]);return l?new File(u,t.name||"",{type:c}):new Blob(u,{type:c})}export{dataURItoBlob as default};

