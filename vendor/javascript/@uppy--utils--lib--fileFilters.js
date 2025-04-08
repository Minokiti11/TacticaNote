// @uppy/utils/lib/fileFilters@6.1.1 downloaded from https://ga.jspm.io/npm:@uppy/utils@6.1.1/lib/fileFilters.js

function filterNonFailedFiles(r){const hasError=r=>"error"in r&&!!r.error;return r.filter((r=>!hasError(r)))}function filterFilesToEmitUploadStarted(r){return r.filter((r=>{var e;return!((e=r.progress)!=null&&e.uploadStarted)||!r.isRestored}))}export{filterFilesToEmitUploadStarted,filterNonFailedFiles};

