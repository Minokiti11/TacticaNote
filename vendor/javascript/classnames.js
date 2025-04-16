// classnames@2.5.1 downloaded from https://ga.jspm.io/npm:classnames@2.5.1/index.js

var a={};(function(){var r={}.hasOwnProperty;function classNames(){var a="";for(var r=0;r<arguments.length;r++){var e=arguments[r];e&&(a=appendClass(a,parseValue(e)))}return a}function parseValue(a){if(typeof a==="string"||typeof a==="number")return a;if(typeof a!=="object")return"";if(Array.isArray(a))return classNames.apply(null,a);if(a.toString!==Object.prototype.toString&&!a.toString.toString().includes("[native code]"))return a.toString();var e="";for(var s in a)r.call(a,s)&&a[s]&&(e=appendClass(e,s));return e}function appendClass(a,r){return r?a?a+" "+r:a+r:a}if(a){classNames.default=classNames;a=classNames}else window.classNames=classNames})();var r=a;export{r as default};

