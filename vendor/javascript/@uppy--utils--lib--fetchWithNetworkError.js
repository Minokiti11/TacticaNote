// @uppy/utils/lib/fetchWithNetworkError@6.1.1 downloaded from https://ga.jspm.io/npm:@uppy/utils@6.1.1/lib/fetchWithNetworkError.js

import r from"@uppy/utils/lib/NetworkError";function fetchWithNetworkError(){return fetch(...arguments).catch((t=>{throw t.name==="AbortError"?t:new r(t)}))}export{fetchWithNetworkError as default};

