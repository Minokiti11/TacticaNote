// is-network-error@1.1.0 downloaded from https://ga.jspm.io/npm:is-network-error@1.1.0/index.js

const e=Object.prototype.toString;const isError=t=>e.call(t)==="[object Error]";const t=new Set(["network error","Failed to fetch","NetworkError when attempting to fetch resource.","The Internet connection appears to be offline.","Load failed","Network request failed","fetch failed","terminated"]);function isNetworkError(e){const r=e&&isError(e)&&e.name==="TypeError"&&typeof e.message==="string";return!!r&&(e.message==="Load failed"?e.stack===void 0:t.has(e.message))}export{isNetworkError as default};

