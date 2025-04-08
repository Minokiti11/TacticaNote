// @uppy/utils/lib/getFileType@6.1.1 downloaded from https://ga.jspm.io/npm:@uppy/utils@6.1.1/lib/getFileType.js

import e from"@uppy/utils/lib/getFileNameAndExtension";import t from"@uppy/utils/lib/mimeTypes";function getFileType(n){var i;if(n.type)return n.type;const o=n.name?(i=e(n.name).extension)==null?void 0:i.toLowerCase():null;return o&&o in t?t[o]:"application/octet-stream"}export{getFileType as default};

