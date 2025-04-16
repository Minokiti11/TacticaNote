// @uppy/utils/lib/Translator@6.1.1 downloaded from https://ga.jspm.io/npm:@uppy/utils@6.1.1/lib/Translator.js

function _classPrivateFieldLooseBase(t,e){if(!{}.hasOwnProperty.call(t,e))throw new TypeError("attempted to use private field on non-instance");return t}var t=0;function _classPrivateFieldLooseKey(e){return"__private_"+t+++"_"+e}function insertReplacement(t,e,r){const s=[];t.forEach((t=>typeof t!=="string"?s.push(t):e[Symbol.split](t).forEach(((t,e,i)=>{t!==""&&s.push(t);e<i.length-1&&s.push(r)}))));return s}
/**
 * Takes a string with placeholder variables like `%{smart_count} file selected`
 * and replaces it with values from options `{smart_count: 5}`
 *
 * @license https://github.com/airbnb/polyglot.js/blob/master/LICENSE
 * taken from https://github.com/airbnb/polyglot.js/blob/master/lib/polyglot.js#L299
 *
 * @param phrase that needs interpolation, with placeholders
 * @param options with values that will be used to replace placeholders
 */function interpolate(t,e){const r=/\$/g;const s="$$$$";let i=[t];if(e==null)return i;for(const t of Object.keys(e))if(t!=="_"){let n=e[t];typeof n==="string"&&(n=r[Symbol.replace](n,s));i=insertReplacement(i,new RegExp(`%\\{${t}\\}`,"g"),n)}return i}const defaultOnMissingKey=t=>{throw new Error(`missing string: ${t}`)};var e=_classPrivateFieldLooseKey("onMissingKey");var r=_classPrivateFieldLooseKey("apply");class Translator{constructor(t,s){let{onMissingKey:i=defaultOnMissingKey}=s===void 0?{}:s;Object.defineProperty(this,r,{value:_apply2});Object.defineProperty(this,e,{writable:true,value:void 0});this.locale={strings:{},pluralize(t){return t===1?0:1}};Array.isArray(t)?t.forEach(_classPrivateFieldLooseBase(this,r)[r],this):_classPrivateFieldLooseBase(this,r)[r](t);_classPrivateFieldLooseBase(this,e)[e]=i}
/**
   * Public translate method
   *
   * @param key
   * @param options with values that will be used later to replace placeholders in string
   * @returns string translated (and interpolated)
   */translate(t,e){return this.translateArray(t,e).join("")}
/**
   * Get a translation and return the translated and interpolated parts as an array.
   *
   * @returns The translated and interpolated parts, in order.
   */translateArray(t,r){let s=this.locale.strings[t];if(s==null){_classPrivateFieldLooseBase(this,e)[e](t);s=t}const i=typeof s==="object";if(i){if(r&&typeof r.smart_count!=="undefined"){const t=this.locale.pluralize(r.smart_count);return interpolate(s[t],r)}throw new Error("Attempted to use a string with plural forms, but no value was given for %{smart_count}")}if(typeof s!=="string")throw new Error("string was not a string");return interpolate(s,r)}}function _apply2(t){if(!(t!=null&&t.strings))return;const e=this.locale;Object.assign(this.locale,{strings:{...e.strings,...t.strings},pluralize:t.pluralize||e.pluralize})}export{Translator as default};

