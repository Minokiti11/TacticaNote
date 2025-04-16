// @uppy/utils/lib/getDroppedFiles@6.1.1 downloaded from https://ga.jspm.io/npm:@uppy/utils@6.1.1/lib/getDroppedFiles/index.js

import e from"../toArray.js";function getFilesAndDirectoriesFromDirectory(e,r,t,i){let{onSuccess:n}=i;e.readEntries((i=>{const o=[...r,...i];i.length?queueMicrotask((()=>{getFilesAndDirectoriesFromDirectory(e,o,t,{onSuccess:n})})):n(o)}),(e=>{t(e);n(r)}))}function getAsFileSystemHandleFromEntry(e,r){return e==null?e:{kind:e.isFile?"file":e.isDirectory?"directory":void 0,name:e.name,getFile(){return new Promise(((r,t)=>e.file(r,t)))},async*values(){const t=e.createReader();const i=await new Promise((e=>{getFilesAndDirectoriesFromDirectory(t,[],r,{onSuccess:t=>e(t.map((e=>getAsFileSystemHandleFromEntry(e,r))))})}));yield*i},isSameEntry:void 0}}function createPromiseToAddFileOrParseDirectory(e,r,t){try{t===void 0&&(t=void 0);return async function*(){const getNextRelativePath=()=>`${r}/${e.name}`;if(e.kind==="file"){const i=await e.getFile();if(i!=null){i.relativePath=r?getNextRelativePath():null;yield i}else t!=null&&(yield t)}else if(e.kind==="directory")for await(const t of e.values())yield*createPromiseToAddFileOrParseDirectory(t,r?getNextRelativePath():e.name);else t!=null&&(yield t)}()}catch(e){return Promise.reject(e)}}
/**
 * Load all files from data transfer, and recursively read any directories.
 * Note that IE is not supported for drag-drop, because IE doesn't support Data Transfers
 *
 * @param {DataTransfer} dataTransfer
 * @param {*} logDropError on error
 */async function*getFilesFromDataTransfer(e,r){const t=await Promise.all(Array.from(e.items,(async e=>{var t;let i;const getAsEntry=()=>typeof e.getAsEntry==="function"?e.getAsEntry():e.webkitGetAsEntry();(t=i)!=null?t:i=getAsFileSystemHandleFromEntry(getAsEntry(),r);return{fileSystemHandle:i,lastResortFile:e.getAsFile()}})));for(const{lastResortFile:e,fileSystemHandle:i}of t)if(i!=null)try{yield*createPromiseToAddFileOrParseDirectory(i,"",e)}catch(t){e!=null?yield e:r(t)}else e!=null&&(yield e)}function fallbackApi(r){const t=e(r.files);return Promise.resolve(t)}
/**
 * Returns a promise that resolves to the array of dropped files (if a folder is
 * dropped, and browser supports folder parsing - promise resolves to the flat
 * array of all files in all directories).
 * Each file has .relativePath prop appended to it (e.g. "/docs/Prague/ticket_from_prague_to_ufa.pdf")
 * if browser supports it. Otherwise it's undefined.
 *
 * @param dataTransfer
 * @param options
 * @param options.logDropError - a function that's called every time some
 * folder or some file error out (e.g. because of the folder name being too long
 * on Windows). Notice that resulting promise will always be resolved anyway.
 *
 * @returns {Promise} - Array<File>
 */async function getDroppedFiles(e,r){var t;const i=(t=r==null?void 0:r.logDropError)!=null?t:Function.prototype;try{const r=[];for await(const t of getFilesFromDataTransfer(e,i))r.push(t);return r}catch{return fallbackApi(e)}}export{getDroppedFiles as default};

