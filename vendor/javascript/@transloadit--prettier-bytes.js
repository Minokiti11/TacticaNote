// @transloadit/prettier-bytes@0.3.5 downloaded from https://ga.jspm.io/npm:@transloadit/prettier-bytes@0.3.5/dist/prettierBytes.js

var t={};t=function prettierBytes(t){if(typeof t!=="number"||Number.isNaN(t))throw new TypeError("Expected a number, got "+typeof t);const e=t<0;let r=Math.abs(t);e&&(r=-r);if(r===0)return"0 B";const o=["B","KB","MB","GB","TB","PB","EB","ZB","YB"];const n=Math.min(Math.floor(Math.log(r)/Math.log(1024)),o.length-1);const a=Number(r/1024**n);const B=o[n];return`${a>=10||a%1===0?Math.round(a):a.toFixed(1)} ${B}`};var e=t;export{e as default};

