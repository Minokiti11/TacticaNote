// @uppy/utils/lib/ErrorWithCause@6.1.1 downloaded from https://ga.jspm.io/npm:@uppy/utils@6.1.1/lib/ErrorWithCause.js

import r from"@uppy/utils/lib/hasProperty";class ErrorWithCause extends Error{constructor(s,t){super(s);this.cause=t==null?void 0:t.cause;this.cause&&r(this.cause,"isNetworkError")?this.isNetworkError=this.cause.isNetworkError:this.isNetworkError=false}}export{ErrorWithCause as default};

