// @uppy/provider-views@4.4.1 downloaded from https://ga.jspm.io/npm:@uppy/provider-views@4.4.1/lib/index.js

import{h as e,Fragment as t}from"preact";import i from"classnames";import r from"@uppy/utils/lib/remoteFileObjToLocal";import{useCallback as n,useState as s,useEffect as a,useMemo as o,useRef as l}from"preact/hooks";import c from"@uppy/utils/lib/VirtualList";import u from"p-queue";import{nanoid as d}from"nanoid/non-secure";import{getSafeFileId as p}from"@uppy/utils/lib/generateFileID";import{GoogleDriveIcon as h,GooglePhotosIcon as g}from"./GooglePicker/icons.js";function GoogleIcon(){return e("svg",{width:"26",height:"26",viewBox:"0 0 26 26",xmlns:"http://www.w3.org/2000/svg"},e("g",{fill:"none","fill-rule":"evenodd"},e("circle",{fill:"#FFF",cx:"13",cy:"13",r:"13"}),e("path",{d:"M21.64 13.205c0-.639-.057-1.252-.164-1.841H13v3.481h4.844a4.14 4.14 0 01-1.796 2.716v2.259h2.908c1.702-1.567 2.684-3.875 2.684-6.615z",fill:"#4285F4","fill-rule":"nonzero"}),e("path",{d:"M13 22c2.43 0 4.467-.806 5.956-2.18l-2.908-2.259c-.806.54-1.837.86-3.048.86-2.344 0-4.328-1.584-5.036-3.711H4.957v2.332A8.997 8.997 0 0013 22z",fill:"#34A853","fill-rule":"nonzero"}),e("path",{d:"M7.964 14.71A5.41 5.41 0 017.682 13c0-.593.102-1.17.282-1.71V8.958H4.957A8.996 8.996 0 004 13c0 1.452.348 2.827.957 4.042l3.007-2.332z",fill:"#FBBC05","fill-rule":"nonzero"}),e("path",{d:"M13 7.58c1.321 0 2.508.454 3.44 1.345l2.582-2.58C17.463 4.891 15.426 4 13 4a8.997 8.997 0 00-8.043 4.958l3.007 2.332C8.672 9.163 10.656 7.58 13 7.58z",fill:"#EA4335","fill-rule":"nonzero"}),e("path",{d:"M4 4h18v18H4z"})))}function DefaultForm(t){let{pluginName:i,i18n:r,onAuth:s}=t;const a=i==="Google Drive";const o=n((e=>{e.preventDefault();s()}),[s]);return e("form",{onSubmit:o},a?e("button",{type:"submit",className:"uppy-u-reset uppy-c-btn uppy-c-btn-primary uppy-Provider-authBtn uppy-Provider-btn-google","data-uppy-super-focusable":true},e(GoogleIcon,null),r("signInWithGoogle")):e("button",{type:"submit",className:"uppy-u-reset uppy-c-btn uppy-c-btn-primary uppy-Provider-authBtn","data-uppy-super-focusable":true},r("authenticateWith",{pluginName:i})))}const defaultRenderForm=t=>{let{pluginName:i,i18n:r,onAuth:n}=t;return e(DefaultForm,{pluginName:i,i18n:r,onAuth:n})};function AuthView(t){let{loading:i,pluginName:r,pluginIcon:n,i18n:s,handleAuth:a,renderForm:o=defaultRenderForm}=t;return e("div",{className:"uppy-Provider-auth"},e("div",{className:"uppy-Provider-authIcon"},n()),e("div",{className:"uppy-Provider-authTitle"},s("authenticateWithTitle",{pluginName:r})),o({pluginName:r,i18n:s,loading:i,onAuth:a}))}function User(i){let{i18n:r,logout:n,username:s}=i;return e(t,null,s&&e("span",{className:"uppy-ProviderBrowser-user",key:"username"},s),e("button",{type:"button",onClick:n,className:"uppy-u-reset uppy-c-btn uppy-ProviderBrowser-userLogout",key:"logout"},r("logOut")))}function Breadcrumbs(i){const{openFolder:r,title:n,breadcrumbsIcon:s,breadcrumbs:a,i18n:o}=i;return e("div",{className:"uppy-Provider-breadcrumbs"},e("div",{className:"uppy-Provider-breadcrumbsIcon"},s),a.map(((i,s)=>{var l;return e(t,null,e("button",{key:i.id,type:"button",className:"uppy-u-reset uppy-c-btn",onClick:()=>r(i.id)},i.type==="root"?n:(l=i.data.name)!=null?l:o("unnamed")),a.length===s+1?"":" / ")})))}function Header(t){return e("div",{className:"uppy-ProviderBrowser-header"},e("div",{className:i("uppy-ProviderBrowser-headerBar",!t.showBreadcrumbs&&"uppy-ProviderBrowser-headerBar--simple")},t.showBreadcrumbs&&e(Breadcrumbs,{openFolder:t.openFolder,breadcrumbs:t.breadcrumbs,breadcrumbsIcon:t.pluginIcon&&t.pluginIcon(),title:t.title,i18n:t.i18n}),e(User,{logout:t.logout,username:t.username,i18n:t.i18n})))}function FileIcon(){return e("svg",{"aria-hidden":"true",focusable:"false",className:"uppy-c-icon",width:11,height:14.5,viewBox:"0 0 44 58"},e("path",{d:"M27.437.517a1 1 0 0 0-.094.03H4.25C2.037.548.217 2.368.217 4.58v48.405c0 2.212 1.82 4.03 4.03 4.03H39.03c2.21 0 4.03-1.818 4.03-4.03V15.61a1 1 0 0 0-.03-.28 1 1 0 0 0 0-.093 1 1 0 0 0-.03-.032 1 1 0 0 0 0-.03 1 1 0 0 0-.032-.063 1 1 0 0 0-.03-.063 1 1 0 0 0-.032 0 1 1 0 0 0-.03-.063 1 1 0 0 0-.032-.03 1 1 0 0 0-.03-.063 1 1 0 0 0-.063-.062l-14.593-14a1 1 0 0 0-.062-.062A1 1 0 0 0 28 .708a1 1 0 0 0-.374-.157 1 1 0 0 0-.156 0 1 1 0 0 0-.03-.03l-.003-.003zM4.25 2.547h22.218v9.97c0 2.21 1.82 4.03 4.03 4.03h10.564v36.438a2.02 2.02 0 0 1-2.032 2.032H4.25c-1.13 0-2.032-.9-2.032-2.032V4.58c0-1.13.902-2.032 2.03-2.032zm24.218 1.345l10.375 9.937.75.718H30.5c-1.13 0-2.032-.9-2.032-2.03V3.89z"}))}function FolderIcon(){return e("svg",{"aria-hidden":"true",focusable:"false",className:"uppy-c-icon",style:{minWidth:16,marginRight:3},viewBox:"0 0 276.157 276.157"},e("path",{d:"M273.08 101.378c-3.3-4.65-8.86-7.32-15.254-7.32h-24.34V67.59c0-10.2-8.3-18.5-18.5-18.5h-85.322c-3.63 0-9.295-2.875-11.436-5.805l-6.386-8.735c-4.982-6.814-15.104-11.954-23.546-11.954H58.73c-9.292 0-18.638 6.608-21.737 15.372l-2.033 5.752c-.958 2.71-4.72 5.37-7.596 5.37H18.5C8.3 49.09 0 57.39 0 67.59v167.07c0 .886.16 1.73.443 2.52.152 3.306 1.18 6.424 3.053 9.064 3.3 4.652 8.86 7.32 15.255 7.32h188.487c11.395 0 23.27-8.425 27.035-19.18l40.677-116.188c2.11-6.035 1.43-12.164-1.87-16.816zM18.5 64.088h8.864c9.295 0 18.64-6.607 21.738-15.37l2.032-5.75c.96-2.712 4.722-5.373 7.597-5.373h29.565c3.63 0 9.295 2.876 11.437 5.806l6.386 8.735c4.982 6.815 15.104 11.954 23.546 11.954h85.322c1.898 0 3.5 1.602 3.5 3.5v26.47H69.34c-11.395 0-23.27 8.423-27.035 19.178L15 191.23V67.59c0-1.898 1.603-3.5 3.5-3.5zm242.29 49.15l-40.676 116.188c-1.674 4.78-7.812 9.135-12.877 9.135H18.75c-1.447 0-2.576-.372-3.02-.997-.442-.625-.422-1.814.057-3.18l40.677-116.19c1.674-4.78 7.812-9.134 12.877-9.134h188.487c1.448 0 2.577.372 3.02.997.443.625.423 1.814-.056 3.18z"}))}function VideoIcon(){return e("svg",{"aria-hidden":"true",focusable:"false",style:{width:16,marginRight:4},viewBox:"0 0 58 58"},e("path",{d:"M36.537 28.156l-11-7a1.005 1.005 0 0 0-1.02-.033C24.2 21.3 24 21.635 24 22v14a1 1 0 0 0 1.537.844l11-7a1.002 1.002 0 0 0 0-1.688zM26 34.18V23.82L34.137 29 26 34.18z"}),e("path",{d:"M57 6H1a1 1 0 0 0-1 1v44a1 1 0 0 0 1 1h56a1 1 0 0 0 1-1V7a1 1 0 0 0-1-1zM10 28H2v-9h8v9zm-8 2h8v9H2v-9zm10 10V8h34v42H12V40zm44-12h-8v-9h8v9zm-8 2h8v9h-8v-9zm8-22v9h-8V8h8zM2 8h8v9H2V8zm0 42v-9h8v9H2zm54 0h-8v-9h8v9z"}))}function ItemIcon(t){let{itemIconString:i,alt:r}=t;if(i===null)return null;switch(i){case"file":return e(FileIcon,null);case"folder":return e(FolderIcon,null);case"video":return e(VideoIcon,null);default:return e("img",{src:i,alt:r,referrerPolicy:"no-referrer",loading:"lazy",width:16,height:16})}}function GridItem(t){var i,r;let{file:n,toggleCheckbox:s,className:a,isDisabled:o,restrictionError:l,showTitles:c,children:u=null,i18n:d}=t;return e("li",{className:a,title:o&&l?l:void 0},e("input",{type:"checkbox",className:"uppy-u-reset uppy-ProviderBrowserItem-checkbox uppy-ProviderBrowserItem-checkbox--grid",onChange:s,name:"listitem",id:n.id,checked:n.status==="checked",disabled:o,"data-uppy-super-focusable":true}),e("label",{htmlFor:n.id,"aria-label":(i=n.data.name)!=null?i:d("unnamed"),className:"uppy-u-reset uppy-ProviderBrowserItem-inner"},e(ItemIcon,{itemIconString:n.data.thumbnail||n.data.icon}),c&&((r=n.data.name)!=null?r:d("unnamed")),u))}function ListItem(t){var i,r,n;let{file:s,openFolder:a,className:o,isDisabled:l,restrictionError:c,toggleCheckbox:u,showTitles:d,i18n:p}=t;return e("li",{className:o,title:s.status!=="checked"&&c?c:void 0},e("input",{type:"checkbox",className:"uppy-u-reset uppy-ProviderBrowserItem-checkbox",onChange:u,name:"listitem",id:s.id,checked:s.status==="checked","aria-label":s.data.isFolder?p("allFilesFromFolderNamed",{name:(i=s.data.name)!=null?i:p("unnamed")}):null,disabled:l,"data-uppy-super-focusable":true}),s.data.isFolder?e("button",{type:"button",className:"uppy-u-reset uppy-c-btn uppy-ProviderBrowserItem-inner",onClick:()=>a(s.id),"aria-label":p("openFolderNamed",{name:(r=s.data.name)!=null?r:p("unnamed")})},e("div",{className:"uppy-ProviderBrowserItem-iconWrap"},e(ItemIcon,{itemIconString:s.data.icon})),d&&s.data.name?e("span",null,s.data.name):p("unnamed")):e("label",{htmlFor:s.id,className:"uppy-u-reset uppy-ProviderBrowserItem-inner"},e("div",{className:"uppy-ProviderBrowserItem-iconWrap"},e(ItemIcon,{itemIconString:s.data.icon})),d&&((n=s.data.name)!=null?n:p("unnamed"))))}function Item(t){const{viewType:r,toggleCheckbox:n,showTitles:s,i18n:a,openFolder:o,file:l,utmSource:c}=t;const u=l.type==="folder"?null:l.restrictionError;const d=!!u&&l.status!=="checked";const p={file:l,openFolder:o,toggleCheckbox:n,utmSource:c,i18n:a,viewType:r,showTitles:s,className:i("uppy-ProviderBrowserItem",{"uppy-ProviderBrowserItem--disabled":d},{"uppy-ProviderBrowserItem--noPreview":l.data.icon==="video"},{"uppy-ProviderBrowserItem--is-checked":l.status==="checked"},{"uppy-ProviderBrowserItem--is-partial":l.status==="partial"}),isDisabled:d,restrictionError:u};switch(r){case"grid":return e(GridItem,p);case"list":return e(ListItem,p);case"unsplash":return e(GridItem,p,e("a",{href:`${l.data.author.url}?utm_source=${c}&utm_medium=referral`,target:"_blank",rel:"noopener noreferrer",className:"uppy-ProviderBrowserItem-author",tabIndex:-1},l.data.author.name));default:throw new Error(`There is no such type ${r}`)}}function Browser(t){const{displayedPartialTree:i,viewType:r,toggleCheckbox:n,handleScroll:o,showTitles:l,i18n:u,isLoading:d,openFolder:p,noResultsLabel:h,virtualList:g,utmSource:m}=t;const[y,v]=s(false);a((()=>{const handleKeyUp=e=>{e.key==="Shift"&&v(false)};const handleKeyDown=e=>{e.key==="Shift"&&v(true)};document.addEventListener("keyup",handleKeyUp);document.addEventListener("keydown",handleKeyDown);return()=>{document.removeEventListener("keyup",handleKeyUp);document.removeEventListener("keydown",handleKeyDown)}}),[]);if(d)return e("div",{className:"uppy-Provider-loading"},typeof d==="string"?d:u("loading"));if(i.length===0)return e("div",{className:"uppy-Provider-empty"},h);const renderItem=t=>e(Item,{viewType:r,toggleCheckbox:e=>{var i;e.stopPropagation();e.preventDefault();(i=document.getSelection())==null||i.removeAllRanges();n(t,y)},showTitles:l,i18n:u,openFolder:p,file:t,utmSource:m});return e("div",{className:"uppy-ProviderBrowser-body"},g?e("ul",{className:"uppy-ProviderBrowser-list"},e(c,{data:i,renderRow:renderItem,rowHeight:31})):e("ul",{className:"uppy-ProviderBrowser-list",onScroll:o,role:"listbox",tabIndex:-1},i.map(renderItem)))}const afterOpenFolder=(e,t,i,r,n)=>{const s=t.filter((e=>e.isFolder===true));const a=t.filter((e=>e.isFolder===false));const o=i.type==="folder"&&i.status==="checked";const l=s.map((e=>({type:"folder",id:e.requestPath,cached:false,nextPagePath:null,status:o?"checked":"unchecked",parentId:i.id,data:e})));const c=a.map((e=>{const t=n(e);return{type:"file",id:e.requestPath,restrictionError:t,status:o&&!t?"checked":"unchecked",parentId:i.id,data:e}}));const u={...i,cached:true,nextPagePath:r};const d=e.map((e=>e.id===u.id?u:e));const p=[...d,...l,...c];return p};const afterScrollFolder=(e,t,i,r,n)=>{const s=e.find((e=>e.id===t));const a=i.filter((e=>e.isFolder===true));const o=i.filter((e=>e.isFolder===false));const l={...s,nextPagePath:r};const c=e.map((e=>e.id===l.id?l:e));const u=l.type==="folder"&&l.status==="checked";const d=a.map((e=>({type:"folder",id:e.requestPath,cached:false,nextPagePath:null,status:u?"checked":"unchecked",parentId:l.id,data:e})));const p=o.map((e=>{const t=n(e);return{type:"file",id:e.requestPath,restrictionError:t,status:u&&!t?"checked":"unchecked",parentId:l.id,data:e}}));const h=[...c,...d,...p];return h};const shallowClone=e=>e.map((e=>({...e})));const percolateDown=(e,t,i)=>{const r=e.filter((e=>e.type!=="root"&&e.parentId===t));r.forEach((t=>{t.status=!i||t.type==="file"&&t.restrictionError?"unchecked":"checked";percolateDown(e,t.id,i)}))};const percolateUp=(e,t)=>{const i=e.find((e=>e.id===t));if(i.type==="root")return;const r=e.filter((e=>e.type!=="root"&&e.parentId===i.id&&!(e.type==="file"&&e.restrictionError)));const n=r.every((e=>e.status==="checked"));const s=r.every((e=>e.status==="unchecked"));i.status=n?"checked":s?"unchecked":"partial";percolateUp(e,i.parentId)};const afterToggleCheckbox=(e,t)=>{const i=shallowClone(e);if(t.length>=2){const e=i.filter((e=>e.type!=="root"&&t.includes(e.id)));e.forEach((e=>{e.type==="file"?e.status=e.restrictionError?"unchecked":"checked":e.status="checked"}));e.forEach((e=>{percolateDown(i,e.id,true)}));percolateUp(i,e[0].parentId)}else{const e=i.find((e=>e.id===t[0]));e.status=e.status==="checked"?"unchecked":"checked";percolateDown(i,e.id,e.status==="checked");percolateUp(i,e.parentId)}return i};const recursivelyFetch=async(e,t,i,r,n)=>{let s=[];let a=i.cached?i.nextPagePath:i.id;while(a){const e=await r(a);s=s.concat(e.items);a=e.nextPagePath}const o=s.filter((e=>e.isFolder===true));const l=s.filter((e=>e.isFolder===false));const c=o.map((e=>({type:"folder",id:e.requestPath,cached:false,nextPagePath:null,status:"checked",parentId:i.id,data:e})));const u=l.map((e=>{const t=n(e);return{type:"file",id:e.requestPath,restrictionError:t,status:t?"unchecked":"checked",parentId:i.id,data:e}}));i.cached=true;i.nextPagePath=null;t.push(...u,...c);c.forEach((async i=>{e.add((()=>recursivelyFetch(e,t,i,r,n)))}))};const afterFill=async(e,t,i,r)=>{const n=new u({concurrency:6});const s=shallowClone(e);const a=s.filter((e=>e.type==="folder"&&e.status==="checked"&&(e.cached===false||e.nextPagePath)));a.forEach((e=>{n.add((()=>recursivelyFetch(n,s,e,t,i)))}));n.on("completed",(()=>{const e=s.filter((e=>e.type==="file"&&e.status==="checked")).length;r(e)}));await n.onIdle();return s};var m={afterOpenFolder:afterOpenFolder,afterScrollFolder:afterScrollFolder,afterToggleCheckbox:afterToggleCheckbox,afterFill:afterFill};const shouldHandleScroll=e=>{const{scrollHeight:t,scrollTop:i,offsetHeight:r}=e.target;const n=t-(i+r);return n<50};const handleError=e=>t=>{if(!t.isAuthError)if(t.name!=="AbortError"){e.log(t,"error");t.name==="UserFacingApiError"&&e.info({message:e.i18n("companionError"),details:e.i18n(t.message)},"warning",5e3)}else e.log("Aborting request","warning")};const getClickedRange=(e,t,i,r)=>{const n=t.findIndex((e=>e.id===r));if(n!==-1&&i){const i=t.findIndex((t=>t.id===e));const r=t.slice(Math.min(n,i),Math.max(n,i)+1);return r.map((e=>e.id))}return[e]};function SearchInput(t){let{searchString:i,setSearchString:r,submitSearchString:o,wrapperClassName:l,inputClassName:c,inputLabel:u,clearSearchLabel:p="",showButton:h=false,buttonLabel:g="",buttonCSSClassName:m=""}=t;const onInput=e=>{r(e.target.value)};const y=n((e=>{e.preventDefault();o()}),[o]);const[v]=s((()=>{const e=document.createElement("form");e.setAttribute("tabindex","-1");e.id=d();return e}));a((()=>{document.body.appendChild(v);v.addEventListener("submit",y);return()=>{v.removeEventListener("submit",y);document.body.removeChild(v)}}),[v,y]);return e("section",{className:l},e("input",{className:`uppy-u-reset ${c}`,type:"search","aria-label":u,placeholder:u,value:i,onInput:onInput,form:v.id,"data-uppy-super-focusable":true}),!h&&e("svg",{"aria-hidden":"true",focusable:"false",className:"uppy-c-icon uppy-ProviderBrowser-searchFilterIcon",width:"12",height:"12",viewBox:"0 0 12 12"},e("path",{d:"M8.638 7.99l3.172 3.172a.492.492 0 1 1-.697.697L7.91 8.656a4.977 4.977 0 0 1-2.983.983C2.206 9.639 0 7.481 0 4.819 0 2.158 2.206 0 4.927 0c2.721 0 4.927 2.158 4.927 4.82a4.74 4.74 0 0 1-1.216 3.17zm-3.71.685c2.176 0 3.94-1.726 3.94-3.856 0-2.129-1.764-3.855-3.94-3.855C2.75.964.984 2.69.984 4.819c0 2.13 1.765 3.856 3.942 3.856z"})),!h&&i&&e("button",{className:"uppy-u-reset uppy-ProviderBrowser-searchFilterReset",type:"button","aria-label":p,title:p,onClick:()=>r("")},e("svg",{"aria-hidden":"true",focusable:"false",className:"uppy-c-icon",viewBox:"0 0 19 19"},e("path",{d:"M17.318 17.232L9.94 9.854 9.586 9.5l-.354.354-7.378 7.378h.707l-.62-.62v.706L9.318 9.94l.354-.354-.354-.354L1.94 1.854v.707l.62-.62h-.706l7.378 7.378.354.354.354-.354 7.378-7.378h-.707l.622.62v-.706L9.854 9.232l-.354.354.354.354 7.378 7.378.708-.707-7.38-7.378v.708l7.38-7.38.353-.353-.353-.353-.622-.622-.353-.353-.354.352-7.378 7.38h.708L2.56 1.23 2.208.88l-.353.353-.622.62-.353.355.352.353 7.38 7.38v-.708l-7.38 7.38-.353.353.352.353.622.622.353.353.354-.353 7.38-7.38h-.708l7.38 7.38z"}))),h&&e("button",{className:`uppy-u-reset uppy-c-btn uppy-c-btn-primary ${m}`,type:"submit",form:v.id},g))}const getNumberOfSelectedFiles=e=>{const t=e.filter((t=>{if(t.type==="file"&&t.status==="checked")return true;if(t.type==="folder"&&t.status==="checked"){const i=e.some((e=>e.type!=="root"&&e.parentId===t.id));return!i}return false}));return t.length};function FooterActions(t){let{cancelSelection:r,donePicking:n,i18n:s,partialTree:a,validateAggregateRestrictions:l}=t;const c=o((()=>l(a)),[a,l]);const u=o((()=>getNumberOfSelectedFiles(a)),[a]);return u===0?null:e("div",{className:"uppy-ProviderBrowser-footer"},e("div",{className:"uppy-ProviderBrowser-footer-buttons"},e("button",{className:i("uppy-u-reset uppy-c-btn uppy-c-btn-primary",{"uppy-c-btn--disabled":c}),disabled:!!c,onClick:n,type:"button"},s("selectX",{smart_count:u})),e("button",{className:"uppy-u-reset uppy-c-btn uppy-c-btn-link",onClick:r,type:"button"},s("cancel"))),c&&e("div",{className:"uppy-ProviderBrowser-footer-error"},c))}const getTagFile=(e,t,i)=>{var r,n;const s={id:e.id,source:t.id,name:e.name||e.id,type:e.mimeType,isRemote:true,data:e,preview:e.thumbnail||void 0,meta:{authorName:(r=e.author)==null?void 0:r.name,authorUrl:(n=e.author)==null?void 0:n.url,relativePath:e.relDirPath||null,absolutePath:e.absDirPath},body:{fileId:e.id},remote:{companionUrl:t.opts.companionUrl,url:`${i.fileUrl(e.requestPath)}`,body:{fileId:e.id},providerName:i.name,provider:i.provider,requestClientId:i.provider}};return s};const addFiles=(e,t,i)=>{const r=e.map((e=>getTagFile(e,t,i)));const n=[];const s=[];r.forEach((e=>{t.uppy.checkIfFileAlreadyExists(p(e,t.uppy.getID()))?s.push(e):n.push(e)}));n.length>0&&t.uppy.info(t.uppy.i18n("addedNumFiles",{numFiles:n.length}));s.length>0&&t.uppy.info(`Not adding ${s.length} files because they already exist`);t.uppy.addFiles(n)};const getPath=(e,t,i)=>{const r=t===null?"null":t;if(i[r])return i[r];const n=e.find((e=>e.id===t));if(n.type==="root")return[];const s=[...getPath(e,n.parentId,i),n];i[r]=s;return s};const getCheckedFilesWithPaths=e=>{const t=Object.create(null);const i=e.filter((e=>e.type==="file"&&e.status==="checked"));const r=i.map((i=>{const r=getPath(e,i.id,t);const n=r.findIndex((e=>e.type==="folder"&&e.status==="checked"));const s=r.slice(n);const a=`/${r.map((e=>e.data.name)).join("/")}`;const o=s.length===1?void 0:s.map((e=>e.data.name)).join("/");return{...i.data,absDirPath:a,relDirPath:o}}));return r};const getBreadcrumbs=(e,t)=>{let i=e.find((e=>e.id===t));let r=[];while(true){r=[i,...r];if(i.type==="root")break;const t=i.parentId;i=e.find((e=>e.id===t))}return r};function _classPrivateFieldLooseBase(e,t){if(!{}.hasOwnProperty.call(e,t))throw new TypeError("attempted to use private field on non-instance");return e}var y=0;function _classPrivateFieldLooseKey(e){return"__private_"+y+++"_"+e}const v={version:"4.4.1"};function defaultPickerIcon(){return e("svg",{"aria-hidden":"true",focusable:"false",width:"30",height:"30",viewBox:"0 0 30 30"},e("path",{d:"M15 30c8.284 0 15-6.716 15-15 0-8.284-6.716-15-15-15C6.716 0 0 6.716 0 15c0 8.284 6.716 15 15 15zm4.258-12.676v6.846h-8.426v-6.846H5.204l9.82-12.364 9.82 12.364H19.26z"}))}const getDefaultState=e=>({authenticated:void 0,partialTree:[{type:"root",id:e,cached:false,nextPagePath:null}],currentFolderId:e,searchString:"",didFirstRender:false,username:null,loading:false});var f=_classPrivateFieldLooseKey("abortController");var P=_classPrivateFieldLooseKey("withAbort");class ProviderView{constructor(e,t){Object.defineProperty(this,P,{value:_withAbort2});this.isHandlingScroll=false;this.lastCheckbox=null;Object.defineProperty(this,f,{writable:true,value:void 0});this.validateSingleFile=e=>{const t=r(e);const i=this.plugin.uppy.validateSingleFile(t);return i};this.getDisplayedPartialTree=()=>{const{partialTree:e,currentFolderId:t,searchString:i}=this.plugin.getPluginState();const r=e.filter((e=>e.type!=="root"&&e.parentId===t));const n=i===""?r:r.filter((e=>{var t;return((t=e.data.name)!=null?t:this.plugin.uppy.i18n("unnamed")).toLowerCase().indexOf(i.toLowerCase())!==-1}));return n};this.validateAggregateRestrictions=e=>{const t=e.filter((e=>e.type==="file"&&e.status==="checked"));const i=t.map((e=>e.data));return this.plugin.uppy.validateAggregateRestrictions(i)};this.plugin=e;this.provider=t.provider;const i={viewType:"list",showTitles:true,showFilter:true,showBreadcrumbs:true,loadAllFiles:false,virtualList:false};this.opts={...i,...t};this.openFolder=this.openFolder.bind(this);this.logout=this.logout.bind(this);this.handleAuth=this.handleAuth.bind(this);this.handleScroll=this.handleScroll.bind(this);this.resetPluginState=this.resetPluginState.bind(this);this.donePicking=this.donePicking.bind(this);this.render=this.render.bind(this);this.cancelSelection=this.cancelSelection.bind(this);this.toggleCheckbox=this.toggleCheckbox.bind(this);this.resetPluginState();this.plugin.uppy.on("dashboard:close-panel",this.resetPluginState);this.plugin.uppy.registerRequestClient(this.provider.provider,this.provider)}resetPluginState(){this.plugin.setPluginState(getDefaultState(this.plugin.rootFolderId))}tearDown(){}setLoading(e){this.plugin.setPluginState({loading:e})}cancelSelection(){const{partialTree:e}=this.plugin.getPluginState();const t=e.map((e=>e.type==="root"?e:{...e,status:"unchecked"}));this.plugin.setPluginState({partialTree:t})}async openFolder(e){this.lastCheckbox=null;const{partialTree:t}=this.plugin.getPluginState();const i=t.find((t=>t.id===e));if(i.cached)this.plugin.setPluginState({currentFolderId:e,searchString:""});else{this.setLoading(true);await _classPrivateFieldLooseBase(this,P)[P]((async r=>{let n=e;let s=[];do{const{username:e,nextPagePath:t,items:i}=await this.provider.list(n,{signal:r});this.plugin.setPluginState({username:e});n=t;s=s.concat(i);this.setLoading(this.plugin.uppy.i18n("loadedXFiles",{numFiles:s.length}))}while(this.opts.loadAllFiles&&n);const a=m.afterOpenFolder(t,s,i,n,this.validateSingleFile);this.plugin.setPluginState({partialTree:a,currentFolderId:e,searchString:""})})).catch(handleError(this.plugin.uppy));this.setLoading(false)}}async logout(){await _classPrivateFieldLooseBase(this,P)[P]((async e=>{const t=await this.provider.logout({signal:e});if(t.ok){if(!t.revoked){const e=this.plugin.uppy.i18n("companionUnauthorizeHint",{provider:this.plugin.title,url:t.manual_revoke_url});this.plugin.uppy.info(e,"info",7e3)}this.plugin.setPluginState({...getDefaultState(this.plugin.rootFolderId),authenticated:false})}})).catch(handleError(this.plugin.uppy))}async handleAuth(e){await _classPrivateFieldLooseBase(this,P)[P]((async t=>{this.setLoading(true);await this.provider.login({authFormData:e,signal:t});this.plugin.setPluginState({authenticated:true});await Promise.all([this.provider.fetchPreAuthToken(),this.openFolder(this.plugin.rootFolderId)])})).catch(handleError(this.plugin.uppy));this.setLoading(false)}async handleScroll(e){const{partialTree:t,currentFolderId:i}=this.plugin.getPluginState();const r=t.find((e=>e.id===i));if(shouldHandleScroll(e)&&!this.isHandlingScroll&&r.nextPagePath){this.isHandlingScroll=true;await _classPrivateFieldLooseBase(this,P)[P]((async e=>{const{nextPagePath:n,items:s}=await this.provider.list(r.nextPagePath,{signal:e});const a=m.afterScrollFolder(t,i,s,n,this.validateSingleFile);this.plugin.setPluginState({partialTree:a})})).catch(handleError(this.plugin.uppy));this.isHandlingScroll=false}}async donePicking(){const{partialTree:e}=this.plugin.getPluginState();this.setLoading(true);await _classPrivateFieldLooseBase(this,P)[P]((async t=>{const i=await m.afterFill(e,(e=>this.provider.list(e,{signal:t})),this.validateSingleFile,(e=>{this.setLoading(this.plugin.uppy.i18n("addedNumFiles",{numFiles:e}))}));const r=this.validateAggregateRestrictions(i);if(r){this.plugin.setPluginState({partialTree:i});return}const n=getCheckedFilesWithPaths(i);addFiles(n,this.plugin,this.provider);this.resetPluginState()})).catch(handleError(this.plugin.uppy));this.setLoading(false)}toggleCheckbox(e,t){const{partialTree:i}=this.plugin.getPluginState();const r=getClickedRange(e.id,this.getDisplayedPartialTree(),t,this.lastCheckbox);const n=m.afterToggleCheckbox(i,r);this.plugin.setPluginState({partialTree:n});this.lastCheckbox=e.id}render(t,r){r===void 0&&(r={});const{didFirstRender:n}=this.plugin.getPluginState();const{i18n:s}=this.plugin.uppy;if(!n){this.plugin.setPluginState({didFirstRender:true});this.provider.fetchPreAuthToken();this.openFolder(this.plugin.rootFolderId)}const a={...this.opts,...r};const{authenticated:o,loading:l}=this.plugin.getPluginState();const c=this.plugin.icon||defaultPickerIcon;if(o===false)return e(AuthView,{pluginName:this.plugin.title,pluginIcon:c,handleAuth:this.handleAuth,i18n:this.plugin.uppy.i18n,renderForm:a.renderAuthForm,loading:l});const{partialTree:u,currentFolderId:d,username:p,searchString:h}=this.plugin.getPluginState();const g=getBreadcrumbs(u,d);return e("div",{className:i("uppy-ProviderBrowser",`uppy-ProviderBrowser-viewType--${a.viewType}`)},e(Header,{showBreadcrumbs:a.showBreadcrumbs,openFolder:this.openFolder,breadcrumbs:g,pluginIcon:c,title:this.plugin.title,logout:this.logout,username:p,i18n:s}),a.showFilter&&e(SearchInput,{searchString:h,setSearchString:e=>{this.plugin.setPluginState({searchString:e})},submitSearchString:()=>{},inputLabel:s("filter"),clearSearchLabel:s("resetFilter"),wrapperClassName:"uppy-ProviderBrowser-searchFilter",inputClassName:"uppy-ProviderBrowser-searchFilterInput"}),e(Browser,{toggleCheckbox:this.toggleCheckbox,displayedPartialTree:this.getDisplayedPartialTree(),openFolder:this.openFolder,virtualList:a.virtualList,noResultsLabel:s("noFilesFound"),handleScroll:this.handleScroll,viewType:a.viewType,showTitles:a.showTitles,i18n:this.plugin.uppy.i18n,isLoading:l,utmSource:"Companion"}),e(FooterActions,{partialTree:u,donePicking:this.donePicking,cancelSelection:this.cancelSelection,i18n:s,validateAggregateRestrictions:this.validateAggregateRestrictions}))}}async function _withAbort2(e){var t;(t=_classPrivateFieldLooseBase(this,f)[f])==null||t.abort();const i=new AbortController;_classPrivateFieldLooseBase(this,f)[f]=i;const cancelRequest=()=>{i.abort()};try{this.plugin.uppy.on("dashboard:close-panel",cancelRequest);this.plugin.uppy.on("cancel-all",cancelRequest);await e(i.signal)}finally{this.plugin.uppy.off("dashboard:close-panel",cancelRequest);this.plugin.uppy.off("cancel-all",cancelRequest);_classPrivateFieldLooseBase(this,f)[f]=void 0}}ProviderView.VERSION=v.version;const w={version:"4.4.1"};const b={loading:false,searchString:"",partialTree:[{type:"root",id:null,cached:false,nextPagePath:null}],currentFolderId:null,isInputMode:true};const k={viewType:"grid",showTitles:true,showFilter:true,utmSource:"Companion"};class SearchProviderView{constructor(e,t){this.isHandlingScroll=false;this.lastCheckbox=null;this.validateSingleFile=e=>{const t=r(e);const i=this.plugin.uppy.validateSingleFile(t);return i};this.getDisplayedPartialTree=()=>{const{partialTree:e}=this.plugin.getPluginState();return e.filter((e=>e.type!=="root"))};this.setSearchString=e=>{this.plugin.setPluginState({searchString:e});e===""&&this.plugin.setPluginState({partialTree:[]})};this.validateAggregateRestrictions=e=>{const t=e.filter((e=>e.type==="file"&&e.status==="checked"));const i=t.map((e=>e.data));return this.plugin.uppy.validateAggregateRestrictions(i)};this.plugin=e;this.provider=t.provider;this.opts={...k,...t};this.setSearchString=this.setSearchString.bind(this);this.search=this.search.bind(this);this.resetPluginState=this.resetPluginState.bind(this);this.handleScroll=this.handleScroll.bind(this);this.donePicking=this.donePicking.bind(this);this.cancelSelection=this.cancelSelection.bind(this);this.toggleCheckbox=this.toggleCheckbox.bind(this);this.render=this.render.bind(this);this.resetPluginState();this.plugin.uppy.on("dashboard:close-panel",this.resetPluginState);this.plugin.uppy.registerRequestClient(this.provider.provider,this.provider)}tearDown(){}setLoading(e){this.plugin.setPluginState({loading:e})}resetPluginState(){this.plugin.setPluginState(b)}cancelSelection(){const{partialTree:e}=this.plugin.getPluginState();const t=e.map((e=>e.type==="root"?e:{...e,status:"unchecked"}));this.plugin.setPluginState({partialTree:t})}async search(){const{searchString:e}=this.plugin.getPluginState();if(e!==""){this.setLoading(true);try{const t=await this.provider.search(e);const i=[{type:"root",id:null,cached:false,nextPagePath:t.nextPageQuery},...t.items.map((e=>({type:"file",id:e.requestPath,status:"unchecked",parentId:null,data:e})))];this.plugin.setPluginState({partialTree:i,isInputMode:false})}catch(e){handleError(this.plugin.uppy)(e)}this.setLoading(false)}}async handleScroll(e){const{partialTree:t,searchString:i}=this.plugin.getPluginState();const r=t.find((e=>e.type==="root"));if(shouldHandleScroll(e)&&!this.isHandlingScroll&&r.nextPagePath){this.isHandlingScroll=true;try{const e=await this.provider.search(i,r.nextPagePath);const n={...r,nextPagePath:e.nextPageQuery};const s=t.filter((e=>e.type!=="root"));const a=[n,...s,...e.items.map((e=>({type:"file",id:e.requestPath,status:"unchecked",parentId:null,data:e})))];this.plugin.setPluginState({partialTree:a})}catch(e){handleError(this.plugin.uppy)(e)}this.isHandlingScroll=false}}async donePicking(){const{partialTree:e}=this.plugin.getPluginState();const t=getCheckedFilesWithPaths(e);addFiles(t,this.plugin,this.provider);this.resetPluginState()}toggleCheckbox(e,t){const{partialTree:i}=this.plugin.getPluginState();const r=getClickedRange(e.id,this.getDisplayedPartialTree(),t,this.lastCheckbox);const n=m.afterToggleCheckbox(i,r);this.plugin.setPluginState({partialTree:n});this.lastCheckbox=e.id}render(t,r){r===void 0&&(r={});const{isInputMode:n,searchString:s,loading:a,partialTree:o}=this.plugin.getPluginState();const{i18n:l}=this.plugin.uppy;const c={...this.opts,...r};return n?e(SearchInput,{searchString:s,setSearchString:this.setSearchString,submitSearchString:this.search,inputLabel:l("enterTextToSearch"),buttonLabel:l("searchImages"),wrapperClassName:"uppy-SearchProvider",inputClassName:"uppy-c-textInput uppy-SearchProvider-input",showButton:true,buttonCSSClassName:"uppy-SearchProvider-searchButton"}):e("div",{className:i("uppy-ProviderBrowser",`uppy-ProviderBrowser-viewType--${c.viewType}`)},c.showFilter&&e(SearchInput,{searchString:s,setSearchString:this.setSearchString,submitSearchString:this.search,inputLabel:l("search"),clearSearchLabel:l("resetSearch"),wrapperClassName:"uppy-ProviderBrowser-searchFilter",inputClassName:"uppy-ProviderBrowser-searchFilterInput"}),e(Browser,{toggleCheckbox:this.toggleCheckbox,displayedPartialTree:this.getDisplayedPartialTree(),handleScroll:this.handleScroll,openFolder:async()=>{},noResultsLabel:l("noSearchResults"),viewType:c.viewType,showTitles:c.showTitles,isLoading:a,i18n:l,virtualList:false,utmSource:this.opts.utmSource}),e(FooterActions,{partialTree:o,donePicking:this.donePicking,cancelSelection:this.cancelSelection,i18n:l,validateAggregateRestrictions:this.validateAggregateRestrictions}))}}SearchProviderView.VERSION=w.version;const getAuthHeader=e=>({authorization:`Bearer ${e}`});const S=new Set;let I=false;async function injectScript(e){if(!S.has(e)){await new Promise(((t,i)=>{const r=document.createElement("script");r.src=e;r.addEventListener("load",(()=>t()));r.addEventListener("error",(e=>i(e.error)));document.head.appendChild(r)}));S.add(e)}}async function ensureScriptsInjected(e){await Promise.all([injectScript("https://accounts.google.com/gsi/client"),(async()=>{await injectScript("https://apis.google.com/js/api.js");if(e==="drive"&&!I){await new Promise((e=>gapi.load("client:picker",(()=>e()))));await gapi.client.load("https://www.googleapis.com/discovery/v1/apis/drive/v3/rest");I=true}})()])}async function isTokenValid(e,t){const i=await fetch(`https://www.googleapis.com/oauth2/v1/tokeninfo?access_token=${encodeURIComponent(e)}`,{signal:t});return!!i.ok}async function authorize(e){let{pickerType:t,clientId:i,accessToken:r}=e;const n=await new Promise(((e,n)=>{const s=t==="drive"?["https://www.googleapis.com/auth/drive.file"]:["https://www.googleapis.com/auth/photospicker.mediaitems.readonly"];const a=google.accounts.oauth2.initTokenClient({client_id:i,scope:s.join(" "),callback:e,error_callback:n});r===null?a.requestAccessToken({prompt:"consent"}):a.requestAccessToken({prompt:""})}));if(n.error)throw new Error(`OAuth2 error: ${n.error}`);return n.access_token}async function logout(e){await new Promise((t=>google.accounts.oauth2.revoke(e,t)))}class InvalidTokenError extends Error{constructor(){super("Invalid or expired token");this.name="InvalidTokenError"}}async function showDrivePicker(e){let{token:t,apiKey:i,appId:r,onFilesPicked:n,signal:s}=e;if(!await isTokenValid(t,s))throw new InvalidTokenError;const onPicked=e=>{e.action===google.picker.Action.PICKED&&n(e.docs.map((e=>({platform:"drive",id:e.id,name:e.name,mimeType:e.mimeType}))),t)};const a=(new google.picker.PickerBuilder).enableFeature(google.picker.Feature.NAV_HIDDEN).enableFeature(google.picker.Feature.MULTISELECT_ENABLED).setDeveloperKey(i).setAppId(r).setOAuthToken(t).addView(new google.picker.DocsView(google.picker.ViewId.DOCS).setIncludeFolders(true).setSelectFolderEnabled(false).setMode(google.picker.DocsViewMode.LIST)).setCallback(onPicked).build();a.setVisible(true);s==null||s.addEventListener("abort",(()=>a.dispose()))}async function showPhotosPicker(e){let{token:t,pickingSession:i,onPickingSessionChange:r,signal:n}=e;const s=getAuthHeader(t);let a=i;if(a==null){const e=await fetch("https://photospicker.googleapis.com/v1/sessions",{method:"post",headers:s,signal:n});if(e.status===401){var o;const t=await e.json();if(((o=t.error)==null?void 0:o.status)==="UNAUTHENTICATED")throw new InvalidTokenError}if(!e.ok)throw new Error("Failed to create a session");a=await e.json();r(a)}const l=window.open(a.pickerUri);n==null||n.addEventListener("abort",(()=>l==null?void 0:l.close()))}async function resolvePickedPhotos(e){let{accessToken:t,pickingSession:i,signal:r}=e;const n=getAuthHeader(t);let s;let a=[];do{const e=100;const t=await fetch(`https://photospicker.googleapis.com/v1/mediaItems?${new URLSearchParams({sessionId:i.id,pageSize:String(e)}).toString()}`,{headers:n,signal:r});if(!t.ok)throw new Error("Failed to get a media items");const{mediaItems:o,nextPageToken:l}=await t.json();s=l;a.push(...o)}while(s);a=a.flatMap((e=>e.type==="PHOTO"||e.type==="VIDEO"&&e.mediaFile.mediaFileMetadata.videoMetadata.processingStatus==="READY"?[e]:[]));return a.map((e=>{let{id:t,mediaFile:{mimeType:i,filename:r,baseUrl:n}}=e;return{platform:"photos",id:t,mimeType:i,url:n,name:r}}))}async function pollPickingSession(e){let{pickingSessionRef:t,accessTokenRef:i,signal:r,onFilesPicked:n,onError:s}=e;for(let e=1;;)try{e=t.current!=null?parseFloat(t.current.pollingConfig.pollInterval):1;await Promise.race([new Promise((t=>setTimeout(t,e*1e3))),new Promise(((e,t)=>{r.addEventListener("abort",t)}))]);r.throwIfAborted();const s=i.current;const a=t.current;if(a!=null&&s!=null){const e=getAuthHeader(s);const i=await fetch(`https://photospicker.googleapis.com/v1/sessions/${encodeURIComponent(a.id)}`,{headers:e,signal:r});if(!i.ok)throw new Error("Failed to get session");const o=await i.json();if(o.mediaItemsSet){const e=await resolvePickedPhotos({accessToken:s,pickingSession:a,signal:r});t.current=void 0;n(e,s)}a.pollingConfig.timeoutIn==="0s"&&(t.current=void 0)}}catch(e){if(e instanceof Error&&e.name==="AbortError")return;s(e)}}function useStore(e,t){const[i,r]=s();a((()=>{(async()=>{r(await e.getItem(t))})()}),[t,e]);const o=n((async i=>{r(i);return i==null?e.removeItem(t):e.setItem(t,i)}),[t,e]);return[i,o]}function GooglePickerView(t){let{uppy:i,clientId:r,onFilesPicked:o,pickerType:c,apiKey:u,appId:d,storage:p}=t;const[m,y]=s(false);const[v,f]=useStore(p,`uppy:google-${c}-picker:accessToken`);const P=l();const w=l(v);const b=l(false);const k=n((e=>{i.log("Access token updated");f(e);w.current=e}),[f,i]);a((()=>{w.current=v}),[v]);const S=n((async e=>{let t=v;const doShowPicker=async t=>{if(c==="drive")await showDrivePicker({token:t,apiKey:u,appId:d,onFilesPicked:o,signal:e});else{const onPickingSessionChange=e=>{P.current=e};await showPhotosPicker({token:t,pickingSession:P.current,onPickingSessionChange:onPickingSessionChange,signal:e})}};y(true);try{try{await ensureScriptsInjected(c);t==null&&(t=await authorize({clientId:r,pickerType:c}));if(t==null)throw new Error;await doShowPicker(t);b.current=true;k(t)}catch(e){if(!(e instanceof InvalidTokenError))throw e;i.log("Token is invalid or expired, reauthenticating");t=await authorize({pickerType:c,accessToken:t,clientId:r});await doShowPicker(t);b.current=true;k(t)}}catch(e){if(e instanceof Error&&"type"in e&&e.type==="popup_closed");else{k(null);i.log(e)}}finally{y(false)}}),[v,u,d,r,o,c,k,i]);a((()=>{const e=new AbortController;pollPickingSession({pickingSessionRef:P,accessTokenRef:w,signal:e.signal,onFilesPicked:o,onError:e=>i.log(e)});return()=>e.abort()}),[o,i]);a((()=>{if(v===void 0||b.current)return;const e=new AbortController;S(e.signal);return()=>{b.current||e.abort()}}),[v,S]);const I=n((async()=>{if(v){await logout(v);k(null);P.current=void 0}}),[v,k]);return m?e("div",null,i.i18n("pleaseWait"),"..."):v==null?e(AuthView,{pluginName:c==="drive"?i.i18n("pluginNameGoogleDrive"):i.i18n("pluginNameGooglePhotos"),pluginIcon:c==="drive"?h:g,handleAuth:S,i18n:i.i18n,loading:m}):e("div",{style:{textAlign:"center"}},e("button",{type:"button",className:"uppy-u-reset uppy-c-btn uppy-c-btn-primary",style:{display:"block",marginBottom:"1em"},disabled:m,onClick:()=>S()},c==="drive"?i.i18n("pickFiles"):i.i18n("pickPhotos")),e("button",{type:"button",className:"uppy-u-reset uppy-c-btn",disabled:m,onClick:I},i.i18n("logOut")))}export{GooglePickerView,ProviderView as ProviderViews,SearchInput,SearchProviderView as SearchProviderViews,defaultPickerIcon};

