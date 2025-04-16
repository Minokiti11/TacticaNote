// @uppy/utils/lib/remoteFileObjToLocal@6.1.1 downloaded from https://ga.jspm.io/npm:@uppy/utils@6.1.1/lib/remoteFileObjToLocal.js

import e from"./getFileNameAndExtension.js";function remoteFileObjToLocal(n){return{...n,type:n.mimeType,extension:n.name?e(n.name).extension:null}}export{remoteFileObjToLocal as default};

