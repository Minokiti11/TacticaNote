// shallow-equal@3.1.0 downloaded from https://ga.jspm.io/npm:shallow-equal@3.1.0/dist/index.modern.mjs

function shallowEqualArrays(r,t){if(r===t)return true;if(!r||!t)return false;const e=r.length;if(t.length!==e)return false;for(let l=0;l<e;l++)if(r[l]!==t[l])return false;return true}function shallowEqualObjects(r,t){if(r===t)return true;if(!r||!t)return false;const e=Object.keys(r);const l=Object.keys(t);const s=e.length;if(l.length!==s)return false;for(let l=0;l<s;l++){const s=e[l];if(r[s]!==t[s]||!Object.prototype.hasOwnProperty.call(t,s))return false}return true}function shallowEqual(r,t){const e=Array.isArray(r);const l=Array.isArray(t);return e===l&&(e&&l?shallowEqualArrays(r,t):shallowEqualObjects(r,t))}export{shallowEqual,shallowEqualArrays,shallowEqualObjects};

