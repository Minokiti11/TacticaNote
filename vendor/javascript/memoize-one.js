// memoize-one@6.0.0 downloaded from https://ga.jspm.io/npm:memoize-one@6.0.0/dist/memoize-one.esm.js

var e=Number.isNaN||function ponyfill(e){return"number"===typeof e&&e!==e};function isEqual(t,r){return t===r||!(!e(t)||!e(r))}function areInputsEqual(e,t){if(e.length!==t.length)return false;for(var r=0;r<e.length;r++)if(!isEqual(e[r],t[r]))return false;return true}function memoizeOne(e,t){void 0===t&&(t=areInputsEqual);var r=null;function memoized(){var n=[];for(var l=0;l<arguments.length;l++)n[l]=arguments[l];if(r&&r.lastThis===this&&t(n,r.lastArgs))return r.lastResult;var u=e.apply(this,n);r={lastResult:u,lastArgs:n,lastThis:this};return u}memoized.clear=function clear(){r=null};return memoized}export{memoizeOne as default};

