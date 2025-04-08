// @uppy/utils/lib/prettyETA@6.1.1 downloaded from https://ga.jspm.io/npm:@uppy/utils@6.1.1/lib/prettyETA.js

import t from"./secondsToTime.js";function prettyETA(s){const o=t(s);const n=o.hours===0?"":`${o.hours}h`;const r=o.minutes===0?"":`${o.hours===0?o.minutes:` ${o.minutes.toString(10).padStart(2,"0")}`}m`;const e=o.hours!==0?"":`${o.minutes===0?o.seconds:` ${o.seconds.toString(10).padStart(2,"0")}`}s`;return`${n}${r}${e}`}export{prettyETA as default};

