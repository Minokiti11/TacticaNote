// preact/hooks@10.26.4 downloaded from https://ga.jspm.io/npm:preact@10.26.4/hooks/dist/hooks.module.js

import{options as n}from"preact";var t,u,e,o,c=0,i=[],a=n,s=a.__b,l=a.__r,v=a.diffed,m=a.__c,H=a.unmount,E=a.__;function p(n,t){a.__h&&a.__h(u,n,c||t),c=0;var e=u.__H||(u.__H={__:[],__h:[]});return n>=e.__.length&&e.__.push({}),e.__[n]}function d(n){return c=1,h(D,n)}function h(n,e,o){var c=p(t++,2);if(c.t=n,!c.__c&&(c.__=[o?o(e):D(void 0,e),function(n){var t=c.__N?c.__N[0]:c.__[0],u=c.t(t,n);t!==u&&(c.__N=[u,c.__[1]],c.__c.setState({}))}],c.__c=u,!u.__f)){var f=function(n,t,u){if(!c.__c.__H)return!0;var e=c.__c.__H.__.filter((function(n){return!!n.__c}));if(e.every((function(n){return!n.__N})))return!i||i.call(this,n,t,u);var o=c.__c.props!==n;return e.forEach((function(n){if(n.__N){var t=n.__[0];n.__=n.__N,n.__N=void 0,t!==n.__[0]&&(o=!0)}})),i&&i.call(this,n,t,u)||o};u.__f=!0;var i=u.shouldComponentUpdate,a=u.componentWillUpdate;u.componentWillUpdate=function(n,t,u){if(this.__e){var e=i;i=void 0,f(n,t,u),i=e}a&&a.call(this,n,t,u)},u.shouldComponentUpdate=f}return c.__N||c.__}function y(n,e){var o=p(t++,3);!a.__s&&C(o.__H,e)&&(o.__=n,o.u=e,u.__H.__h.push(o))}function _(n,e){var o=p(t++,4);!a.__s&&C(o.__H,e)&&(o.__=n,o.u=e,u.__h.push(o))}function A(n){return c=5,T((function(){return{current:n}}),[])}function F(n,t,u){c=6,_((function(){if("function"==typeof n){var u=n(t());return function(){n(null),u&&"function"==typeof u&&u()}}if(n)return n.current=t(),function(){return n.current=null}}),null==u?u:u.concat(n))}function T(n,u){var e=p(t++,7);return C(e.__H,u)&&(e.__=n(),e.__H=u,e.__h=n),e.__}function q(n,t){return c=8,T((function(){return n}),t)}function x(n){var e=u.context[n.__c],o=p(t++,9);return o.c=n,e?(null==o.__&&(o.__=!0,e.sub(u)),e.props.value):n.__}function P(n,t){a.useDebugValue&&a.useDebugValue(t?t(n):n)}function b(n){var e=p(t++,10),o=d();return e.__=n,u.componentDidCatch||(u.componentDidCatch=function(n,t){e.__&&e.__(n,t),o[1](n)}),[o[0],function(){o[1](void 0)}]}function g(){var n=p(t++,11);if(!n.__){for(var e=u.__v;null!==e&&!e.__m&&null!==e.__;)e=e.__;var o=e.__m||(e.__m=[0,0]);n.__="P"+o[0]+"-"+o[1]++}return n.__}function j(){for(var n;n=i.shift();)if(n.__P&&n.__H)try{n.__H.__h.forEach(z),n.__H.__h.forEach(B),n.__H.__h=[]}catch(t){n.__H.__h=[],a.__e(t,n.__v)}}a.__b=function(n){u=null,s&&s(n)},a.__=function(n,t){n&&t.__k&&t.__k.__m&&(n.__m=t.__k.__m),E&&E(n,t)},a.__r=function(n){l&&l(n),t=0;var o=(u=n.__c).__H;o&&(e===u?(o.__h=[],u.__h=[],o.__.forEach((function(n){n.__N&&(n.__=n.__N),n.u=n.__N=void 0}))):(o.__h.forEach(z),o.__h.forEach(B),o.__h=[],t=0)),e=u},a.diffed=function(n){v&&v(n);var t=n.__c;t&&t.__H&&(t.__H.__h.length&&(1!==i.push(t)&&o===a.requestAnimationFrame||((o=a.requestAnimationFrame)||w)(j)),t.__H.__.forEach((function(n){n.u&&(n.__H=n.u),n.u=void 0}))),e=u=null},a.__c=function(n,t){t.some((function(n){try{n.__h.forEach(z),n.__h=n.__h.filter((function(n){return!n.__||B(n)}))}catch(u){t.some((function(n){n.__h&&(n.__h=[])})),t=[],a.__e(u,n.__v)}})),m&&m(n,t)},a.unmount=function(n){H&&H(n);var t,u=n.__c;u&&u.__H&&(u.__H.__.forEach((function(n){try{z(n)}catch(n){t=n}})),u.__H=void 0,t&&a.__e(t,u.__v))};var N="function"==typeof requestAnimationFrame;function w(n){var t,r=function(){clearTimeout(u),N&&cancelAnimationFrame(t),setTimeout(n)},u=setTimeout(r,100);N&&(t=requestAnimationFrame(r))}function z(n){var t=u,e=n.__c;"function"==typeof e&&(n.__c=void 0,e()),u=t}function B(n){var t=u;n.__c=n.__(),u=t}function C(n,t){return!n||n.length!==t.length||t.some((function(t,u){return t!==n[u]}))}function D(n,t){return"function"==typeof t?t(n):t}export{q as useCallback,x as useContext,P as useDebugValue,y as useEffect,b as useErrorBoundary,g as useId,F as useImperativeHandle,_ as useLayoutEffect,T as useMemo,h as useReducer,A as useRef,d as useState};

