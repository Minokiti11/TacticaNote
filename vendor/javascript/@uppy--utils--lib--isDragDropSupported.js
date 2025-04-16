// @uppy/utils/lib/isDragDropSupported@6.1.1 downloaded from https://ga.jspm.io/npm:@uppy/utils@6.1.1/lib/isDragDropSupported.js

function isDragDropSupported(){const o=document.body;return"draggable"in o&&"ondragstart"in o&&"ondrop"in o&&("FormData"in window&&"FileReader"in window)}export{isDragDropSupported as default};

