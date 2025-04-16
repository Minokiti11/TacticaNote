// @uppy/utils/lib/getSocketHost@6.1.1 downloaded from https://ga.jspm.io/npm:@uppy/utils@6.1.1/lib/getSocketHost.js

function getSocketHost(t){var s;const e=/^(?:https?:\/\/|\/\/)?(?:[^@\n]+@)?(?:www\.)?([^\n]+)/i;const o=(s=e.exec(t))==null?void 0:s[1];const n=/^http:\/\//i.test(t)?"ws":"wss";return`${n}://${o}`}export{getSocketHost as default};

