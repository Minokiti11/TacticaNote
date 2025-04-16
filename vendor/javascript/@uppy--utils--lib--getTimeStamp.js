// @uppy/utils/lib/getTimeStamp@6.1.1 downloaded from https://ga.jspm.io/npm:@uppy/utils@6.1.1/lib/getTimeStamp.js

function pad(t){return t<10?`0${t}`:t.toString()}function getTimeStamp(){const t=new Date;const e=pad(t.getHours());const n=pad(t.getMinutes());const o=pad(t.getSeconds());return`${e}:${n}:${o}`}export{getTimeStamp as default};

