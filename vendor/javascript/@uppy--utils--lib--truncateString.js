// @uppy/utils/lib/truncateString@6.1.1 downloaded from https://ga.jspm.io/npm:@uppy/utils@6.1.1/lib/truncateString.js

const t="...";function truncateString(n,e){if(e===0)return"";if(n.length<=e)return n;if(e<=t.length+1)return`${n.slice(0,e-1)}…`;const r=e-t.length;const c=Math.ceil(r/2);const i=Math.floor(r/2);return n.slice(0,c)+t+n.slice(-i)}export{truncateString as default};

